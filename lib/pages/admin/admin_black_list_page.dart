import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:jimanna/providers/admin_black_list_provider.dart';
import 'package:jimanna/ui/backward_button.dart';

class AdminBlackListPage extends ConsumerStatefulWidget {
  const AdminBlackListPage({super.key});

  @override
  ConsumerState<AdminBlackListPage> createState() => _AdminBlackListPageState();
}

class _AdminBlackListPageState extends ConsumerState<AdminBlackListPage> {
  final _nameController1 = TextEditingController();
  final _nameController2 = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final blackList = ref.watch(adminBlackListProvider);

    return Scaffold(
      body: Center(
        child: Column(
          children: [
            BackwardButton(context),
            const Text('만나면 안되는...', style: TextStyle(fontSize: 30)),
            const SizedBox(height: 20),
            TextField(
              controller: _nameController1,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                labelText: '실명 입력 1',
              ),
            ),
            const SizedBox(height: 20),
            TextField(
              controller: _nameController2,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                labelText: '실명 입력 2',
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                ref
                    .read(adminBlackListProvider.notifier)
                    .add(_nameController1.text, _nameController2.text);
              },
              child: const Text('추가하기'),
            ),
            const SizedBox(height: 20),
            Expanded(
              child: ListView.builder(
                itemCount: blackList.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Text(
                      '${encodeBase64(blackList[index].name_first)}'
                          ' - ${encodeBase64(blackList[index].name_second)}',
                    ),
                    trailing: IconButton(
                      onPressed: () {
                        ref
                            .read(adminBlackListProvider.notifier)
                            .remove(blackList[index]);
                      },
                      icon: const Icon(Icons.delete),
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

  String encodeBase64(String str) {
    return base64.encode(utf8.encode(str));
  }
}
