import 'package:flutter/material.dart';
import 'package:morse_pad/src/morse/morse.dart';

class MorseProvider extends ChangeNotifier {
  String _plainText = "";
  String _morseCode = "";

  bool _plainTextHasFocus = false;
  bool _morseCodeHasFocus = false;

  bool _plainTextPlaying = false;
  bool _morseCodePlaying = false;

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
    _plainTextHasFocus = hasFocus;
    notifyListeners();
  }

  bool getMorseCodeFocus() {
    return _morseCodeHasFocus;
  }

  void setMorseCodeFocus(bool hasFocus) {
    _morseCodeHasFocus = hasFocus;
    notifyListeners();
  }

  bool getPlainTextPlaying() {
    return _plainTextPlaying;
  }

  void setPlainTextPlaying(bool isPlaying) {
    _plainTextPlaying = isPlaying;
    notifyListeners();
  }

  bool getMorseCodePlaying() {
    return _morseCodePlaying;
  }

  void setMorseCodePlaying(bool isPlaying) {
    _morseCodePlaying = isPlaying;
    notifyListeners();
  }
}
