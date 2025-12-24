import 'package:audio_waveforms/audio_waveforms.dart';

class VoiceMessageManager {
  static PlayerController? _currentController;

  static void playNew(PlayerController controller, String path) async {
    if (_currentController != null && _currentController != controller) {
      await _currentController!.stopPlayer();
    }

    _currentController = controller;

    await controller.preparePlayer(path: path, shouldExtractWaveform: false);
    await controller.startPlayer();
  }
}
