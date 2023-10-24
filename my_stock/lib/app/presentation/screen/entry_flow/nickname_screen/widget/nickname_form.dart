part of '../nickname_screen.dart';

class NicknameForm extends StatelessWidget {
  final TextEditingController controller;

  const NicknameForm(this.controller, {super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      child: TextFormField(
        controller: controller,
        style: OtherTextStyle.button.black,
        decoration: InputDecoration(
          contentPadding: EdgeInsets.all(20),
          isCollapsed: true,
          hintText: "닉네임을 입력해주세요",
          hintStyle: OtherTextStyle.button.writeText,
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20),
            borderSide: BorderSide(
              color: StrokeColor.writeText,
              width: 2,
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20),
            borderSide: BorderSide(
              color: StrokeColor.button,
              width: 2,
              strokeAlign: BorderSide.strokeAlignOutside,
            ),
          ),
        ),
      ),
    );
  }
}
