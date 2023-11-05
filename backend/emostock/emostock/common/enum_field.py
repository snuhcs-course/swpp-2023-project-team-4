import enum

from django.db import models
from rest_framework import serializers


def build_enum_field(enum_class: type, *args, **kwargs) -> models.CharField:
    assert issubclass(enum_class, enum.Enum)
    assert "enum_class" not in kwargs
    assert "enum_serializer" not in kwargs
    assert "max_length" not in kwargs

    field = EnumCharField(
        enum_class=enum_class,
        enum_serializer={e.name: e.value for e in enum_class},
        max_length=max(len(e.value) for e in enum_class),
        *args,
        **kwargs,
    )

    return field


class EnumCharField(models.CharField):  # pragma: no cover
    """
    mapper is a dict of {enum name: value}
    """

    def __init__(self, *args, **kwargs):
        self.enum_class = kwargs.get("enum_class")
        self.enum_serializer = kwargs.get("enum_serializer")
        if self.enum_class:
            kwargs.pop("enum_class")
        if self.enum_serializer:
            kwargs.pop("enum_serializer")

        super().__init__(*args, **kwargs)

        # auto-migration support
        if self.enum_class:
            assert issubclass(self.enum_class, enum.Enum)
            assert self.enum_serializer == {e.name: e.value for e in self.enum_class}
            assert self.max_length == max(len(e.value) for e in self.enum_class)

    def deconstruct(self):
        name, path, args, kwargs = super().deconstruct()
        if self.enum_serializer:
            kwargs["enum_serializer"] = self.enum_serializer
        return name, path, args, kwargs

    def from_db_value(self, value, expression, connection):
        if value is None or value == "":
            return None
        for enum_name, enum_value in self.enum_serializer.items():
            if value == enum_value:
                return self.enum_class[enum_name]

        raise ValueError(f"[from_db_value] Invalid value {value} of type {type(value)}")

    def to_python(self, value):
        if value is None or value == "":
            return None
        elif self.enum_class is not None and isinstance(value, self.enum_class):
            return value.value
        elif value in self.enum_serializer:
            return self.enum_class[value].value
        elif value in self.enum_serializer.values():
            return value
        raise ValueError(f"[to_python] Invalid value {value} of type {type(value)}")


class SerializerEnumCharField(serializers.CharField):
    def to_representation(self, value):
        return value.value
