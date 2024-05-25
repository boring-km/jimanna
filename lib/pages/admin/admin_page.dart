import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:jimanna/models/admin_option.dart';
import 'package:jimanna/providers/admin_draw_provider.dart';
import 'package:jimanna/providers/current_registered_names_provider.dart';
import 'package:jimanna/providers/is_start_draw_provider.dart';
import 'package:jimanna/providers/register_state_provider.dart';
import 'package:jimanna/routes.dart';
import 'package:jimanna/ui/backward_button.dart';
import 'package:jimanna/utils/date_utils.dart';

class AdminPage extends ConsumerStatefulWidget {
  const AdminPage({super.key});

  @override
  ConsumerState<AdminPage> createState() => _AdminPageState();
}

class _AdminPageState extends ConsumerState<AdminPage> {
  final textEditingController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(height: 40),
              BackwardButton(context),
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
                  ref.read(isStartDrawProvider.notifier).resetDraw();
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
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  Navigator.pushNamed(context, Routes.adminFeedback);
                },
                child: const Text('피드백 결과보기'),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  Navigator.pushNamed(context, Routes.adminSpecial);
                },
                child: const Text('임원 명단'),
              ),
              const SizedBox(height: 20),
              SizedBox(
                width: 200,
                child: TextField(
                  controller: textEditingController,
                  onEditingComplete: () {
                    savePassword(context);
                  },
                  decoration: const InputDecoration(
                    labelText: '비밀번호 재설정',
                    hintText: '입력하세요',
                  ),
                ),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  savePassword(context);
                },
                child: const Text('비밀번호 변경'),
              ),
              const SizedBox(height: 40),
            ],
          ),
        ),
      ),
    );
  }

  void savePassword(BuildContext context) {
    ref.read(adminOptionsProvider.notifier).changePassword(
          textEditingController.text,
        );
    textEditingController.text = '';
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('비밀번호가 변경되었습니다.'),
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
