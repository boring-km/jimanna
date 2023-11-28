import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:jimanna/consts.dart';
import 'package:jimanna/providers/current_registered_names_provider.dart';
import 'package:qr_flutter/qr_flutter.dart';

class HomePage extends ConsumerWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final names = ref.watch(currentRegisteredNamesProvider);

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
                  if (isMobile) const SizedBox.shrink() else buildQrImageView(),
                  NamesGrid(height, names, isMobile),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  SizedBox NamesGrid(double height, List<String> names, bool isMobile) {
    return SizedBox(
      height: height - 400,
      child: GridView.builder(
        itemCount: names.length,
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
    );
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
