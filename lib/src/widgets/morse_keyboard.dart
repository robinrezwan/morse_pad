import 'package:flutter/material.dart';
import 'package:morse_pad/src/utilities/custom_icons.dart';

class MorseKeyboard extends StatelessWidget {
  const MorseKeyboard({
    Key? key,
    required this.onPressKey,
  }) : super(key: key);

  final void Function(String value) onPressKey;

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(10),
          topRight: Radius.circular(10),
        ),
      ),
      elevation: 4,
      child: Container(
        padding: const EdgeInsets.all(8),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              children: [
                Expanded(
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 15),
                      primary: Theme.of(context).colorScheme.background,
                      onPrimary: Theme.of(context).colorScheme.onBackground,
                      textStyle: const TextStyle(
                        fontSize: 40,
                        fontWeight: FontWeight.bold,
                      ),
                      splashFactory: NoSplash.splashFactory,
                    ),
                    child: const Text("·"),
                    onPressed: () {
                      onPressKey(".");
                    },
                  ),
                ),
                const SizedBox(width: 5),
                Expanded(
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 15),
                      primary: Theme.of(context).colorScheme.background,
                      onPrimary: Theme.of(context).colorScheme.onBackground,
                      textStyle: const TextStyle(
                        fontSize: 40,
                        fontWeight: FontWeight.bold,
                      ),
                      splashFactory: NoSplash.splashFactory,
                    ),
                    child: const Text("−"),
                    onPressed: () {
                      onPressKey("-");
                    },
                  ),
                ),
              ],
            ),
            const SizedBox(height: 5),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.all(0),
                    fixedSize: const Size(45, 45),
                    primary: Theme.of(context).colorScheme.background,
                    onPrimary: Theme.of(context).colorScheme.onBackground,
                    textStyle: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                    splashFactory: NoSplash.splashFactory,
                  ),
                  child: const Text("/"),
                  onPressed: () {
                    onPressKey("/");
                  },
                ),
                const SizedBox(width: 5),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    fixedSize: const Size(140, 45),
                    splashFactory: NoSplash.splashFactory,
                  ),
                  child: null,
                  onPressed: () {
                    onPressKey(" ");
                  },
                ),
                const SizedBox(width: 5),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.all(0),
                    fixedSize: const Size(45, 45),
                    primary: Theme.of(context).colorScheme.background,
                    onPrimary: Theme.of(context).colorScheme.onBackground,
                    splashFactory: NoSplash.splashFactory,
                  ),
                  child: const Icon(CustomIcons.backspace),
                  onPressed: () {
                    onPressKey("\\");
                  },
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
