part of '../register_page.dart';

class _ErrorTextView extends ConsumerWidget {
  const _ErrorTextView(this.width, this.height, {super.key});

  final double width;
  final double height;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final errorText = ref.watch(registerErrorProvider);
    return Padding(
      padding: EdgeInsets.symmetric(vertical: height / 100),
      child: errorText.isEmpty
          ? const SizedBox.shrink()
          : Text(
        errorText,
        style: Theme.of(context)
            .textTheme
            .displaySmall
            ?.copyWith(color: Colors.white, fontSize: width / 30),
      ),
    );
  }
}
