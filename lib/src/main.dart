import 'package:flutter/material.dart';
import 'package:morse_pad/src/pages/home_page.dart';
import 'package:morse_pad/src/providers/morse_provider.dart';
import 'package:morse_pad/src/providers/preference_provider.dart';
import 'package:morse_pad/src/providers/them_provider.dart';
import 'package:morse_pad/src/themes/system_ui_theme.dart';
import 'package:morse_pad/src/utilities/constants.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final PreferenceProvider prefProvider =
      PreferenceProvider(await SharedPreferences.getInstance());

  final ThemeProvider themeProvider =
      ThemeProvider(prefProvider.getThemeMode());

  final MorseProvider morseProvider = MorseProvider();

  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(create: (context) => prefProvider),
      ChangeNotifierProvider(create: (context) => themeProvider),
      ChangeNotifierProvider(create: (context) => morseProvider),
    ],
    child: const MyApp(),
  ));
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> with WidgetsBindingObserver {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance!.addObserver(this);
  }

  @override
  void dispose() {
    WidgetsBinding.instance!.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed) {
      // FIXME: 5/12/2022 System navigation bar icon color changes back to default
      // when the app is goes to background and comes back to foreground again
      // https://stackoverflow.com/questions/69768956
      // Working around by setting the status bar and navigation bar every time
      // the app comes to foreground
      // Change it when the issue is resolved
      final ThemeMode currentTheme =
          Provider.of<PreferenceProvider>(context, listen: false)
              .getThemeMode();

      SystemUiTheme.setSystemChrome(currentTheme);
    }
  }

  @override
  void didChangePlatformBrightness() {
    final ThemeMode currentTheme =
        Provider.of<PreferenceProvider>(context, listen: false).getThemeMode();

    if (currentTheme == ThemeMode.system) {
      Provider.of<ThemeProvider>(context, listen: false).setTheme(currentTheme);
    }

    super.didChangePlatformBrightness();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: appTitle,
      theme: Provider.of<ThemeProvider>(context).getTheme(),
      home: const MyHomePage(),
    );
  }
}
