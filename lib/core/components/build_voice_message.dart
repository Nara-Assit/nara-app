import 'dart:async';

import 'package:audio_waveforms/audio_waveforms.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/theming/color_manager.dart';

class VoiceMessageBubble extends StatefulWidget {
  final String path;
  const VoiceMessageBubble({
    super.key,
    required this.path,
  });
  @override
  State<VoiceMessageBubble> createState() => _VoiceMessageBubbleState();
}

class _VoiceMessageBubbleState extends State<VoiceMessageBubble> {
  late final PlayerController _playerController;
  bool isPlaying = false;
  StreamSubscription<PlayerState>? _playerStateSubscription;

  @override
  void initState() {
    super.initState();
    _playerController = PlayerController();
    _playerController.preparePlayer(
      path: widget.path,
    );

    _playerStateSubscription = _playerController.onPlayerStateChanged.listen((
      state,
    ) {
      if (state == PlayerState.stopped) {
        setState(() {
          isPlaying = false;
        });
      }
    });
  }

  @override
  void dispose() {
    _playerStateSubscription?.cancel();
    _playerController.dispose();
    super.dispose();
  }

  void _togglePlayPause() async {
    if (isPlaying) {
      await _playerController.pausePlayer();
      setState(() {
        isPlaying = false;
      });
    } else {
      final currentState = _playerController.playerState;

      if (currentState == PlayerState.stopped) {
        await _playerController.preparePlayer(
          path: widget.path,
          shouldExtractWaveform: false,
        );
      }

      await _playerController.startPlayer();
      setState(() {
        isPlaying = true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerRight,
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 12.h, horizontal: 12.w),
        decoration: BoxDecoration(
          color: ColorManager.primaryColor,
          borderRadius: BorderRadius.circular(30.r),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            IconButton(
              icon: Icon(
                isPlaying ? Icons.pause : Icons.play_arrow,
                color: Colors.white,
              ),
              onPressed: _togglePlayPause,
            ),
            AudioFileWaveforms(
              size: Size(200.w, 40.h),
              playerController: _playerController,
              waveformType: WaveformType.fitWidth,
              playerWaveStyle: const PlayerWaveStyle(
                spacing: 6,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
