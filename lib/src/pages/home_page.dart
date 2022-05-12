import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:logger/logger.dart';
import 'package:morse_pad/src/providers/morse_provider.dart';
import 'package:morse_pad/src/providers/preference_provider.dart';
import 'package:morse_pad/src/providers/them_provider.dart';
import 'package:morse_pad/src/utilities/constants.dart';
import 'package:morse_pad/src/utilities/custom_icons.dart';
import 'package:morse_pad/src/widgets/custom_icon_button.dart';
import 'package:morse_pad/src/widgets/morse_code_box.dart';
import 'package:morse_pad/src/widgets/plain_text_box.dart';
import 'package:provider/provider.dart';

// Logger
final Logger log = Logger();

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  late final TextEditingController _plainTextController;
  late final TextEditingController _morseCodeController;

  @override
  void initState() {
    super.initState();
    _plainTextController = TextEditingController();
    _morseCodeController = TextEditingController();
  }

  @override
  void dispose() {
    _plainTextController.dispose();
    _morseCodeController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        leading: CustomIconButton(
          icon: const Icon(CustomIcons.about),
          onPressed: () {
            // TODO: 5/8/2022 Open about page
          },
          tooltip: "About",
        ),
        title: Row(
          mainAxisSize: MainAxisSize.min,
          children: const [
            Icon(CustomIcons.chevronLeft),
            Text(appTitle),
            Icon(CustomIcons.chevronRight),
          ],
        ),
        actions: [_buildThemeButton()],
      ),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        padding: const EdgeInsets.symmetric(vertical: 8),
        child: Consumer<MorseProvider>(
          builder: (context, morseProvider, child) {
            if (morseProvider.getPlainTextFocus()) {
              _morseCodeController.text = morseProvider.getMorseCode();
            } else if (morseProvider.getMorseCodeFocus()) {
              _plainTextController.text = morseProvider.getPlainText();
            }

            return Column(
              children: [
                PlainTextBox(controller: _plainTextController),
                MorseCodeBox(controller: _morseCodeController),
              ],
            );
          },
        ),
      ),
    );
  }

  Widget _buildThemeButton() {
    return Consumer<PreferenceProvider>(
      builder: (context, prefProvider, child) {
        final ThemeMode? currentTheme = prefProvider.getThemeMode();

        Icon? themeIcon;

        if (currentTheme == ThemeMode.light) {
          themeIcon = const Icon(CustomIcons.lightTheme);
        } else if (currentTheme == ThemeMode.dark) {
          themeIcon = const Icon(CustomIcons.darkTheme);
        } else {
          themeIcon = const Icon(CustomIcons.systemTheme);
        }

        return Container(
          padding: const EdgeInsets.only(right: 8),
          child: CustomIconButton(
            icon: themeIcon,
            onPressed: () {
              _switchTheme();
            },
            tooltip: "Switch theme",
          ),
        );
      },
    );
  }

  void _switchTheme() {
    final PreferenceProvider prefProvider =
        Provider.of<PreferenceProvider>(context, listen: false);
    final ThemeProvider themeProvider =
        Provider.of<ThemeProvider>(context, listen: false);

    final ThemeMode? currentTheme = prefProvider.getThemeMode();

    if (currentTheme == ThemeMode.light) {
      prefProvider.setThemeMode(ThemeMode.dark);
      themeProvider.setTheme(ThemeMode.dark);

      Fluttertoast.showToast(
        msg: darkThemeEnabled,
        toastLength: Toast.LENGTH_SHORT,
      );
    } else if (currentTheme == ThemeMode.dark) {
      prefProvider.setThemeMode(ThemeMode.system);
      themeProvider.setTheme(ThemeMode.system);

      Fluttertoast.showToast(
        msg: systemThemeEnabled,
        toastLength: Toast.LENGTH_SHORT,
      );
    } else {
      prefProvider.setThemeMode(ThemeMode.light);
      themeProvider.setTheme(ThemeMode.light);

      Fluttertoast.showToast(
        msg: lightThemeEnabled,
        toastLength: Toast.LENGTH_SHORT,
      );
    }
  }
}
