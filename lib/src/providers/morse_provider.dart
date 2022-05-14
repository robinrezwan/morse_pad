import 'package:flutter/material.dart';
import 'package:morse_pad/src/morse/morse.dart';

class MorseProvider extends ChangeNotifier {
  String _plainText = "";
  String _morseCode = "";

  bool _plainTextHasFocus = false;
  bool _morseCodeHasFocus = false;

  bool _plainTextPlaying = false;
  bool _morseCodePlaying = false;

  double _plainTextPlayingProgress = 0;
  double _morseCodePlayingProgress = 0;

  MorseProvider();

  String getPlainText() {
    return _plainText;
  }

  void setPlainText(String text) {
    _plainText = Morse.format(text);
    _morseCode = Morse.encode(_plainText);
    notifyListeners();
  }

  String getMorseCode() {
    return _morseCode;
  }

  void setMorseCode(String code) {
    _morseCode = Morse.format(code);
    _plainText = Morse.decode(_morseCode);
    notifyListeners();
  }

  bool getPlainTextFocus() {
    return _plainTextHasFocus;
  }

  void setPlainTextFocus(bool hasFocus) {
    if (_plainTextHasFocus != hasFocus) {
      _plainTextHasFocus = hasFocus;
      notifyListeners();
    }
  }

  bool getMorseCodeFocus() {
    return _morseCodeHasFocus;
  }

  void setMorseCodeFocus(bool hasFocus) {
    if (_morseCodeHasFocus != hasFocus) {
      _morseCodeHasFocus = hasFocus;
      notifyListeners();
    }
  }

  bool getPlainTextPlaying() {
    return _plainTextPlaying;
  }

  void setPlainTextPlaying(bool isPlaying) {
    if (_plainTextPlaying != isPlaying) {
      if (!isPlaying) {
        _plainTextPlayingProgress = 0;
      }
      _plainTextPlaying = isPlaying;
      notifyListeners();
    }
  }

  bool getMorseCodePlaying() {
    return _morseCodePlaying;
  }

  void setMorseCodePlaying(bool isPlaying) {
    if (_morseCodePlaying != isPlaying) {
      if (!isPlaying) {
        _morseCodePlayingProgress = 0;
      }
      _morseCodePlaying = isPlaying;
      notifyListeners();
    }
  }

  double getPlainTextPlayingProgress() {
    return _plainTextPlayingProgress;
  }

  void setPlainTextPlayingProgress(double progress) {
    _plainTextPlayingProgress = progress;
    notifyListeners();
  }

  double getMorseCodePlayingProgress() {
    return _morseCodePlayingProgress;
  }

  void setMorseCodePlayingProgress(double progress) {
    _morseCodePlayingProgress = progress;
    notifyListeners();
  }
}
