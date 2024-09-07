
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher_string.dart';

class AboutPage extends StatefulWidget {
  const AboutPage({
    super.key,
  });

  @override
  State<AboutPage> createState() => _AboutPageState();
}

class _AboutPageState extends State<AboutPage> {
  final String _githubLink = 'https://github.com/nathanogunleye';
  final TextStyle _textStyle = const TextStyle(
    fontSize: 25.0,
    fontWeight: FontWeight.bold,
  );

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Text(
              'Created by Nathan Ogunleye',
              style: _textStyle,
            ),
            InkWell(
                child: Text(
                  _githubLink,
                  style: _textStyle,
                ),
                onTap: () => launchUrlString(_githubLink)),
          ],
        ),
      ),
    );
  }
}
