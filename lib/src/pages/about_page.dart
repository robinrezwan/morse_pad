import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:logger/logger.dart';
import 'package:morse_pad/src/utilities/constants.dart';
import 'package:morse_pad/src/utilities/custom_icons.dart';
import 'package:morse_pad/src/utilities/perspective_rotation.dart';
import 'package:morse_pad/src/widgets/custom_icon_button.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:url_launcher/url_launcher.dart';

// Logger
final Logger log = Logger();

class AboutPage extends StatefulWidget {
  const AboutPage({Key? key}) : super(key: key);

  @override
  _AboutPageState createState() => _AboutPageState();
}

class _AboutPageState extends State<AboutPage> {
  String _appVersion = "Version: 0.0.0";
  String _aboutMorseCode = "";

  @override
  void initState() {
    super.initState();
    _getPackageInfo();
    _getAboutMorseCode();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        titleSpacing: 0,
        leading: CustomIconButton(
          icon: const Icon(CustomIcons.back),
          tooltip: "Back",
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: const Text("About"),
      ),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(
          children: [
            Container(
              alignment: Alignment.center,
              padding: const EdgeInsets.only(top: 8),
              child: Column(
                children: [
                  PerspectiveRotation(
                    child: SvgPicture.asset(
                      'lib/assets/images/app_icon.svg',
                      width: 60,
                      height: 60,
                      theme: SvgTheme(
                        currentColor:
                            Theme.of(context).textTheme.displayLarge!.color,
                      ),
                    ),
                  ),
                  const Text(
                    appTitle,
                    style: TextStyle(fontSize: 22),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    _appVersion,
                    style: TextStyle(
                      fontSize: 12,
                      color: Theme.of(context).textTheme.caption!.color,
                    ),
                  ),
                ],
              ),
            ),
            Container(
              padding: const EdgeInsets.all(16),
              child: const Text(
                aboutApp,
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 16),
              ),
            ),
            Markdown(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              data: _aboutMorseCode,
              styleSheet: MarkdownStyleSheet(blockSpacing: 16),
              onTapLink: (text, href, title) {
                launchUrl(
                  Uri.parse(href!),
                  mode: LaunchMode.externalApplication,
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _getPackageInfo() async {
    final PackageInfo packageInfo = await PackageInfo.fromPlatform();

    setState(() {
      _appVersion = "Version: ${packageInfo.version}";
    });
  }

  Future<void> _getAboutMorseCode() async {
    final String aboutMorseCode = await DefaultAssetBundle.of(context)
        .loadString('lib/assets/text/about_morse_code.md');

    setState(() {
      _aboutMorseCode = aboutMorseCode;
    });
  }
}
