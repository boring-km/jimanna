part of '../register_page.dart';

class _HeaderTop extends StatelessWidget {
  const _HeaderTop(this.width);

  final double width;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Image.asset(
          'assets/images/star.gif',
          width: width / 10,
        ),
        const SizedBox(width: 10),
        Text(
          '아바드',
          style: Theme.of(context).textTheme.displayLarge?.copyWith(
                color: Colors.white,
                fontSize: width / 8,
              ),
        ),
        const SizedBox(width: 10),
        Image.asset(
          'assets/images/star.gif',
          width: width / 10,
        ),
      ],
    );
  }
}
