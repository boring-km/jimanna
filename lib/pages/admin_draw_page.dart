import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:jimanna/providers/admin_draw_provider.dart';

class AdminDrawPage extends ConsumerWidget {
  const AdminDrawPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final teamDraw = ref.watch(adminDrawProvider);
    print('groupNumber: ${teamDraw.groupNumber}');
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Column(
              children: [
                Text('조 ${teamDraw.groupNumber}'),
                SizedBox(
                  height: 200,
                  child: teamDraw.groupNumber > 0 ? ListView.builder(
                    shrinkWrap: true,
                    itemCount: teamDraw.teams[teamDraw.groupNumber - 1].length,
                    itemBuilder: (context, index2) {
                      return Padding(
                        padding: const EdgeInsets.all(8),
                        child: Text(
                          teamDraw.teams[teamDraw.groupNumber - 1][index2],
                          style: const TextStyle(fontSize: 20),
                        ),
                      );
                    },
                  ) : const Center(child: Text('조 추첨을 시작해주세요.')),
                ),
              ],
            ),
            const SizedBox(height: 50),
            ElevatedButton(
              onPressed: () {
                final result = ref.read(adminDrawProvider.notifier).addTeam();
                if (result) {
                  Navigator.pushNamed(
                      context, '/qlalftmfjdnsghkaus/drawResult');
                }
              },
              child: const Text('조 추가'),
            ),
          ],
        ),
      ),
    );
  }
}
