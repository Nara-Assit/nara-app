import 'package:audio_waveforms/audio_waveforms.dart';
import 'package:flutter/material.dart';

class VoiceMessageManager {
  static PlayerController? _currentController;
  static VoidCallback? _onStopCallback;

  static Future<void> playNew(
    PlayerController controller,
    String path,
    VoidCallback onStop,
  ) async {
    if (_currentController != null && _currentController != controller) {
      await _currentController!.pausePlayer();
      _onStopCallback?.call();
    }

    _currentController = controller;
    _onStopCallback = onStop;

    final state = controller.playerState;
    if (state == PlayerState.stopped) {
      await controller.preparePlayer(path: path);
    }
    await controller.startPlayer();
  }

  static void clear() {
    _currentController = null;
    _onStopCallback = null;
  }
}