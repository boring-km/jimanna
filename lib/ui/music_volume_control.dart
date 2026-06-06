import 'package:flutter/material.dart';
import 'package:jimanna/utils/background_audio_player.dart';

/// 배경음악 음량 조절 UI. 데스크톱 결과/추첨 화면 좌측 하단에 작게 배치.
class MusicVolumeControl extends StatefulWidget {
  const MusicVolumeControl({super.key});

  @override
  State<MusicVolumeControl> createState() => _MusicVolumeControlState();
}

class _MusicVolumeControlState extends State<MusicVolumeControl> {
  late double _volume = audioPlayer.volume.clamp(0.0, 1.0);
  double _lastVolume = 1;

  void _setVolume(double value) {
    setState(() => _volume = value);
    audioPlayer.setVolume(value);
  }

  void _toggleMute() {
    if (_volume > 0) {
      _lastVolume = _volume;
      _setVolume(0);
    } else {
      _setVolume(_lastVolume > 0 ? _lastVolume : 1);
    }
  }

  IconData get _icon {
    if (_volume <= 0) return Icons.volume_off;
    if (_volume < 0.5) return Icons.volume_down;
    return Icons.volume_up;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 36,
      decoration: BoxDecoration(
        color: Colors.black.withValues(alpha: 0.55),
        borderRadius: BorderRadius.circular(18),
        border: Border.all(
          color: Colors.white.withValues(alpha: 0.3),
        ),
      ),
      padding: const EdgeInsets.only(left: 6, right: 12),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          InkWell(
            onTap: _toggleMute,
            customBorder: const CircleBorder(),
            child: Padding(
              padding: const EdgeInsets.all(4),
              child: Icon(_icon, color: Colors.white, size: 18),
            ),
          ),
          SizedBox(
            width: 100,
            child: SliderTheme(
              data: SliderTheme.of(context).copyWith(
                trackHeight: 2,
                activeTrackColor: const Color(0xffed8629),
                thumbColor: const Color(0xffed8629),
                inactiveTrackColor: Colors.white24,
                overlayShape: SliderComponentShape.noOverlay,
                thumbShape: const RoundSliderThumbShape(
                  enabledThumbRadius: 6,
                ),
              ),
              child: Slider(
                value: _volume,
                onChanged: _setVolume,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
