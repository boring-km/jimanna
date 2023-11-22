import 'package:flutter/material.dart';
import 'package:jimanna/routes.dart';

class AdminPage extends StatefulWidget {
  const AdminPage({super.key});

  @override
  State<AdminPage> createState() => _AdminPageState();
}

class _AdminPageState extends State<AdminPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('관리자 페이지', style: TextStyle(fontSize: 30)),
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(20),
              child: ElevatedButton(
                onPressed: () {},
                child: const Text('지만나 오픈/닫기'),
              ),
            ),
            const Text('현재 상태: '),
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
            ElevatedButton(onPressed: () {}, child: const Text('초기화')),
            const SizedBox(height: 20),
            ElevatedButton(
                onPressed: () {
                  Navigator.pushNamed(context, Routes.adminNameList);
                },
                child: const Text('명단 관리')),
            const SizedBox(height: 20),
            ElevatedButton(
                onPressed: () {
                  Navigator.pushNamed(context, Routes.adminBlackList);
                },
                child: const Text('만나면 안되는')),
          ],
        ),
      ),
    );
  }
}
