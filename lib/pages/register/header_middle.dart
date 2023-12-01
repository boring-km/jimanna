part of '../register_page.dart';

class _HeaderMiddle extends StatelessWidget {
  const _HeaderMiddle(this.width);

  final double width;

  @override
  Widget build(BuildContext context) {

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          '지금우리',
          style: Theme.of(context)
              .textTheme
              .displayMedium
              ?.copyWith(
            color: Colors.white,
            fontSize: width / 12,
          ),
        ),
        Image.asset(
          'assets/images/heart.gif',
          width: width / 8,
        ),
        Text(
          '만나',
          style: Theme.of(context)
              .textTheme
              .displayMedium
              ?.copyWith(
            color: Colors.white,
            fontSize: width / 12,
          ),
        ),
      ],
    );
  }
}
