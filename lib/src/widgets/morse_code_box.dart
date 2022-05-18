import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:logger/logger.dart';
import 'package:morse_pad/src/providers/morse_provider.dart';
import 'package:morse_pad/src/utilities/constants.dart';
import 'package:morse_pad/src/utilities/custom_icons.dart';
import 'package:morse_pad/src/utilities/morse_code_player.dart';
import 'package:morse_pad/src/utilities/string_extension.dart';
import 'package:morse_pad/src/widgets/custom_icon_button.dart';
import 'package:morse_pad/src/widgets/morse_keyboard.dart';
import 'package:morse_pad/src/widgets/text_box.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:provider/provider.dart';
import 'package:share_plus/share_plus.dart';

// Logger
final Logger log = Logger();

class MorseCodeBox extends StatefulWidget {
  const MorseCodeBox({
    Key? key,
    required this.controller,
  }) : super(key: key);

  final TextEditingController controller;

  @override
  State<MorseCodeBox> createState() => _MorseCodeBoxState();
}

class _MorseCodeBoxState extends State<MorseCodeBox> {
  final FocusNode _focusNode = FocusNode();
  final MorseCodePlayer _morseCodePlayer = MorseCodePlayer();

  PersistentBottomSheetController? _bottomSheetController;

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance?.addPostFrameCallback((duration) {
      final MorseProvider morseProvider =
          Provider.of<MorseProvider>(context, listen: false);

      _morseCodePlayer.initPlayer(
        onStartOrStop: (isPlaying) {
          morseProvider.setMorseCodePlaying(isPlaying);
        },
        onProgress: (progress) {
          morseProvider.setMorseCodePlayingProgress(progress);
        },
      );
    });
  }

  @override
  void dispose() {
    _morseCodePlayer.disposePlayer();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final MorseProvider morseProvider =
        Provider.of<MorseProvider>(context, listen: false);

    return TextBox(
      // keyboardType: TextInputType.multiline,
      keyboardType: TextInputType.none,
      prefixIcon: Consumer<MorseProvider>(
        builder: (context, morseProvider, child) {
          if (morseProvider.getMorseCodePlaying()) {
            return CircularPercentIndicator(
              radius: 12.0,
              lineWidth: 2.5,
              animateFromLastPercent: true,
              percent: morseProvider.getMorseCodePlayingProgress(),
            );
          } else {
            return const Icon(CustomIcons.code);
          }
        },
      ),
      hintText: "Morse code",
      focusNode: _focusNode,
      controller: widget.controller,
      onFocusChange: (hasFocus) {
        morseProvider.setMorseCodeFocus(hasFocus);

        if (!hasFocus) {
          _bottomSheetController?.close();
          _bottomSheetController = null;
        }
      },
      onValueChange: (value) {
        _morseCodePlayer.stop();
        morseProvider.setMorseCode(value);
      },
      onTap: () async {
        _morseCodePlayer.stop();

        if (_bottomSheetController == null) {
          Future.delayed(const Duration(milliseconds: 100), () {
            _bottomSheetController = Scaffold.of(context).showBottomSheet(
              (BuildContext context) {
                return MorseKeyboard(
                  onPressKey: (value) {
                    _updateTextFiled(value);
                    morseProvider.setMorseCode(widget.controller.text);
                  },
                );
              },
            );

            _bottomSheetController!.closed.then((value) {
              _bottomSheetController = null;
            });
          });
        }
      },
      actions: [
        Consumer<MorseProvider>(
          builder: (context, morseProvider, child) {
            return CustomIconButton(
              icon: morseProvider.getMorseCodePlaying()
                  ? const Icon(CustomIcons.stop)
                  : const Icon(CustomIcons.play),
              tooltip: morseProvider.getMorseCodePlaying() ? "Stop" : "Play",
              onPressed: () {
                if (morseProvider.getMorseCode().isNotEmpty) {
                  morseProvider.getMorseCodePlaying()
                      ? _morseCodePlayer.stop()
                      : _morseCodePlayer.play(morseProvider.getMorseCode());
                } else {
                  Fluttertoast.showToast(
                    msg: emptyCode,
                    toastLength: Toast.LENGTH_SHORT,
                  );
                }
              },
            );
          },
        ),
        CustomIconButton(
          icon: const Icon(CustomIcons.copy),
          tooltip: "Copy",
          onPressed: () {
            if (morseProvider.getMorseCode().isNotEmpty) {
              Clipboard.setData(ClipboardData(text: widget.controller.text));

              Fluttertoast.showToast(
                msg: codeCopied,
                toastLength: Toast.LENGTH_SHORT,
              );
            } else {
              Fluttertoast.showToast(
                msg: emptyCode,
                toastLength: Toast.LENGTH_SHORT,
              );
            }
          },
        ),
        CustomIconButton(
          icon: const Icon(CustomIcons.paste),
          tooltip: "Paste",
          onPressed: () async {
            _morseCodePlayer.stop();

            final ClipboardData? data = await Clipboard.getData('text/plain');
            final String? value = data?.text;

            if (value?.isNotEmpty == true) {
              _focusNode.requestFocus();

              widget.controller.value = TextEditingValue(
                text: value!,
                selection: TextSelection.collapsed(offset: value.length),
              );

              morseProvider.setMorseCode(value);
            }
          },
        ),
        CustomIconButton(
          icon: const Icon(CustomIcons.clear),
          tooltip: "Clear",
          onPressed: () async {
            _morseCodePlayer.stop();

            morseProvider.setMorseCode("");
            widget.controller.clear();

            Fluttertoast.showToast(
              msg: codeCleared,
              toastLength: Toast.LENGTH_SHORT,
            );
          },
        ),
        CustomIconButton(
          icon: const Icon(CustomIcons.share),
          tooltip: "Share",
          onPressed: () {
            if (morseProvider.getMorseCode().isNotEmpty) {
              Share.share("${widget.controller.text} \n\n"
                  "- shared by 📱 Morse Pad");
            } else {
              Fluttertoast.showToast(
                msg: emptyCode,
                toastLength: Toast.LENGTH_SHORT,
              );
            }
          },
        ),
      ],
    );
  }

  void _updateTextFiled(String value) {
    String text = widget.controller.text;
    TextSelection selection = widget.controller.selection;

    String textBefore = selection.textBefore(text);
    String textAfter = selection.textAfter(text);

    String updatedText;
    int cursorPosition;

    if (["|<", "<<", "<", ">", ">>", ">|"].contains(value)) {
      _updateTextSelection(value);
      return;
    }

    if (value == "\\") {
      // For removing the character before the cursor position

      if (selection.isCollapsed && textBefore.isNotEmpty) {
        updatedText =
            textBefore.substring(0, textBefore.length - 1) + textAfter;
        cursorPosition = textBefore.length - 1;
      } else {
        updatedText = textBefore + textAfter;
        cursorPosition = textBefore.length;
      }
    } else {
      // For inserting value into the text field in the cursor position

      updatedText = textBefore + value + textAfter;
      cursorPosition = textBefore.length + value.length;
    }

    widget.controller.clearComposing();
    widget.controller.value = TextEditingValue(
      text: updatedText,
      selection: TextSelection.collapsed(offset: cursorPosition),
    );
  }

  void _updateTextSelection(String value) {
    String text = widget.controller.text;
    TextSelection selection = widget.controller.selection;

    String textBefore = selection.textBefore(text);
    String textAfter = selection.textAfter(text);

    int cursorPosition = selection.start;

    if (value == "|<") {
      // For moving the cursor to the beginning of the previous word

      if (selection.start > 0) {
        while (textBefore.endsWithWhiteSpace || textBefore.endsWith("/")) {
          textBefore = textBefore.substring(0, textBefore.length - 1);
        }

        int slashIndex = textBefore.lastIndexOf(" / ");

        if (slashIndex >= 0) {
          while (textBefore[slashIndex].isWhiteSpace ||
              textBefore[slashIndex] == "/") {
            slashIndex += 1;
          }

          cursorPosition = slashIndex;
        } else {
          cursorPosition = 0;
        }
      }
    } else if (value == "<<") {
      // For moving the cursor to the beginning of the previous letter

      if (selection.start > 0) {
        while (textBefore.endsWithWhiteSpace || textBefore.endsWith("/")) {
          textBefore = textBefore.substring(0, textBefore.length - 1);
        }

        int whiteSpaceIndex = textBefore.lastIndexOfWhiteSpace;

        if (whiteSpaceIndex >= 0) {
          cursorPosition = whiteSpaceIndex + 1;
        } else {
          cursorPosition = 0;
        }
      }
    } else if (value == "<") {
      // For moving the cursor one character behind

      if (selection.start > 0) {
        cursorPosition = selection.start - 1;
      }
    } else if (value == ">") {
      // For moving the cursor one character ahead

      if (selection.start < text.length) {
        cursorPosition = selection.start + 1;
      }
    } else if (value == ">>") {
      // For moving the cursor to the beginning of the next letter

      if (selection.start < text.length) {
        int whiteSpaceIndex = textAfter.indexOfWhiteSpace;

        if (whiteSpaceIndex >= 0) {
          while (textAfter[whiteSpaceIndex].isWhiteSpace ||
              textAfter[whiteSpaceIndex] == "/") {
            whiteSpaceIndex += 1;
          }
          cursorPosition = textBefore.length + whiteSpaceIndex;
        }
      }
    } else if (value == ">|") {
      // For moving the cursor to the beginning of the next word

      if (selection.start < text.length) {
        if (textAfter.startsWithWhiteSpace || textAfter[0] == "/") {
          int whiteSpaceIndex = 0;

          if (whiteSpaceIndex >= 0) {
            while (textAfter[whiteSpaceIndex].isWhiteSpace ||
                textAfter[whiteSpaceIndex] == "/") {
              whiteSpaceIndex += 1;
            }
            cursorPosition = textBefore.length + whiteSpaceIndex;
          }
        } else {
          int slashIndex = textAfter.indexOf(" / ");

          if (slashIndex >= 0) {
            while (textAfter[slashIndex].isWhiteSpace ||
                textAfter[slashIndex] == "/") {
              slashIndex += 1;
            }
            cursorPosition = textBefore.length + slashIndex;
          }
        }
      }
    }

    widget.controller.clearComposing();
    widget.controller.value = TextEditingValue(
      text: text,
      selection: TextSelection.collapsed(offset: cursorPosition),
    );
  }
}
