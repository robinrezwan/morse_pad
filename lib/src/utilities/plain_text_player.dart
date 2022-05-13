import 'package:flutter_tts/flutter_tts.dart';
import 'package:logger/logger.dart';

// Logger
final Logger log = Logger();

class PlainTextPlayer {
  final FlutterTts _tts = FlutterTts();

  PlainTextPlayer();

  void initPlayer(void Function(bool isPlaying) onStartOrStop) {
    // Initializing text to speech
    _tts.setStartHandler(() {
      onStartOrStop(true);
    });

    _tts.setCompletionHandler(() {
      onStartOrStop(false);
    });
  }

  void disposePlayer() {
    stop();
  }

  void setVolume(double volume) {
    _tts.setVolume(volume);
  }

  Future<void> play(String text) async {
    // Playing text
    await Future.delayed(const Duration(milliseconds: 400));
    await _tts.speak(text);
  }

  Future<void> stop() async {
    await _tts.stop();
  }
}
