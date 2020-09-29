import 'package:bmfont_xml/bmfont_xml.dart';

BitmapFont parseJson(Map json) {
  return BitmapFont(
      info: _parseInfo(json['info']),
      common: _parseCommon(json['common']),
      pages: _parsePages(json['pages']),
      chars: _parseChars(json['chars']),
      kernings: _parseKernings(json['kernings']));
}

Info _parseInfo(Map map) {
  if (map == null) return null;
  return Info(
      face: map['face'],
      size: map['size'],
      bold: map['bold'] == 1,
      italic: map['italic'] == 1,
      charset: map['charset'],
      unicode: map['unicode'] == 1,
      stretchH: map['stretchH'],
      smooth: map['smooth'] == 1,
      aa: map['aa'],
      padding: _parsePadding(map['padding']),
      spacing: _parseSpacing(map['spacing']),
      outline: map['outline']);
}

Padding _parsePadding(Map map) {
  if (map == null) return null;
  return Padding(
      down: map['down'], up: map['up'], left: map['left'], right: map['right']);
}

Spacing _parseSpacing(Map map) {
  if (map == null) return null;
  return Spacing(horizontal: map['horizontal'], vertical: map['vertical']);
}

Common _parseCommon(Map map) {
  if (map == null) return null;
  return Common(
      lineHeight: map['lineHeight'],
      base: map['base'],
      scaleW: map['scaleW'],
      scaleH: map['scaleH'],
      pages: map['pages'],
      packed: map['packed'] == 1,
      alphaChnl: map['alphaChnl'],
      redChnl: map['redChnl'],
      blueChnl: map['blueChnl'],
      greenChnl: map['greenChnl']);
}

Page _parsePage(Map map) {
  return Page(id: map['id'], file: map['file']);
}

List<Page> _parsePages(List list) {
  final ret = <Page>[];
  if (list == null) return ret;
  int i = 0;
  for (final e in list) {
    ret.add(Page(id: i++, file: e));
  }
  return ret;
}

Kerning _parseKerning(Map map) {
  if (map == null) throw Exception('');
  return Kerning(
      first: map['first'], second: map['second'], amount: map['amount']);
}

List<Kerning> _parseKernings(List list) {
  if (list == null) return <Kerning>[];
  return list.cast<Map>().map(_parseKerning).toList();
}

Char _parseChar(Map map) {
  if (map == null) throw Exception();
  return Char(
      id: map['id'],
      x: map['x'],
      y: map['y'],
      width: map['width'],
      height: map['height'],
      xOffset: map['xoffset'],
      yOffset: map['yoffset'],
      page: map['page'],
      xAdvance: map['xadvance'],
      chnl: map['chnl']);
}

Map<int, Char> _parseChars(List list) {
  if (list == null) return <int, Char>{};
  return Map.fromEntries(
      list.cast<Map>().map(_parseChar).map((e) => MapEntry(e.id, e)));
}
