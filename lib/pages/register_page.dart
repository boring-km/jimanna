import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:jimanna/providers/name_register_provider.dart';
import 'package:jimanna/routes.dart';

class RegisterPage extends ConsumerStatefulWidget {
  const RegisterPage({super.key});

  @override
  ConsumerState<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends ConsumerState<RegisterPage> {
  final _nameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    ref.listen(nameRegisterProvider, (previous, result) {
      result.whenOrNull(
        error: (e) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(e.toString()),
            ),
          );
        },
        success: (data) {
          if (data) {
            Navigator.pushNamed(context, Routes.home);
          }
        },
      );
    });

    return Scaffold(
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset('assets/images/abad.png'),
            const SizedBox(height: 100),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: TextField(
                controller: _nameController,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: '실명 입력',
                ),
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                ref
                    .read(nameRegisterProvider.notifier)
                    .registerNameToFirestore(_nameController.text);
              },
              child: const Text('입력'),
            ),
          ],
        ),
      ),
    );
  }
}
