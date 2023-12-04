part of '../register_page.dart';

class _ErrorTextView extends ConsumerWidget {
  const _ErrorTextView(this.registerState);

  final RegisterState registerState;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final width = getDefaultWidth(context);
    final height = MediaQuery.of(context).size.height;

    return Padding(
      padding: EdgeInsets.symmetric(vertical: height / 100),
      child: Text(
        registerState.errorText,
        style: Theme.of(context)
            .textTheme
            .displaySmall
            ?.copyWith(color: Colors.white, fontSize: width / 30),
      ),
    );
  }
}
