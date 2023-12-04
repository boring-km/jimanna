part of '../register_page.dart';

class _NameInputView extends ConsumerWidget {
  const _NameInputView({
    required this.nameController,
    required this.onPressInputButton,
  });

  final TextEditingController nameController;
  final void Function() onPressInputButton;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final width = getDefaultWidth(context);
    return SizedBox(
      width: width / 2,
      child: TextField(
        controller: nameController,
        onEditingComplete: onPressInputButton,
        style: Theme.of(context).textTheme.displaySmall?.copyWith(
              color: Colors.white,
              letterSpacing: 2,
            ),
        textAlign: TextAlign.center,
        cursorColor: Colors.black,
        decoration: InputDecoration(
          border: const OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(10)),
          ),
          hintText: '이름입력',
          hintStyle: Theme.of(context)
              .textTheme
              .displaySmall
              ?.copyWith(color: Colors.white),
          fillColor: ColorName.cyan,
          filled: true,
          focusColor: Colors.black,
          enabledBorder: buildOutlineInputBorder(),
          disabledBorder: buildOutlineInputBorder(),
          focusedBorder: buildOutlineInputBorder(),
        ),
      ),
    );
  }

  OutlineInputBorder buildOutlineInputBorder() {
    return const OutlineInputBorder(
      borderSide: BorderSide(width: 3),
      borderRadius: BorderRadius.all(Radius.circular(20)),
    );
  }

}
