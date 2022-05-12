import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:logger/logger.dart';
import 'package:morse_pad/src/providers/morse_provider.dart';
import 'package:morse_pad/src/utilities/constants.dart';
import 'package:morse_pad/src/utilities/custom_icons.dart';
import 'package:morse_pad/src/widgets/custom_icon_button.dart';
import 'package:morse_pad/src/widgets/plain_text_player.dart';
import 'package:morse_pad/src/widgets/text_box.dart';
import 'package:provider/provider.dart';
import 'package:share_plus/share_plus.dart';

// Logger
final Logger log = Logger();

class PlainTextBox extends StatefulWidget {
  const PlainTextBox({
    Key? key,
    required this.controller,
  }) : super(key: key);

  final TextEditingController controller;

  @override
  State<PlainTextBox> createState() => _PlainTextBoxState();
}

class _PlainTextBoxState extends State<PlainTextBox> {
  final FocusNode _focusNode = FocusNode();
  final PlainTextPlayer _plainTextPlayer = PlainTextPlayer();

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance?.addPostFrameCallback((duration) {
      _focusNode.requestFocus();

      _plainTextPlayer.initPlayer((isPlaying) {
        Provider.of<MorseProvider>(context, listen: false)
            .setPlainTextPlaying(isPlaying);
      });
    });
  }

  @override
  void dispose() {
    _plainTextPlayer.stop();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final MorseProvider morseProvider = Provider.of<MorseProvider>(context);

    return TextBox(
      keyboardType: TextInputType.multiline,
      prefixIconData: CustomIcons.text,
      hintText: "Plain text",
      focusNode: _focusNode,
      controller: widget.controller,
      onFocusChange: (hasFocus) {
        morseProvider.setPlainTextFocus(hasFocus);
      },
      onValueChange: (value) {
        morseProvider.setPlainText(value);
      },
      actions: [
        CustomIconButton(
          icon: morseProvider.getPlainTextPlaying()
              ? const Icon(CustomIcons.stop)
              : const Icon(CustomIcons.play),
          tooltip: morseProvider.getPlainTextPlaying() ? "Stop" : "Play",
          onPressed: () {
            if (morseProvider.getPlainText().isNotEmpty) {
              morseProvider.getPlainTextPlaying()
                  ? _plainTextPlayer.stop()
                  : _plainTextPlayer.play(morseProvider.getPlainText());
            } else {
              Fluttertoast.showToast(
                msg: emptyText,
                toastLength: Toast.LENGTH_SHORT,
              );
            }
          },
        ),
        CustomIconButton(
          icon: const Icon(CustomIcons.copy),
          tooltip: "Copy",
          onPressed: () {
            if (morseProvider.getPlainText().isNotEmpty) {
              Clipboard.setData(
                ClipboardData(text: widget.controller.text),
              );

              Fluttertoast.showToast(
                msg: textCopied,
                toastLength: Toast.LENGTH_SHORT,
              );
            } else {
              Fluttertoast.showToast(
                msg: emptyText,
                toastLength: Toast.LENGTH_SHORT,
              );
            }
          },
        ),
        CustomIconButton(
          icon: const Icon(CustomIcons.paste),
          tooltip: "Paste",
          onPressed: () async {
            _plainTextPlayer.stop();

            final ClipboardData? data = await Clipboard.getData('text/plain');
            final String? value = data?.text;

            if (value?.isNotEmpty == true) {
              _focusNode.requestFocus();

              widget.controller.value = TextEditingValue(
                text: value!,
                selection: TextSelection.collapsed(offset: value.length),
              );

              morseProvider.setPlainText(value);
            }
          },
        ),
        CustomIconButton(
          icon: const Icon(CustomIcons.clear),
          tooltip: "Clear",
          onPressed: () async {
            _plainTextPlayer.stop();

            morseProvider.setPlainText("");
            widget.controller.clear();

            Fluttertoast.showToast(
              msg: textCleared,
              toastLength: Toast.LENGTH_SHORT,
            );
          },
        ),
        CustomIconButton(
          icon: const Icon(CustomIcons.share),
          tooltip: "Share",
          onPressed: () {
            if (morseProvider.getPlainText().isNotEmpty) {
              Share.share("${widget.controller.text} \n\n"
                  "- shared by 📱 Morse Pad");
            } else {
              Fluttertoast.showToast(
                msg: emptyText,
                toastLength: Toast.LENGTH_SHORT,
              );
            }
          },
        ),
      ],
    );
  }
}
