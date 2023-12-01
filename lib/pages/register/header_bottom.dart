part of '../register_page.dart';

class _HeaderBottom extends StatelessWidget {
  const _HeaderBottom(this.width);

  final double width;

  @override
  Widget build(BuildContext context) {
    return Text(
      '화합과 사랑을 위한 우리만의 이벤트',
      style: Theme.of(context)
          .textTheme
          .displaySmall
          ?.copyWith(
        color: Colors.white,
        fontSize: width / 24,
      ),
    );
  }
}
