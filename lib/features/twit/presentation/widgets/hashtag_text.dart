import 'package:auto_route/auto_route.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:twit/app/routes/app_route.gr.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../../../theme/color_palette.dart';

class HashtagText extends StatelessWidget {
  const HashtagText({super.key, required this.text});

  final String text;

  @override
  Widget build(BuildContext context) {
    final List<InlineSpan> spans = [];

    text.split(' ').forEach((word) {
      if (word.contains('#')) {
        spans.add(
          TextSpan(
            text: '$word ',
            style: Theme.of(context).textTheme.bodyLarge?.copyWith(
              color: ColorPalette.blueColor,
              fontWeight: FontWeight.bold,
              fontSize: 20,
            ),
            recognizer: TapGestureRecognizer()
              ..onTap = () {
                /// do navigation here
                context.router.push(HashtagRoute(hashtag: word));
              },
          ),
        );
      } else if (word.contains('http://') ||
          word.contains('https://') ||
          word.contains('www.')) {
        spans.add(
          TextSpan(
            text: '$word ',
            style: Theme.of(context).textTheme.bodyLarge?.copyWith(
              color: ColorPalette.blueColor,
              fontSize: 20,
            ),
            recognizer: TapGestureRecognizer()
              ..onTap = () async {
                final uri = Uri.parse(word);
                print(uri);
                launchUrl(uri, mode: LaunchMode.externalApplication);
              },
          ),
        );
      } else {
        spans.add(
          TextSpan(
            text: '$word ',
            style: Theme.of(
              context,
            ).textTheme.bodyLarge?.copyWith(fontSize: 20),
          ),
        );
      }
    });

    return RichText(text: TextSpan(children: spans));
  }
}
