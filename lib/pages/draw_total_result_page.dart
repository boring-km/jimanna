import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:jimanna/gen/assets.gen.dart';
import 'package:jimanna/models/team.dart';
import 'package:jimanna/providers/admin_draw_provider.dart';
import 'package:jimanna/ui/music_volume_control.dart';
import 'package:jimanna/ui/ongmezim_text.dart';
import 'package:simple_gradient_text/simple_gradient_text.dart';

class DrawTotalResultPage extends ConsumerWidget {
  const DrawTotalResultPage({super.key});

  // 카드 기본 크기 (인원 적을 땐 이 크기 유지, 많으면 축소)
  static const double _baseCardWidth = 480;
  static const double _baseCardHeight = 300;
  static const double _spacing = 16;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;

    final teamDraw = ref.watch(adminDrawProvider);
    final teams = teamDraw.teams;
    final teamCount = teams.length;

    const outerPadding = 30.0;
    final availWidth = width - outerPadding * 2;
    final availHeight = height - outerPadding * 2;

    final size = _resolveCardSize(
      teamCount: teamCount,
      availWidth: availWidth,
      availHeight: availHeight,
    );

    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        children: [
          Center(
            child: Assets.images.drawBackground.image(
              width: width,
              height: height,
              fit: BoxFit.fitHeight,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(outerPadding),
            child: Center(
              child: Wrap(
                spacing: _spacing,
                runSpacing: _spacing,
                alignment: WrapAlignment.center,
                runAlignment: WrapAlignment.center,
                children: [
                  for (var i = 0; i < teamCount; i++)
                    _TeamCard(
                      team: teams[i],
                      index: i,
                      width: size.width,
                      height: size.height,
                    ),
                ],
              ),
            ),
          ),
          BottomText(context, width, height),
          const Align(
            alignment: Alignment.bottomLeft,
            child: Padding(
              padding: EdgeInsets.all(16),
              child: MusicVolumeControl(),
            ),
          ),
        ],
      ),
    );
  }

  // 기본 카드 크기로 두되, 화면을 넘치면 비율 유지하며 축소한다.
  Size _resolveCardSize({
    required int teamCount,
    required double availWidth,
    required double availHeight,
  }) {
    if (teamCount <= 0) {
      return const Size(_baseCardWidth, _baseCardHeight);
    }
    // 한 행에 들어갈 수 있는 열 수 (기본 크기 기준)
    final maxColsByWidth =
        max(1, ((availWidth + _spacing) / (_baseCardWidth + _spacing)).floor());
    final cols = min(teamCount, maxColsByWidth);
    final rows = (teamCount / cols).ceil();

    final totalWidth = cols * (_baseCardWidth + _spacing) - _spacing;
    final totalHeight = rows * (_baseCardHeight + _spacing) - _spacing;

    final scale = min(availWidth / totalWidth, availHeight / totalHeight)
        .clamp(0.0, 1.0);

    return Size(_baseCardWidth * scale, _baseCardHeight * scale);
  }

  Widget BottomText(BuildContext context, double width, double height) {
    return Align(
      alignment: Alignment.bottomRight,
      child: SizedBox(
        height: height * 0.05,
        child: Padding(
          padding: const EdgeInsets.only(right: 16),
          child: ongmezimText(context, width / 2),
        ),
      ),
    );
  }
}

class _TeamCard extends StatelessWidget {
  const _TeamCard({
    required this.team,
    required this.index,
    required this.width,
    required this.height,
  });

  final Team team;
  final int index;
  final double width;
  final double height;

  // 이름을 2명씩 묶어 2x2(또는 인원수에 맞춰)로 배치한다.
  Widget _namesGrid(List<String> names) {
    final pairRows = <List<String>>[];
    for (var i = 0; i < names.length; i += 2) {
      pairRows.add(names.sublist(i, (i + 2).clamp(0, names.length)));
    }
    return Column(
      children: [
        for (final pair in pairRows)
          Expanded(
            child: Row(
              children: [
                for (final name in pair) Expanded(child: _nameCell(name)),
                // 홀수 인원이면 빈 칸으로 균형 맞춤
                if (pair.length == 1) const Spacer(),
              ],
            ),
          ),
      ],
    );
  }

  Widget _nameCell(String name) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 12),
      child: FittedBox(
        child: GradientText(
          name,
          gradientDirection: GradientDirection.ttb,
          colors: const [Colors.white, Colors.green],
          style: const TextStyle(fontSize: 22),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        color: Colors.black.withValues(alpha: 0.55),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: const Color(0xffed8629).withValues(alpha: 0.8),
          width: 2,
        ),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Expanded(
            flex: 2,
            child: FittedBox(
              child: GradientText(
                '${index + 1}조',
                gradientDirection: GradientDirection.ttb,
                colors: const [Colors.white, Color(0xffed8629)],
                style: const TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          Expanded(
            flex: 5,
            child: _namesGrid(team.names),
          ),
        ],
      ),
    );
  }
}
