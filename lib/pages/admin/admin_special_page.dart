import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:jimanna/providers/admin_leader_provider.dart';
import 'package:jimanna/ui/backward_button.dart';

class AdminSpecialPage extends ConsumerWidget {
  const AdminSpecialPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final leaderList = ref.watch(adminLeaderProvider);

    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            BackwardButton(context),
            const Text('리더 명단', style: TextStyle(fontSize: 30)),
            Expanded(
              child: ListView.builder(
                itemCount: leaderList.length,
                itemBuilder: (context, index) {
                  final leader = leaderList[index];
                  return Padding(
                    padding: const EdgeInsets.all(8),
                    child: Text(
                      '${leader.type}: ${leader.name}',
                      textAlign: TextAlign.center,
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
