import 'dart:math';

import 'package:bmfont_xml/bmfont_xml.dart';

class LayoutChar {
  final Rectangle<int> source;

  final Rectangle<int> destination;

  final int page;

  LayoutChar({this.source, this.destination, this.page});

  @override
  String toString() =>
      'LayoutChar(source: $source, destination: ${destination}, page: $page)';
}

List<LayoutChar> layout(
    int width, int height, List<int> text, BitmapFont font) {
  final ret = <LayoutChar>[];

  int lineHeight = font.common.lineHeight;
  int previousChar;

  // TODO handle if height is less than lineHeight

  int currentX = 0;
  int currentTop = 0;
  int currentBase = currentTop + font.common.base;

  for (int char in text) {
    final bmChar = font.chars[char];
    if (bmChar == null) {
      // TODO print unprintable character?
      continue;
    }

    // Kerning
    int kerning = 0;
    if (previousChar != null) {
      final m = font.kernings[previousChar];
      if (m != null) {
        kerning = m[char] ?? 0;
      }
    }
    currentX -= kerning;

    // Check if we can fit the char in this line
    int nextX = currentX + bmChar.xAdvance;
    if (nextX > width) {
      currentX = 0;
      nextX = 0;
      currentTop += lineHeight;
      currentBase = currentTop + font.common.base;
      // TODO check if height exceeds
      previousChar = null;
    } else {
      previousChar = char;
    }

    ret.add(LayoutChar(
        source: Rectangle<int>(bmChar.x, bmChar.y, bmChar.width, bmChar.height),
        destination: Rectangle<int>(currentX + bmChar.xOffset,
            currentTop + bmChar.yOffset, bmChar.width, bmChar.height),
        page: bmChar.page));

    currentX = nextX;
  }

  return ret;
}
