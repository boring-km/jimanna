import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:jimanna/models/team_draw.dart';
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
      child: Column(
        children: [
          SizedBox(
            height: height * 0.8,
            child: ListView.builder(
              itemCount: teamDraw.teams.length,
              itemBuilder: (context, index) {
                return Column(
                  children: [
                    Text('조 ${index + 1}'),
                    SizedBox(
                      height: 50,
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        shrinkWrap: true,
                        itemCount: teamDraw.teams[index].names.length,
                        itemBuilder: (context, index2) {
                          return Padding(
                            padding: const EdgeInsets.all(8),
                            child: Text(teamDraw.teams[index].names[index2]),
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
        ],
      ),
    ),
    );
  }

  Center TestView(TeamDraw teamDraw, BuildContext context) {
    return Center(
      child: Column(
        children: [
          SizedBox(
            height: 500,
            child: ListView.builder(
              itemCount: teamDraw.teams.length,
              itemBuilder: (context, index) {
                return Column(
                  children: [
                    Text('조 ${index + 1}'),
                    SizedBox(
                      height: 50,
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        shrinkWrap: true,
                        itemCount: teamDraw.teams[index].names.length,
                        itemBuilder: (context, index2) {
                          return Padding(
                            padding: const EdgeInsets.all(8),
                            child: Text(teamDraw.teams[index].names[index2]),
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
        ],
      ),
    );
  }
}
