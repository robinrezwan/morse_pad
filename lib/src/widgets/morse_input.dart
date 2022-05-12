import 'package:flutter/material.dart';
// ignore: import_of_legacy_library_into_null_safe
import 'package:flutter_icons/flutter_icons.dart';

class MorseInput extends StatelessWidget {
  const MorseInput({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 0, horizontal: 16),
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(10),
        ),
      ),
      /*shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.all(
          Radius.circular(10),
        ),
      ),*/
      elevation: 0,
      color: const Color(0xFFF8F8F8),
      // color: Colors.blueAccent,
      child: Container(
        margin: const EdgeInsets.fromLTRB(8, 8, 8, 8),
        child: Wrap(
          children: [
            Column(
              children: [
                Row(
                  children: [
                    Expanded(
                      child: RaisedButton(
                        shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(
                            Radius.circular(8),
                          ),
                        ),
                        color: Colors.white,
                        splashColor: Colors.transparent,
                        child: Container(
                          padding: const EdgeInsets.all(8),
                          child: const Text(
                            ".",
                            style: TextStyle(
                              fontSize: 40,
                            ),
                          ),
                        ),
                        onPressed: () {},
                      ),
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: RaisedButton(
                        shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(
                            Radius.circular(8),
                          ),
                        ),
                        color: Colors.white,
                        splashColor: Colors.transparent,
                        child: Container(
                          padding: const EdgeInsets.all(8),
                          child: const Text(
                            "-",
                            style: TextStyle(
                              fontSize: 40,
                            ),
                          ),
                        ),
                        onPressed: () {},
                      ),
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ButtonTheme(
                      minWidth: 36,
                      child: RaisedButton(
                        shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(
                            Radius.circular(8),
                          ),
                        ),
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        color: Colors.white,
                        splashColor: Colors.transparent,
                        child: const Text(
                          "/",
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        onPressed: () {},
                      ),
                    ),
                    const SizedBox(width: 8),
                    RaisedButton(
                      shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(
                          Radius.circular(8),
                        ),
                      ),
                      color: Colors.blueAccent,
                      splashColor: Colors.transparent,
                      padding: EdgeInsets.symmetric(horizontal: 70),
                      onPressed: () {},
                    ),
                    const SizedBox(width: 8),
                    ButtonTheme(
                      minWidth: 36,
                      child: RaisedButton(
                        shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(
                            Radius.circular(8),
                          ),
                        ),
                        padding: const EdgeInsets.symmetric(horizontal: 12),
                        color: Colors.white,
                        splashColor: Colors.transparent,
                        child: const Icon(Feather.delete),
                        onPressed: () {},
                      ),
                    ),
                  ],
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
