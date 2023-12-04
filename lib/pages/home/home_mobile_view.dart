import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:jimanna/gen/assets.gen.dart';
import 'package:jimanna/gen/colors.gen.dart';
import 'package:jimanna/providers/current_registered_names_provider.dart';
import 'package:jimanna/ui/background_painter.dart';
import 'package:jimanna/ui/bottom_text.dart';
import 'package:jimanna/ui/frame_painter.dart';

class HomeMobileView extends ConsumerWidget {
  const HomeMobileView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final height = MediaQuery.of(context).size.height;
    final names = ref.watch(currentRegisteredNamesProvider);

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
                const BottomText(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
