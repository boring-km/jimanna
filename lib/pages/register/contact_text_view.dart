part of '../register_page.dart';

class _ContactTextView extends StatelessWidget {
  const _ContactTextView(this.width);

  final double width;

  @override
  Widget build(BuildContext context) {
    return Text(
      '문의사항은 이근복 목사님께 문의바랍니다.',
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
