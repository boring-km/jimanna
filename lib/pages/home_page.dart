import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:jimanna/consts.dart';
import 'package:jimanna/providers/current_registered_names_provider.dart';
import 'package:qr_flutter/qr_flutter.dart';

class HomePage extends ConsumerWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final List<String> names = ref.watch(currentRegisteredNamesProvider);

    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;

    final isMobile = width < 787;

    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            Center(
              child: Column(
                children: [
                  isMobile ? const SizedBox.shrink() : buildQrImageView(),
                  SizedBox(
                    height: height - 400,
                    child: GridView.builder(
                      itemCount: names.length,
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: Colors.green,
                            ),
                            child: Center(
                              child: Text(
                                names[index],
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
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildQrImageView() {
    return QrImageView(
      data: homeUrl,
      version: QrVersions.auto,
      size: 300.0,
      gapless: false,
    );
  }
}
