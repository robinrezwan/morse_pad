extension StringExtension on String {
  bool get isWhiteSpace {
    return trim().isEmpty;
  }

  bool get startsWithWhiteSpace {
    return this[0].trim().isEmpty;
  }

  bool get endsWithWhiteSpace {
    return this[length - 1].trim().isEmpty;
  }

  int get indexOfWhiteSpace {
    int index = 0;

    while (this[index].trim().isNotEmpty) {
      index += 1;

      if (index == length) {
        return -1;
      }
    }
    return index;
  }

  int get lastIndexOfWhiteSpace {
    int index = length - 1;

    while (this[index].trim().isNotEmpty) {
      index -= 1;

      if (index == -1) {
        return -1;
      }
    }
    return index;
  }
}
