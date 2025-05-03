import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:jimanna/gen/assets.gen.dart';
import 'package:jimanna/providers/admin_draw_provider.dart';
import 'package:jimanna/ui/ongmezim_text.dart';
import 'package:simple_gradient_text/simple_gradient_text.dart';

class DrawTotalResultPage extends ConsumerWidget {
  const DrawTotalResultPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;

    final teamDraw = ref.watch(adminDrawProvider);
    final teams = teamDraw.teams;

    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        children: [
          Center(
            child: Assets.images.drawResultBackground.image(
              width: width,
              height: height,
              fit: BoxFit.fitHeight,
            ),
          ),
          Container(
            width: width,
            height: height,
            decoration: BoxDecoration(
              color: const Color(0x11FFFFFF),
              borderRadius: BorderRadius.circular(20),
            ),
          ),
          Center(
            child: Container(
              decoration: BoxDecoration(
                color: const Color(0x66000000),
                borderRadius: BorderRadius.circular(20),
              ),
              padding: const EdgeInsets.all(40),
              child: SingleChildScrollView(
                  child: Column(
                children: List.generate(
                  teams.length,
                  (index) {
                    return Padding(
                      padding: const EdgeInsets.only(bottom: 60),
                      child: Column(
                        children: [
                          Text(
                            '${index + 1}조',
                            style: Theme.of(context).textTheme.displayMedium!.copyWith(color: Colors.white, fontSize: 60),
                          ),
                          const SizedBox(height: 30, width: 0),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              for (final name in teams[index].names)
                                Padding(
                                  padding: const EdgeInsets.all(8),
                                  child: Text(
                                    name.name,
                                    style: Theme.of(context).textTheme.displayMedium!.copyWith(color: Colors.white, fontSize: 40),
                                  ),
                                ),
                            ],
                          ),
                        ],
                      ),
                    );
                  },
                ),
              )),
            ),
          ),
          BottomText(context, width, height),
          Align(
            alignment: Alignment.bottomLeft,
            child: Assets.images.kangmin.image(width: 100, height: 100),
          ),
          Align(
            alignment: Alignment.bottomLeft,
            child: Padding(
              padding: const EdgeInsets.only(left: 80, bottom: 50),
              child: Assets.images.chatBubble3.image(width: 160),
            ),
          ),
          Align(
            alignment: Alignment.bottomLeft,
            child: Padding(
              padding: const EdgeInsets.only(left: 95, bottom: 78),
              child: Text(
                '이번엔 문제가 없었겠지..?',
                style: Theme.of(context).textTheme.displaySmall!.copyWith(
                  color: Colors.black,
                  fontSize: 10,
                  shadows: [],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Align TeamNumberText(int index) {
    return Align(
      alignment: Alignment.topCenter,
      child: Padding(
        padding: const EdgeInsets.only(top: 10),
        child: GradientText(
          '${index + 1}조',
          gradientDirection: GradientDirection.ttb,
          colors: const [Colors.white, Color(0xffed8629)],
          style: const TextStyle(fontSize: 60),
        ),
      ),
    );
  }

  Widget BottomText(BuildContext context, double width, double height) {
    return Align(
      alignment: Alignment.bottomRight,
      child: SizedBox(
        height: height * 0.05,
        child: Padding(
          padding: const EdgeInsets.only(right: 16),
          child: ongmezimText(context, width / 2),
        ),
      ),
    );
  }
}
