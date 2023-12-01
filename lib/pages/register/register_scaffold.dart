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
    required this.onSetNotPossibleToRegister,
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

  final void Function() onSetNotPossibleToRegister;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final height = MediaQuery.of(context).size.height;
    processNameRegister(context, ref, onSetNotPossibleToRegister);
    return Scaffold(
      backgroundColor: ColorName.blueDark,
      body: CustomPaint(
        painter: BackgroundPainter(),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CustomPaint(
                painter: FramePainter(),
                child: Padding(
                    padding: const EdgeInsets.all(20),
                    child: SingleChildScrollView(
                      reverse: true,
                      padding: const EdgeInsets.only(top: 20, bottom: 10),
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
                          contactTextView
                        ],
                      ),
                    )),
              ),
              bottomText,
            ],
          ),
        ),
      ),
    );
  }

  void processNameRegister(
    BuildContext context,
    WidgetRef ref,
    void Function() onSetNotPossibleToRegister,
  ) {
    ref
      ..listen(nameRegisterProvider, (previous, result) {
        result.whenOrNull(
          error: (e) {
            ref.read(registerErrorProvider.notifier).setError(e);
          },
          success: (page) {
            Navigator.pushNamed(context, page);
          },
        );
      })
      ..listen(eventSwitchProvider, (previous, next) {
        if (next is Success<bool>) {
          if (!next.data) {
            onSetNotPossibleToRegister();
          }
        }
      });
  }
}
