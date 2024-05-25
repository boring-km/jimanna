import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:jimanna/providers/current_registered_names_provider.dart';
import 'package:jimanna/ui/backward_button.dart';

class AdminCurrentMonthNameListPage extends ConsumerWidget {
  const AdminCurrentMonthNameListPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final nameList = ref.watch(currentRegisteredNamesProvider);
    final countText = ref.read(currentRegisteredNamesProvider.notifier).countText();

    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            BackwardButton(context),
            Text('이번달 등록자 명단\n$countText'),
            Expanded(
              child: ListView.builder(
                itemCount: nameList.length,
                itemBuilder: (context, index) {
                  final name = nameList[index];
                  return Padding(
                    padding: const EdgeInsets.all(8),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          '${name.type}: ${name.name}',
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(width: 10),
                        ElevatedButton(
                          onPressed: () {
                            ref.read(currentRegisteredNamesProvider.notifier).removeByName(name.name);
                          },
                          child: const Text('삭제'),
                        ),
                      ],
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
