import 'package:sound_generator/sound_generator.dart';
import 'package:sound_generator/waveTypes.dart';

class MorseCodePlayer {
  static const int _sampleRate = 16000;
  static const double _frequency = 500;
  double _volume = 1;

  final int _unitTimeInMs = 100;

  bool _isPlaying = false;

  MorseCodePlayer();

  void initPlayer(void Function(bool isPlaying) onStartOrStop) {
    // Initializing sound generator
    SoundGenerator.init(_sampleRate);
    SoundGenerator.setFrequency(_frequency);
    SoundGenerator.setWaveType(waveTypes.SINUSOIDAL);
    SoundGenerator.setVolume(0);

    SoundGenerator.onIsPlayingChanged.listen(onStartOrStop);
  }

  void setVolume(double volume) {
    _volume = volume;
  }

  Future<void> play(String code) async {
    _isPlaying = true;

    // Calculating necessary durations
    final Duration dotTime = Duration(milliseconds: _unitTimeInMs);
    final Duration dashTime = Duration(milliseconds: _unitTimeInMs * 3);
    final Duration spaceCodeTime = Duration(milliseconds: _unitTimeInMs);
    final Duration spaceLetterTime = Duration(milliseconds: _unitTimeInMs * 3);
    final Duration spaceWordTime = Duration(milliseconds: _unitTimeInMs * 7);

    // Starting sound generation
    SoundGenerator.play();
    await Future.delayed(const Duration(milliseconds: 400));

    // Playing code
    for (String character in code.split('')) {
      switch (character) {
        case '.':
          SoundGenerator.setVolume(_volume);
          await Future.delayed(dotTime);
          SoundGenerator.setVolume(0);
          break;
        case '-':
          SoundGenerator.setVolume(_volume);
          await Future.delayed(dashTime);
          SoundGenerator.setVolume(0);
          break;
        case ' ':
          await Future.delayed(spaceLetterTime);
          break;
        case '/':
          await Future.delayed(spaceWordTime);
          break;
        default:
          await Future.delayed(const Duration(milliseconds: 1000));
      }

      if (!_isPlaying) {
        // Stopping sound generation
        SoundGenerator.stop();
        break;
      }

      await Future.delayed(spaceCodeTime);
    }

    // Stopping sound generation
    SoundGenerator.stop();
  }

  void stop() {
    _isPlaying = false;
  }
}
