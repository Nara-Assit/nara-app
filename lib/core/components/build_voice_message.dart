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
  @override
  @override
  void initState() {
    super.initState();
    _playerController = PlayerController();

    _playerController.preparePlayer(
      path: widget.path,
      shouldExtractWaveform: true,
    );

    _playerController.onPlayerStateChanged.listen((state) {
      if (state == PlayerState.stopped) {
        _playerController.seekTo(0);
        setState(() {
          isPlaying = false;
        });
      }
    });
  }

  @override
  void dispose() {
    _playerController.dispose();
    super.dispose();
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
              onPressed: () {
                isPlaying
                    ? _playerController.pausePlayer()
                    : _playerController.startPlayer();
                setState(() {
                  isPlaying = !isPlaying;
                });
              },
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
