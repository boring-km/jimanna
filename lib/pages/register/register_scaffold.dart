part of '../register_page.dart';

class _Scaffold extends ConsumerWidget {
  const _Scaffold({
    required this.headerTop,
    required this.headerMiddle,
    required this.headerBottom,
    required this.characterImageView,
    required this.nameInputView,
    required this.errorTextView,
    required this.inputButtonView,
    required this.contactTextView,
    required this.bottomText,
  });

  final Widget headerTop;
  final Widget headerMiddle;
  final Widget headerBottom;

  final Widget characterImageView;
  final Widget nameInputView;
  final Widget errorTextView;
  final Widget inputButtonView;
  final Widget contactTextView;

  final Widget bottomText;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final height = MediaQuery.of(context).size.height;
    processNameRegister(context, ref);
    return Scaffold(
      backgroundColor: ColorName.blueDark,
      body: CustomPaint(
        painter: BackgroundPainter(),
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CustomPaint(
                  painter: FramePainter(),
                  child: Padding(
                    padding: const EdgeInsets.all(20),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        headerTop,
                        SizedBox(height: height / 80),
                        headerMiddle,
                        SizedBox(height: height / 80),
                        headerBottom,
                        SizedBox(height: height / 60),
                        characterImageView,
                        SizedBox(height: height / 60),
                        nameInputView,
                        errorTextView,
                        inputButtonView,
                        SizedBox(height: height / 80),
                        contactTextView,
                      ],
                    ),
                  ),
                ),
                bottomText,
              ],
            ),
          ),
        ),
      ),
    );
  }

  void processNameRegister(
    BuildContext context,
    WidgetRef ref,
  ) {
    ref
      .listen(nameRegisterProvider, (previous, result) {
        result.whenOrNull(
          error: (e) {
            ref.read(registerStateProvider.notifier).setError(e);
          },
          success: (page) {
            Navigator.pushNamed(context, page);
          },
        );
      });
  }
}
