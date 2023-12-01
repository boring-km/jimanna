import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:jimanna/providers/admin_draw_provider.dart';

class AdminDrawResultPage extends ConsumerWidget {
  const AdminDrawResultPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final teamDraw = ref.watch(adminDrawProvider);

    return Scaffold(
      body: Center(
        child: Column(
          children: [
            SizedBox(
              height: 500,
              child: ListView.builder(
                itemCount: teamDraw.groupNumber,
                itemBuilder: (context, index) {
                  return Column(
                    children: [
                      Text('조 ${index + 1}'),
                      SizedBox(
                        height: 50,
                        child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          shrinkWrap: true,
                          itemCount: teamDraw.teams[index].length,
                          itemBuilder: (context, index2) {
                            return Padding(
                              padding: const EdgeInsets.all(8),
                              child: Text(teamDraw.teams[index][index2]),
                            );
                          },
                        ),
                      ),
                    ],
                  );
                },
              ),
            ),
            const SizedBox(height: 50),
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
                Navigator.pop(context);
              },
              child: const Text('처음으로'),
            ),
          ],
        ),
      ),
    );
  }
}
