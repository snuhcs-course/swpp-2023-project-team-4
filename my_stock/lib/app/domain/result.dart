sealed class Result<D, I extends Enum?> {
  factory Result.success(D data) {
    return Success<D, I>(data);
  }

  factory Result.fail(I issue) {
    return Fail<D, I>(issue);
  }
}

class Success<D, I extends Enum?> implements Result<D, I> {
  Success(this.data);

  final D data;
}

class Fail<D, I extends Enum?> implements Result<D, I> {
  Fail(this.issue);

  final I issue;
}

enum DefaultIssue {
  unknown,
  badRequest,
  unAuthorized,
}
