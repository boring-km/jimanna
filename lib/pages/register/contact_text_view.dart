part of '../register_page.dart';

class _ContactTextView extends StatelessWidget {
  const _ContactTextView();

  @override
  Widget build(BuildContext context) {
    final width = getDefaultWidth(context);
    return Text(
      '혹시 등록이 오류가 난다면\n옆에 사람한테 대신 등록해달라고 해보세요',
      style: Theme.of(context)
          .textTheme
          .displaySmall
          ?.copyWith(
        color: Colors.white,
        fontSize: width / 40,
      ),
      textAlign: TextAlign.center,
    );
  }
}
