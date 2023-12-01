part of '../register_page.dart';

class _InputButtonView extends StatelessWidget {
  const _InputButtonView({
    required this.onPressInputButton,
    required this.width,
  });

  final void Function() onPressInputButton;
  final double width;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressInputButton,
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.transparent,
        shadowColor: Colors.transparent,
      ),
      child: Image.asset(
        'assets/images/confirm_button.png',
        width: width * (2 / 3),
      ),
    );
  }
}
