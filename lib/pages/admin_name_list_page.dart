import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:jimanna/providers/admin_name_list_provider.dart';

class AdminNameListPage extends ConsumerStatefulWidget {
  const AdminNameListPage({super.key});

  @override
  ConsumerState<AdminNameListPage> createState() => _AdminNameListPageState();
}

class _AdminNameListPageState extends ConsumerState<AdminNameListPage> {

  final _nameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final nameList = ref.watch(adminNameListProvider);

    return Scaffold(
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text('명단 관리', style: TextStyle(fontSize: 30)),
            const SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.all(20),
              child: TextField(
                controller: _nameController,
                onEditingComplete: () {
                  register();
                },
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: '실명 입력',
                ),
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                register();
              },
              child: const Text('추가하기'),
            ),
            const SizedBox(height: 20),
            Expanded(
              child: ListView.builder(
                itemCount: nameList.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Text(nameList[index]),
                    trailing: IconButton(
                      onPressed: () {
                        ref.read(adminNameListProvider.notifier).remove(nameList[index]);
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

  void register() {
    ref.read(adminNameListProvider.notifier).register(_nameController.text);
    _nameController.clear();
  }
}
