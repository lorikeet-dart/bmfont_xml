import 'dart:html';

import 'package:bmfont_xml/bmfont_xml.dart';

class LayoutChar {
  final Rectangle<int> source;

  final Rectangle<int> destination;

  final int page;

  LayoutChar({this.source, this.destination, this.page});
}

dynamic layout(int width, int height, List<int> text, BitmapFont font) {
  int lineHeight = font.common.lineHeight;

  // TODO handle if height is less than lineHeight

  int currentX = 0;
  int currentTop = 0;
  int currentBase = currentTop + font.common.base;

  for(int char in text) {
    final bmChar = font.chars[char];
    if(bmChar != null) {
      // TODO print unprintable character?
      continue;
    }

    // TODO kerning
    final nextX = currentX + bmChar.xAdvance;
    if(nextX > width) {
      currentX = 0;
      currentTop += lineHeight;
      currentBase = currentTop + font.common.base;
      // TODO check if height exceeds
    }


    // TODO
  }

  // TODO
}