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
    return WillPopScope(
      onWillPop: () async {
        Navigator.of(context).pop();
        return false;
      },
      child: Container(
        padding: const EdgeInsets.all(8),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Expanded(
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.all(0),
                      minimumSize: const Size(0, 48),
                      primary: Theme.of(context).colorScheme.background,
                      onPrimary: Theme.of(context).colorScheme.onBackground,
                      splashFactory: NoSplash.splashFactory,
                    ),
                    child: const Icon(CustomIcons.chevronBackEnd),
                    onPressed: () async {
                      onPressKey("|<");
                    },
                  ),
                ),
                const SizedBox(width: 5),
                Expanded(
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.all(0),
                      minimumSize: const Size(0, 48),
                      primary: Theme.of(context).colorScheme.background,
                      onPrimary: Theme.of(context).colorScheme.onBackground,
                      splashFactory: NoSplash.splashFactory,
                    ),
                    child: const Icon(CustomIcons.chevronDoubleBack),
                    onPressed: () async {
                      onPressKey("<<");
                    },
                  ),
                ),
                const SizedBox(width: 5),
                Expanded(
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.all(0),
                      minimumSize: const Size(0, 48),
                      primary: Theme.of(context).colorScheme.background,
                      onPrimary: Theme.of(context).colorScheme.onBackground,
                      splashFactory: NoSplash.splashFactory,
                    ),
                    child: const Icon(CustomIcons.chevronBack),
                    onPressed: () async {
                      onPressKey("<");
                    },
                  ),
                ),
                const SizedBox(width: 5),
                Expanded(
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.all(0),
                      minimumSize: const Size(0, 48),
                      primary: Theme.of(context).colorScheme.background,
                      onPrimary: Theme.of(context).colorScheme.onBackground,
                      splashFactory: NoSplash.splashFactory,
                    ),
                    child: const Icon(CustomIcons.chevronForward),
                    onPressed: () {
                      onPressKey(">");
                    },
                  ),
                ),
                const SizedBox(width: 5),
                Expanded(
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.all(0),
                      minimumSize: const Size(0, 48),
                      primary: Theme.of(context).colorScheme.background,
                      onPrimary: Theme.of(context).colorScheme.onBackground,
                      splashFactory: NoSplash.splashFactory,
                    ),
                    child: const Icon(CustomIcons.arrowDoubleForward),
                    onPressed: () {
                      onPressKey(">>");
                    },
                  ),
                ),
                const SizedBox(width: 5),
                Expanded(
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.all(0),
                      minimumSize: const Size(0, 48),
                      primary: Theme.of(context).colorScheme.background,
                      onPrimary: Theme.of(context).colorScheme.onBackground,
                      splashFactory: NoSplash.splashFactory,
                    ),
                    child: const Icon(CustomIcons.chevronForwardEnd),
                    onPressed: () {
                      onPressKey(">|");
                    },
                  ),
                ),
              ],
            ),
            const SizedBox(height: 5),
            Row(
              children: [
                Expanded(
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.all(0),
                      minimumSize: const Size(0, 90),
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
                      padding: const EdgeInsets.all(0),
                      minimumSize: const Size(0, 90),
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
                SizedBox(
                  width: 45,
                  height: 48,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.all(0),
                      primary: Theme.of(context).colorScheme.background,
                      onPrimary: Theme.of(context).colorScheme.onBackground,
                      splashFactory: NoSplash.splashFactory,
                    ),
                    child: const Icon(CustomIcons.keyboardHide),
                    onPressed: () async {
                      Navigator.of(context).pop();
                    },
                  ),
                ),
                const SizedBox(width: 5),
                SizedBox(
                  width: 45,
                  height: 48,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.all(0),
                      primary: Theme.of(context).colorScheme.background,
                      onPrimary: Theme.of(context).colorScheme.onBackground,
                      splashFactory: NoSplash.splashFactory,
                    ),
                    child: const Icon(CustomIcons.forwardSlash),
                    onPressed: () {
                      onPressKey("/");
                    },
                  ),
                ),
                const SizedBox(width: 5),
                Expanded(
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      minimumSize: const Size(0, 48),
                      splashFactory: NoSplash.splashFactory,
                    ),
                    child: null,
                    onPressed: () {
                      onPressKey(" ");
                    },
                  ),
                ),
                const SizedBox(width: 5),
                SizedBox(
                  width: 45,
                  height: 48,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.all(0),
                      primary: Theme.of(context).colorScheme.background,
                      onPrimary: Theme.of(context).colorScheme.onBackground,
                      splashFactory: NoSplash.splashFactory,
                    ),
                    child: const Icon(CustomIcons.backspace),
                    onPressed: () {
                      onPressKey("\\");
                    },
                  ),
                ),
                const SizedBox(width: 5),
                SizedBox(
                  width: 45,
                  height: 48,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.all(0),
                      primary: Theme.of(context).colorScheme.background,
                      onPrimary: Theme.of(context).colorScheme.onBackground,
                      splashFactory: NoSplash.splashFactory,
                    ),
                    child: const Icon(CustomIcons.enter),
                    onPressed: () {
                      onPressKey("\n");
                    },
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
