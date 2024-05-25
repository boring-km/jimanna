part of '../register_page.dart';

class _HeaderBottom extends StatelessWidget {
  const _HeaderBottom();

  @override
  Widget build(BuildContext context) {
    final width = getDefaultWidth(context);
    return Text(
      '사랑과 연합을 위한 우리만의 이벤트',
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
