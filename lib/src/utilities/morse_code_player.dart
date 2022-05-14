import 'package:logger/logger.dart';
import 'package:sound_generator/sound_generator.dart';
import 'package:sound_generator/waveTypes.dart';

// Logger
final Logger log = Logger();

class MorseCodePlayer {
  static const int _sampleRate = 16000;
  static const double _frequency = 500;
  double _volume = 1;

  static const int _unitTimeInMs = 100;

  bool _isPlaying = false;

  late Function(double progress) _onProgress;

  MorseCodePlayer();

  void initPlayer({
    required void Function(bool isPlaying) onStartOrStop,
    required void Function(double progress) onProgress,
  }) {
    // Initializing sound generator
    SoundGenerator.init(_sampleRate);
    SoundGenerator.setFrequency(_frequency);
    SoundGenerator.setWaveType(waveTypes.SINUSOIDAL);
    SoundGenerator.setVolume(0);

    SoundGenerator.onIsPlayingChanged.listen(onStartOrStop);

    _onProgress = onProgress;
  }

  void disposePlayer() {
    stop();
    SoundGenerator.release();
  }

  void setVolume(double volume) {
    _volume = volume;
  }

  Future<void> play(String code) async {
    _isPlaying = true;

    // Calculating necessary durations
    const Duration dotTime = Duration(milliseconds: _unitTimeInMs);
    const Duration dashTime = Duration(milliseconds: _unitTimeInMs * 3);
    const Duration spaceCodeTime = Duration(milliseconds: _unitTimeInMs);
    const Duration spaceLetterTime = Duration(milliseconds: _unitTimeInMs * 3);
    const Duration spaceWordTime = Duration(milliseconds: _unitTimeInMs * 7);

    // Starting sound generation
    SoundGenerator.play();
    await Future.delayed(const Duration(milliseconds: 400));

    // Playing code
    final List<String> characters = code.split('');

    for (int index = 0; index < characters.length; index++) {
      switch (characters[index]) {
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

      double progress = (index + 1) / characters.length;
      _onProgress(progress);
    }

    // Stopping sound generation
    SoundGenerator.stop();
  }

  void stop() {
    _isPlaying = false;
  }
}
