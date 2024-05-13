import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:jimanna/providers/admin_name_list_provider.dart';
import 'package:jimanna/ui/backward_button.dart';

class AdminNameListPage extends ConsumerStatefulWidget {
  const AdminNameListPage({super.key});

  @override
  ConsumerState<AdminNameListPage> createState() => _AdminNameListPageState();
}

class _AdminNameListPageState extends ConsumerState<AdminNameListPage> {
  final abadNameController = TextEditingController();
  final secondNameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final abadNameList = ref.watch(abadNameListProvider);
    final secondNameList = ref.watch(secondNameListProvider);
    final width = MediaQuery.of(context).size.width;

    return Scaffold(
      body: Center(
        child: Column(
          children: [
            BackwardButton(context),
            const Text('1청/2청 명단 관리', style: TextStyle(fontSize: 30)),
            const SizedBox(height: 10),
            Expanded(
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  SizedBox(
                    width: width / 2,
                    child: buildNameList(
                      nameList: secondNameList,
                      controller: secondNameController,
                      onClick: registerSecondName,
                      onDelete: ref.read(secondNameListProvider.notifier).remove,
                    ),
                  ),

                  SizedBox(
                    width: width / 2,
                    child: buildNameList(
                      nameList: abadNameList,
                      controller: abadNameController,
                      onClick: registerAbadName,
                      onDelete: ref.read(abadNameListProvider.notifier).remove,
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

  Widget buildNameList({
    required List<String> nameList,
    required TextEditingController controller,
    required VoidCallback onClick,
    required void Function(String) onDelete,
  }) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          '인원수: ${nameList.length}명',
          style: const TextStyle(fontSize: 20),
        ),
        const SizedBox(height: 20),
        Padding(
          padding: const EdgeInsets.all(20),
          child: TextField(
            controller: controller,
            onEditingComplete: onClick,
            decoration: const InputDecoration(
              border: OutlineInputBorder(),
              labelText: '실명 입력',
            ),
          ),
        ),
        const SizedBox(height: 20),
        SizedBox(
          width: 200,
          child: ElevatedButton(
            onPressed: onClick,
            child: const Text('추가하기'),
          ),
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
                    onDelete(nameList[index]);
                  },
                  icon: const Icon(Icons.delete),
                ),
              );
            },
          ),
        ),
      ],
    );
  }

  void registerAbadName() {
    ref.read(abadNameListProvider.notifier).register(
          abadNameController.text,
          onError: showAlreadyRegisteredDialog,
        );
    abadNameController.clear();
  }

  void registerSecondName() {
    ref.read(secondNameListProvider.notifier).register(
          secondNameController.text,
          onError: showAlreadyRegisteredDialog,
        );
    secondNameController.clear();
  }

  void showAlreadyRegisteredDialog() {
    showDialog<void>(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('이미 등록된 이름입니다.'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text('확인'),
            ),
          ],
        );
      },
    );
  }
}
