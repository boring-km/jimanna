import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:jimanna/consts.dart';
import 'package:jimanna/gen/assets.gen.dart';
import 'package:jimanna/gen/colors.gen.dart';
import 'package:jimanna/pages/home/home_desktop_view.dart';
import 'package:jimanna/pages/home/home_mobile_view.dart';
import 'package:jimanna/ui/background_painter.dart';
import 'package:jimanna/ui/bottom_text.dart';
import 'package:jimanna/ui/frame_painter.dart';
import 'package:qr_flutter/qr_flutter.dart';

class HomePage extends ConsumerWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;

    final isMobile = width < 787 || height < 787;

    return Scaffold(
      body: isMobile ? const HomeMobileView() : const HomeDesktopView(),
    );
  }

  Widget mobileBody(double height, List<String> names) {
    return CustomPaint(
      painter: BackgroundPainter(),
      child: Center(
        child: Padding(
          padding: const EdgeInsets.only(top: 20, left: 5, right: 5, bottom: 20),
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                CustomPaint(
                  painter: FramePainter(),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 40),
                    child: Column(
                      children: [
                        Assets.images.homeImage.image(),
                        SizedBox(
                          height: height * (3/5),
                          child: GridView.builder(
                            itemCount: names.length,
                            itemBuilder: (context, index) {
                              return Padding(
                                padding: const EdgeInsets.all(10),
                                child: Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    color: ColorName.cyan,
                                  ),
                                  child: Center(
                                    child: Text(
                                      names[index],
                                      style: Theme.of(context).textTheme.displaySmall?.copyWith(
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                                ),
                              );
                            },
                            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 3,
                              childAspectRatio: 2,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                BottomText(height),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget desktopBody(double height, List<String> names) {
    return buildQrImageView();
  }

  Widget buildQrImageView() {
    return QrImageView(
      data: homeUrl,
      size: 300,
      gapless: false,
    );
  }

  Widget TeamsGrid(double height, List<List<String>> teams, bool isMobile) {
    return SizedBox(
      height: height - 400,
      child: GridView.builder(
        itemCount: teams.length,
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.all(8),
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Colors.green,
              ),
              child: Center(
                child: Text(
                  teams[index].join('\n'),
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontSize: 20,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          );
        },
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: isMobile ? 4 : 8,
        ),
      ),
    );
  }
}
