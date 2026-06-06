import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:jimanna/providers/admin_draw_provider.dart';

class AdminDrawResultPage extends ConsumerStatefulWidget {
  const AdminDrawResultPage({super.key});

  @override
  ConsumerState<AdminDrawResultPage> createState() =>
      _AdminDrawResultPageState();
}

class _AdminDrawResultPageState extends ConsumerState<AdminDrawResultPage> {
  @override
  Widget build(BuildContext context) {
    final teamDraw = ref.watch(adminDrawProvider);
    final height = MediaQuery.of(context).size.height;

    return Scaffold(
      body: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 720),
          child: Column(
            children: [
              const SizedBox(height: 24),
              Text(
                '조 추첨 결과 (총 ${teamDraw.teams.length}조)',
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 12),
              SizedBox(
                height: height * 0.8,
                child: ListView.separated(
                  padding: const EdgeInsets.symmetric(horizontal: 24),
                  itemCount: teamDraw.teams.length,
                  separatorBuilder: (context, index) =>
                      const Divider(height: 1),
                  itemBuilder: (context, index) {
                    final names = teamDraw.teams[index].names;
                    return Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                            width: 56,
                            child: Text(
                              '${index + 1}조',
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          Expanded(
                            child: Wrap(
                              spacing: 16,
                              runSpacing: 4,
                              children: [
                                for (final name in names) Text(name),
                              ],
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ),
              const SizedBox(height: 24),
              ElevatedButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: const Text('처음으로'),
              ),
              const SizedBox(height: 24),
            ],
          ),
        ),
      ),
    );
  }
}
