part of '../register_page.dart';

class _CharacterImageView extends StatelessWidget {
  const _CharacterImageView();

  @override
  Widget build(BuildContext context) {
    final isKeyboardUp = MediaQuery.of(context).viewInsets.bottom > 0;
    if (isKeyboardUp) return const SizedBox.shrink();

    final width = getDefaultWidth(context);
    final height = MediaQuery.of(context).size.height;

    return Stack(
      children: [
        Center(
          child: Image.asset(
            'assets/images/character_image.png',
            width: width * 6 / 7,
            height: (width * 6 / 7) * (228 / 400),
            fit: BoxFit.cover,
          ),
        ),
        Center(
          child: SizedBox(
            width: width * 6 / 7,
            height: (width * 6 / 7) * (228 / 400),
            child: Align(
              alignment: Alignment.topLeft,
              child: Padding(
                padding: EdgeInsets.only(top: height / 70, left: width / 24),
                child: Image.asset(
                  'assets/images/emoji.gif',
                  width: width / 24,
                ),
              ),
            ),
          ),
        ),
        Center(
          child: SizedBox(
            width: width * 6 / 7,
            height: (width * 6 / 7) * (228 / 400),
            child: Align(
              alignment: Alignment.topRight,
              child: Padding(
                padding: EdgeInsets.only(top: height / 70, right: width / 24),
                child: Image.asset(
                  'assets/images/health.gif',
                  width: width / 8,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
