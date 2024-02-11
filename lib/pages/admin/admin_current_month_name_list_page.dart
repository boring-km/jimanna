import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:jimanna/providers/current_registered_names_provider.dart';
import 'package:jimanna/ui/backward_button.dart';

class AdminCurrentMonthNameListPage extends ConsumerWidget {
  const AdminCurrentMonthNameListPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final nameList = ref.watch(currentRegisteredNamesProvider);

    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            BackwardButton(context),
            const Text('이번달 등록자 명단'),
            Expanded(
              child: ListView.builder(
                itemCount: nameList.length,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.all(8),
                    child: Text(nameList[index]),
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
