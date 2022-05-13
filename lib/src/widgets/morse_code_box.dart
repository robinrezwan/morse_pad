import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:logger/logger.dart';
import 'package:morse_pad/src/providers/morse_provider.dart';
import 'package:morse_pad/src/utilities/constants.dart';
import 'package:morse_pad/src/utilities/custom_icons.dart';
import 'package:morse_pad/src/utilities/morse_code_player.dart';
import 'package:morse_pad/src/widgets/custom_icon_button.dart';
import 'package:morse_pad/src/widgets/morse_keyboard.dart';
import 'package:morse_pad/src/widgets/text_box.dart';
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

  late PersistentBottomSheetController _bottomSheetController;

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance?.addPostFrameCallback((duration) {
      _morseCodePlayer.initPlayer((isPlaying) {
        Provider.of<MorseProvider>(context, listen: false)
            .setMorseCodePlaying(isPlaying);
      });
    });
  }

  @override
  void dispose() {
    _morseCodePlayer.disposePlayer();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final MorseProvider morseProvider = Provider.of<MorseProvider>(context);

    return TextBox(
      // keyboardType: TextInputType.multiline,
      keyboardType: TextInputType.none,
      prefixIconData: CustomIcons.code,
      hintText: "Morse code",
      focusNode: _focusNode,
      controller: widget.controller,
      onFocusChange: (hasFocus) {
        morseProvider.setMorseCodeFocus(hasFocus);

        if (hasFocus) {
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
          });
        } else {
          _bottomSheetController.close();
        }
      },
      onValueChange: (value) {
        morseProvider.setMorseCode(value);
      },
      actions: [
        CustomIconButton(
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
        ),
        CustomIconButton(
          icon: const Icon(CustomIcons.copy),
          tooltip: "Copy",
          onPressed: () {
            if (morseProvider.getMorseCode().isNotEmpty) {
              Clipboard.setData(
                ClipboardData(text: widget.controller.text),
              );

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

    if (value == "\\") {
      if (selection.isCollapsed && textBefore.isNotEmpty) {
        updatedText =
            textBefore.substring(0, textBefore.length - 1) + textAfter;
        cursorPosition = textBefore.length - 1;
      } else {
        updatedText = textBefore + textAfter;
        cursorPosition = textBefore.length;
      }
    } else {
      updatedText = textBefore + value + textAfter;
      cursorPosition = textBefore.length + value.length;
    }

    widget.controller.clearComposing();
    widget.controller.value = TextEditingValue(
      text: updatedText,
      selection: TextSelection.collapsed(offset: cursorPosition),
    );
  }
}
