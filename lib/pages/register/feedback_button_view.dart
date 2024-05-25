part of '../register_page.dart';

class _FeedbackButtonView extends StatelessWidget {
  const _FeedbackButtonView({
    required this.onPressFeedbackButton,
  });

  final void Function() onPressFeedbackButton;

  @override
  Widget build(BuildContext context) {
    final width = getDefaultWidth(context);
    return GestureDetector(
      onTap: onPressFeedbackButton,
      child: Padding(
        padding: const EdgeInsets.all(8),
        child: Text(
          '피드백 남기기',
          style: Theme.of(context)
              .textTheme
              .displaySmall
              ?.copyWith(
            color: Colors.white,
            fontSize: width / 30,
          ),
        ),
      ),
    );
  }
}