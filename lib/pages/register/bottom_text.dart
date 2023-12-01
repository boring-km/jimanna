part of '../register_page.dart';

class _BottomText extends StatelessWidget {
  const _BottomText(this.height);

  final double height;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: height / 70),
      child: Text(
        '아바드',
        style: Theme.of(context)
            .textTheme
            .displaySmall
            ?.copyWith(color: Colors.white),
      ),
    );
  }
}
