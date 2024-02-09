import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:jimanna/providers/admin_draw_provider.dart';
import 'package:jimanna/providers/current_registered_names_provider.dart';
import 'package:jimanna/providers/is_start_draw_provider.dart';
import 'package:jimanna/providers/register_state_provider.dart';
import 'package:jimanna/routes.dart';
import 'package:jimanna/utils/date_utils.dart';

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
                  ref.read(registerStateProvider.notifier).switchEvent();
                },
                child: const Text('지만나 오픈/닫기'),
              ),
            ),
            _EventStateText(ref),
            Padding(
              padding: const EdgeInsets.all(20),
              child: ElevatedButton(
                onPressed: () {
                  ref.read(adminDrawProvider.notifier).resetTeams();
                  ref.read(isStartDrawProvider.notifier).resetDraw();
                  Navigator.pushNamed(context, Routes.adminDraw);
                },
                child: const Text('조 추첨 시작'),
              ),
            ),
            ElevatedButton(
              onPressed: () {
                ref.read(adminDrawProvider.notifier).resetTeams();
              },
              child: const Text(
                '추첨 초기화\n(이름 보존됨)',
                textAlign: TextAlign.center,
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                ref.read(adminDrawProvider.notifier).resetTeams();
                ref.read(currentRegisteredNamesProvider.notifier).removeAll();
              },
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
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, Routes.adminDrawResult);
              },
              child: const Text('조 추첨 결과'),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, Routes.adminCurrentParticipants);
              },
              child: Text('${getCurrentYearMonthOnly()} 참가자'),
            ),
          ],
        ),
      ),
    );
  }

  Widget _EventStateText(WidgetRef ref) {
    final state = ref.watch(registerStateProvider);
    return Text(
      state.text,
      style: const TextStyle(fontSize: 20, color: Colors.black),
    );
  }
}
