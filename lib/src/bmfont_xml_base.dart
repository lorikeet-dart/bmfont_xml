// http://www.angelcode.com/products/bmfont/doc/file_format.html

import 'dart:math';

class BitmapFont {
  final Info info;

  final List<Page> pages;

  final Common common;

  final List<Kerning> kernings;

  final Map<int, Char> chars;

  BitmapFont({this.info, this.pages, this.common, this.kernings, this.chars});

  Map<String, dynamic> toJson() => {
        'info': info?.toJson(),
        'pages': pages?.map((e) => e.toJson())?.toList(),
        'common': common?.toJson(),
        'kernings': kernings?.map((e) => e.toJson())?.toList(),
        'chars': chars?.values?.map((e) => e.toJson())?.toList(),
      };

  @override
  String toString() => toJson().toString();
}

class Common {
  final int lineHeight;

  final int base;

  final int scaleW;

  final int scaleH;

  final int pages;

  final bool packed;

  final int alphaChnl;

  final int redChnl;

  final int greenChnl;

  final int blueChnl;

  Common(
      {this.lineHeight,
      this.base,
      this.scaleW,
      this.scaleH,
      this.pages,
      this.packed,
      this.alphaChnl,
      this.redChnl,
      this.greenChnl,
      this.blueChnl});

  Map<String, dynamic> toJson() => {
        'lineHeight': lineHeight,
        'base': base,
        'scaleW': scaleW,
        'scaleH': scaleH,
        'pages': pages,
        'packed': packed ? 1 : 0,
        'alphaChnl': alphaChnl,
        'redChnl': redChnl,
        'greenChnl': greenChnl,
        'blueChnl': blueChnl
      };
}

class Padding {
  final int up;

  final int down;

  final int left;

  final int right;

  Padding({this.up, this.down, this.left, this.right});

  Map<String, dynamic> toJson() => {
        'up': up,
        'down': down,
        'left': left,
        'right': right,
      };
}

class Spacing {
  final int horizontal;

  final int vertical;

  Spacing({this.horizontal, this.vertical});

  Map<String, dynamic> toJson() => {
        'horizontal': horizontal,
        'vertical': vertical,
      };
}

class Info {
  final String face;

  final int size;

  final bool bold;

  final bool italic;

  final int charset;

  final bool unicode;

  final num stretchH;

  final bool smooth;

  final int aa;

  final Padding padding;

  final Spacing spacing;

  final int outline;

  Info(
      {this.face,
      this.size,
      this.bold,
      this.italic,
      this.charset,
      this.unicode,
      this.stretchH,
      this.smooth,
      this.aa,
      this.padding,
      this.spacing,
      this.outline});

  Map<String, dynamic> toJson() => {
        'face': face,
        'size': size,
        'bold': bold ? 1 : 0,
        'italic': italic ? 1 : 0,
        'charset': charset,
        'unicode': unicode ? 1 : 0,
        'stretchH': stretchH,
        'smooth': smooth ? 1 : 0,
        'aa': aa,
        'padding': padding?.toJson(),
        'spacing': spacing?.toJson(),
        'outline': outline,
      };
}

class Char {
  final int id;

  final int x;

  final int y;

  final int width;

  final int height;

  final int xOffset;

  final int yOffset;

  final int xAdvance;

  final int page;

  final int chnl;

  Char(
      {this.id,
      this.x,
      this.y,
      this.width,
      this.height,
      this.xOffset,
      this.yOffset,
      this.xAdvance,
      this.page,
      this.chnl});

  Rectangle<int> _region;

  Rectangle<int> get region => _region ??= Rectangle(x, y, width, height);

  Map<String, dynamic> toJson() => {
        'id': id,
        'x': x,
        'y': y,
        'width': width,
        'height': height,
        'xOffset': xOffset,
        'yOffset': yOffset,
        'xAdvance': xAdvance,
        'page': page,
        'chnl': chnl
      };
}

class Kerning {
  final int first;

  final int second;

  final int amount;

  Kerning({this.first, this.second, this.amount});

  Map<String, dynamic> toJson() => {
        'first': first,
        'second': second,
        'amount': amount,
      };
}

class Page {
  final int id;

  final String file;

  Page({this.id, this.file});

  Map<String, dynamic> toJson() => {
        'id': id,
        'file': file,
      };
}
