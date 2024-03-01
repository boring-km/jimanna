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

    final nintendoHeight = ((width * 0.4) / 2330)*973;

    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        children: [
          Center(
            child: Assets.images.drawBackground.image(
              width: width,
              height: height,
              fit: BoxFit.fitHeight,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(30),
            child: SizedBox(
              height: height - 60,
              child: GridView.builder(
                itemCount: teamDraw.teams.length,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  childAspectRatio: 24 / 9,
                ),
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.all(10),
                    child: Stack(children: [
                      Center(
                        child: Assets.images.nintendo.image(
                          width: width * 0.4,
                        ),
                      ),
                      Center(
                        child: SizedBox(
                          width: nintendoHeight * (16 / 9),
                          height: nintendoHeight,
                          child: Stack(
                            children: [
                              Assets.images.resultBackground.image(),
                              TeamNumberText(index),
                              Align(
                                alignment: Alignment.topLeft,
                                child: Padding(
                                  padding:
                                      const EdgeInsets.only(left: 60, top: 80),
                                  child: GradientText(
                                    teamDraw.teams[index].names[0],
                                    gradientDirection: GradientDirection.ttb,
                                    colors: const [Colors.white, Colors.green],
                                    style: const TextStyle(fontSize: 60),
                                  ),
                                ),
                              ),
                              Align(
                                alignment: Alignment.topRight,
                                child: Padding(
                                  padding:
                                      const EdgeInsets.only(right: 60, top: 80),
                                  child: GradientText(
                                    teamDraw.teams[index].names[1],
                                    gradientDirection: GradientDirection.ttb,
                                    colors: const [Colors.white, Colors.green],
                                    style: const TextStyle(fontSize: 60),
                                  ),
                                ),
                              ),
                              if (teamDraw.teams[index].names.length > 2) Align(
                                alignment: Alignment.bottomLeft,
                                child: Padding(
                                  padding: const EdgeInsets.only(
                                      left: 60, bottom: 60),
                                  child: GradientText(
                                    teamDraw.teams[index].names[2],
                                    gradientDirection: GradientDirection.ttb,
                                    colors: const [Colors.white, Colors.green],
                                    style: const TextStyle(fontSize: 60),
                                  ),
                                ),
                              ) else Container(),
                              if (teamDraw.teams[index].names.length > 3) Align(
                                alignment: Alignment.bottomRight,
                                child: Padding(
                                  padding: const EdgeInsets.only(
                                      right: 60, bottom: 60),
                                  child: GradientText(
                                    teamDraw.teams[index].names[3],
                                    gradientDirection: GradientDirection.ttb,
                                    colors: const [Colors.white, Colors.green],
                                    style: const TextStyle(fontSize: 60),
                                  ),
                                ),
                              ) else Container(),
                            ],
                          ),
                        ),
                      ),
                    ]),
                  );
                },
              ),
            ),
          ),
          BottomText(context, width, height),
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
