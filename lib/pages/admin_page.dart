import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:jimanna/models/result.dart';
import 'package:jimanna/providers/event_switch_provider.dart';
import 'package:jimanna/routes.dart';

class AdminPage extends ConsumerWidget {
  const AdminPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text('관리자 페이지', style: TextStyle(fontSize: 30)),
            Padding(
              padding: const EdgeInsets.all(20),
              child: ElevatedButton(
                onPressed: () {
                  ref.read(eventSwitchProvider.notifier).switchEvent();
                },
                child: const Text('지만나 오픈/닫기'),
              ),
            ),
            _EventStateText(ref),
            Padding(
              padding: const EdgeInsets.all(20),
              child: ElevatedButton(
                onPressed: () {},
                child: const Text('조 추첨 시작'),
              ),
            ),
            ElevatedButton(
              onPressed: () {},
              child: const Text(
                '추첨 초기화\n(이름 보존됨)',
                textAlign: TextAlign.center,
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {},
              child: const Text(
                '추첨 초기화\n(이번달 등록 이름 제거)',
                textAlign: TextAlign.center,
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, Routes.adminNameList);
              },
              child: const Text('명단 관리'),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, Routes.adminBlackList);
              },
              child: const Text('만나면 안되는'),
            ),
          ],
        ),
      ),
    );
  }

  Widget _EventStateText(WidgetRef ref) {
    final state = ref.watch(eventSwitchProvider);
    if (state is Success<bool>) {
      return Text(
        state.data ? '현재상태: 열림' : '현재상태: 닫힘',
        style: const TextStyle(fontSize: 20, color: Colors.black),
      );
    }
    return const SizedBox.shrink();
  }
}
