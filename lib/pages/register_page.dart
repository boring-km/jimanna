import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:jimanna/ui/background_painter.dart';
import 'package:jimanna/providers/name_register_provider.dart';
import 'package:jimanna/routes.dart';
import 'package:jimanna/ui/frame_painter.dart';

class RegisterPage extends ConsumerStatefulWidget {
  const RegisterPage({super.key});

  @override
  ConsumerState<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends ConsumerState<RegisterPage> {
  final _nameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    processNameRegister(context);

    var width = MediaQuery.of(context).size.width;
    if (width > 740) width = 740;

    final height = MediaQuery.of(context).size.height;

    return Scaffold(
      body: CustomPaint(
        painter: BackgroundPainter(),
        child: Stack(
          children: [
            Center(
              child: CustomPaint(
                painter: FramePainter(),
                child: Padding(
                  padding: const EdgeInsets.all(20),
                  child: SingleChildScrollView(
                    child: Padding(
                      padding: const EdgeInsets.only(top: 20, bottom: 10),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          Row(
                            mainAxisSize: MainAxisSize.min,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Image.asset('assets/images/star.gif', width: width / 10),
                              const SizedBox(width: 10),
                              Text(
                                '아바드',
                                style: Theme.of(context)
                                    .textTheme
                                    .displayLarge
                                    ?.copyWith(
                                        color: Colors.white, fontSize: width / 8),
                              ),
                              const SizedBox(width: 10),
                              Image.asset('assets/images/star.gif', width: width / 10),
                            ],
                          ),
                          SizedBox(height: height / 80),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text(
                                '지금우리',
                                style: Theme.of(context)
                                    .textTheme
                                    .displayMedium
                                    ?.copyWith(
                                        color: Colors.white, fontSize: width / 12),
                              ),
                              Image.asset('assets/images/heart.gif', width: width / 8),
                              Text(
                                '만나',
                                style: Theme.of(context)
                                    .textTheme
                                    .displayMedium
                                    ?.copyWith(
                                        color: Colors.white, fontSize: width / 12),
                              ),
                            ],
                          ),
                          SizedBox(height: height / 80),
                          Text(
                            '화합과 사랑을 위한 우리만의 이벤트',
                            style: Theme.of(context)
                                .textTheme
                                .displaySmall
                                ?.copyWith(color: Colors.white, fontSize: width / 24),
                          ),
                          SizedBox(height: height / 60),
                          CharacterImage(width, height),
                          SizedBox(height: height / 30),
                          SizedBox(
                            width: width / 2,
                            child: TextField(
                              controller: _nameController,
                              style: Theme.of(context)
                                  .textTheme
                                  .displaySmall
                                  ?.copyWith(color: Colors.white, letterSpacing: 2),
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
                                fillColor: const Color(0xFF6BCDFF),
                                filled: true,
                                focusColor: Colors.black,
                                enabledBorder: buildOutlineInputBorder(),
                                disabledBorder: buildOutlineInputBorder(),
                                focusedBorder: buildOutlineInputBorder(),
                              ),
                            ),
                          ),
                          SizedBox(height: height / 40),
                          NameInputButton(width),
                          SizedBox(height: height / 40),
                          Text(
                            '문의사항은 이근복 목사님께 문의바랍니다.',
                            style: Theme.of(context)
                                .textTheme
                                .displaySmall
                                ?.copyWith(color: Colors.white, fontSize: width / 30),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Padding(
                padding: EdgeInsets.only(bottom: height / 70),
                child: Text(
                  '아바드',
                  style: Theme.of(context)
                      .textTheme
                      .displaySmall
                      ?.copyWith(color: Colors.white),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget CharacterImage(double width, double height) {
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
                padding: EdgeInsets.only(top: height / 70, left: (width / 24)),
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
                padding: EdgeInsets.only(top: height / 70, right: (width / 24)),
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

  ElevatedButton NameInputButton(double width) {
    return ElevatedButton(
      onPressed: () {
        ref
            .read(nameRegisterProvider.notifier)
            .registerNameToFirestore(_nameController.text);
      },
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.transparent,
        shadowColor: Colors.transparent,
      ),
      child: Image.asset(
        'assets/images/confirm_button.png',
        width: width * (2 / 3),
      ),
    );
  }

  void processNameRegister(BuildContext context) {
    ref.listen(nameRegisterProvider, (previous, result) {
      result.whenOrNull(
        error: (e) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(e.toString()),
            ),
          );
        },
        success: (data) {
          if (data) {
            Navigator.pushNamed(context, Routes.home);
          }
        },
      );
    });
  }

  OutlineInputBorder buildOutlineInputBorder() {
    return const OutlineInputBorder(
      borderSide: BorderSide(color: Colors.black, width: 3),
      borderRadius: BorderRadius.all(Radius.circular(20)),
    );
  }
}
