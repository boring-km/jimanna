import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:jimanna/providers/current_registered_names_provider.dart';
import 'package:qr_flutter/qr_flutter.dart';

class HomePage extends ConsumerStatefulWidget {
  const HomePage({super.key});

  @override
  ConsumerState<HomePage> createState() => _HomePageState();
}

class _HomePageState extends ConsumerState<HomePage> {
  final homeUrl = 'https://boring-km.dev/jimanna/home';

  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(milliseconds: 500), () {
      ref.read(currentRegisteredNamesProvider.notifier).loadOnRealTime();
    });
  }

  @override
  Widget build(BuildContext context) {
    final List<String> names = ref.watch(currentRegisteredNamesProvider);

    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Column(
            children: [
              QrImageView(
                data: homeUrl,
                version: QrVersions.auto,
                size: 300.0,
                gapless: false,
              ),
              SizedBox(
                height: 300,
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
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 8,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
