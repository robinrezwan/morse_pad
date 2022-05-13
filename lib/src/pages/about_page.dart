import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:morse_pad/src/utilities/constants.dart';
import 'package:morse_pad/src/utilities/custom_icons.dart';
import 'package:morse_pad/src/widgets/custom_icon_button.dart';
import 'package:package_info_plus/package_info_plus.dart';

class AboutPage extends StatefulWidget {
  const AboutPage({Key? key}) : super(key: key);

  @override
  _AboutPageState createState() => _AboutPageState();
}

class _AboutPageState extends State<AboutPage> {
  String _version = "Version: 0.0.0";

  Offset _offset = Offset.zero;

  @override
  void initState() {
    super.initState();
    _getPackageInfo();
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
        child: Column(
          children: [
            Container(
              alignment: Alignment.center,
              padding: const EdgeInsets.only(top: 8),
              child: Column(
                children: [
                  Transform(
                    transform: Matrix4.identity()
                      ..rotateX(0.01 * _offset.dy)
                      ..rotateY(-0.01 * _offset.dx),
                    alignment: FractionalOffset.center,
                    child: GestureDetector(
                      onPanUpdate: (details) {
                        setState(() => _offset += details.delta);
                      },
                      onDoubleTap: () {
                        setState(() => _offset = Offset.zero);
                      },
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
                  ),
                  const Text(
                    appTitle,
                    style: TextStyle(
                      fontSize: 22,
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    _version,
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
                style: TextStyle(
                  fontSize: 16,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _getPackageInfo() async {
    final PackageInfo packageInfo = await PackageInfo.fromPlatform();

    setState(() {
      _version = "Version: ${packageInfo.version}";
    });
  }
}
