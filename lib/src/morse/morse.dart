class Morse {
  static format(String message) {
    return message.trim().replaceAll('\n', ' ').replaceAll(RegExp(' +'), ' ');
  }

  static String encode(String plainText) {
    return _convertMessage(plainText, false);
  }

  static String decode(String morseCode) {
    return _convertMessage(morseCode, true);
  }

  static String _convertMessage(String message, bool isMorse) {
    return message
        .split((isMorse) ? ' ' : '')
        .map((letter) => _convertLetter(letter, isMorse))
        .join((isMorse) ? '' : ' ');
  }

  static String _convertLetter(String letter, bool isMorse) {
    String convertedLetter = (letter != '') ? '#' : '';

    _morse.forEach((character, code) {
      final String convertFrom = (isMorse) ? code : character;
      final String convertTo = (isMorse) ? character : code;

      if (letter.toUpperCase() == convertFrom.toUpperCase()) {
        convertedLetter = convertTo.toUpperCase();
      }
    });

    return convertedLetter;
  }

  static final Map<String, String> _morse = {
    ' ': '/',
    'a': '.-',
    'b': '-...',
    'c': '-.-.',
    'd': '-..',
    'e': '.',
    'f': '..-.',
    'g': '--.',
    'h': '....',
    'i': '..',
    'j': '.---',
    'k': '-.-',
    'l': '.-..',
    'm': '--',
    'n': '-.',
    'o': '---',
    'p': '.--.',
    'q': '--.-',
    'r': '.-.',
    's': '...',
    't': '-',
    'u': '..-',
    'v': '...-',
    'w': '.--',
    'x': '-..-',
    'y': '-.--',
    'z': '--..',
    '1': '.----',
    '2': '..---',
    '3': '...--',
    '4': '....-',
    '5': '.....',
    '6': '-....',
    '7': '--...',
    '8': '---..',
    '9': '----.',
    '0': '-----',
    '!': '-.-.--',
    '?': '..--..',
    '@': '.--.-.',
    '=': '-...-',
    '&': '.-...',
    '(': '-.--.',
    ')': '-.--.-',
    '-': '-....-',
    '_': '..--.-',
    '+': '.-.-.',
    ';': '-.-.-.',
    ':': '---...',
    '\$': '...-..-',
    '\'': '.----.',
    '"': '.-..-.',
    ',': '--..--',
    '.': '.-.-.-',
    '/': '-..-.',
  };
}
