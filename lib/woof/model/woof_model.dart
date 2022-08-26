import 'dart:convert';

import 'package:flutter/foundation.dart';

class Woof {
  WoofType type;
  String url;

  Woof({
    required this.type,
    required this.url,
  });

  static Woof fromJson(Map<String, dynamic> map) {
    final url = map['url'] as String;

    if (url.endsWith('.mp4') || url.endsWith('.webm')) {
      if (kDebugMode) {
        print('Video: $url');
      }

      return Woof(
        type: WoofType.video,
        url: url,
      );
    } else {
      if (kDebugMode) {
        print('Image: $url');
      }

      return Woof(
        type: WoofType.image,
        url: url,
      );
    }
  }
}

enum WoofType { image, video }
