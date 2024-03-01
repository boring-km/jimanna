part of '../register_page.dart';

class _ContactTextView extends StatelessWidget {
  const _ContactTextView();

  @override
  Widget build(BuildContext context) {
    final width = getDefaultWidth(context);
    return Text(
      '문의사항은 아바드 임원들에게 문의바랍니다.',
      style: Theme.of(context)
          .textTheme
          .displaySmall
          ?.copyWith(
        color: Colors.white,
        fontSize: width / 30,
      ),
    );
  }
}
