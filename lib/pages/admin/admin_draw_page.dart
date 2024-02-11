import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:jimanna/providers/admin_draw_provider.dart';
import 'package:jimanna/providers/is_start_draw_provider.dart';
import 'package:jimanna/ui/backward_button.dart';

class AdminDrawPage extends ConsumerWidget {
  const AdminDrawPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      body: Center(
        child: Body(ref, context),
      ),
    );
  }

  Widget Body(WidgetRef ref, BuildContext context) {
    final isStartDraw = ref.watch(isStartDrawProvider);

    if (isStartDraw != null && isStartDraw) {
      return ResultView(ref, context);
    } else {
      return NotStartedView(ref, context);
    }
  }

  Widget ResultView(WidgetRef ref, BuildContext context) {
    final teamDraw = ref.watch(adminDrawProvider);

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          height: MediaQuery.of(context).size.height * 0.7,
          color: Colors.grey[300],
          child: ListView.separated(
            itemCount: teamDraw.teams.length,
            separatorBuilder: (context, index) => Container(
              height: 4,
              color: Colors.black,
            ),
            itemBuilder: (context, index) {
              return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    '조 ${index + 1}',
                    style: const TextStyle(fontSize: 20),
                  ),
                  SizedBox(
                    height: 80,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      shrinkWrap: true,
                      itemCount: teamDraw.teams[index].names.length,
                      itemBuilder: (context, index2) {
                        return Padding(
                          padding: const EdgeInsets.all(8),
                          child: Text(
                            teamDraw.teams[index].names[index2],
                            style: const TextStyle(fontSize: 20),
                          ),
                        );
                      },
                    ),
                  ),
                ],
              );
            },
          ),
        ),
        const SizedBox(height: 50),
        ElevatedButton(
          onPressed: () {
            Navigator.pop(context);
          },
          child: const Text('처음으로'),
        ),
        const SizedBox(height: 20),
        ElevatedButton(
          onPressed: () {
            ref.read(adminDrawProvider.notifier).resetTeams();
            ref.read(isStartDrawProvider.notifier).resetDraw();
          },
          child: const Text('초기화'),
        ),
      ],
    );
  }

  Widget NotStartedView(WidgetRef ref, BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        BackwardButton(context),
        const Text('추첨을 시작해주세요.', style: TextStyle(fontSize: 30)),
        const SizedBox(height: 20),
        ElevatedButton(
          onPressed: () {
            ref.read(adminDrawProvider.notifier).makeTeams();
            ref.read(isStartDrawProvider.notifier).startDraw();
          },
          child: const Text('추첨 시작'),
        ),
      ],
    );
  }
}
