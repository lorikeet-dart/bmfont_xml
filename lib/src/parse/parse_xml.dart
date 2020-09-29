import 'package:bmfont_xml/src/xmlutils.dart';
import 'package:xml/xml.dart';
import 'package:bmfont_xml/bmfont_xml.dart';

BitmapFont parseXml(String input) {
  final document = XmlDocument.parse(input);

  final root = document.children
      .whereType<XmlElement>()
      .cast<XmlElement>()
      .firstWhere((XmlElement n) => n.name.local == 'font', orElse: () => null);
  if (root == null) {
    throw Exception('<font> element not found!');
  }
  print(root);

  final info = _parseInfo(root.children
      .whereType<XmlElement>()
      .firstWhere((e) => e.name.local == 'info', orElse: () => null));
  final common = _parseCommon(root.children
      .whereType<XmlElement>()
      .firstWhere((e) => e.name.local == 'common', orElse: () => null));
  final pages = _parsePages(root.children
      .whereType<XmlElement>()
      .firstWhere((e) => e.name.local == 'pages', orElse: () => null));
  final kernings = _parseKernings(root.children
      .whereType<XmlElement>()
      .firstWhere((e) => e.name.local == 'kernings', orElse: () => null));
  final chars = _parseChars(root.children
      .whereType<XmlElement>()
      .firstWhere((e) => e.name.local == 'chars', orElse: () => null));

  return BitmapFont(
      info: info,
      common: common,
      pages: pages,
      kernings: kernings,
      chars: chars);
}

Info _parseInfo(XmlElement node) {
  return Info(
      face: getAttributeByLocalName(node, 'face').value,
      size: getIntAttributeByLocalName(node, 'size'),
      bold: getBoolAttributeByLocalName(node, 'bold'),
      italic: getBoolAttributeByLocalName(node, 'italic'),
      charset: getIntAttributeByLocalName(node, 'charset'),
      unicode: getBoolAttributeByLocalName(node, 'unicode'),
      stretchH: getIntAttributeByLocalName(node, 'stretchH'),
      smooth: getBoolAttributeByLocalName(node, 'smooth'),
      aa: getIntAttributeByLocalName(node, 'aa'),
      padding: _parsePadding(getAttributeByLocalName(node, 'padding')),
      spacing: _parseSpacing(getAttributeByLocalName(node, 'spacing')),
      outline: getIntAttributeByLocalName(node, 'outline'));
}

Padding _parsePadding(XmlAttribute node) {
  if (node == null) return null;
  final parts = node.value.split(',').map(int.parse).toList();
  if (parts.length != 4) throw Exception();

  return Padding(up: parts[0], right: parts[1], down: parts[2], left: parts[3]);
}

Spacing _parseSpacing(XmlAttribute node) {
  if (node == null) return null;
  final parts = node.value.split(',').map(int.parse).toList();
  if (parts.length != 2) throw Exception();

  return Spacing(horizontal: parts[0], vertical: parts[1]);
}

Common _parseCommon(XmlElement node) {
  if (node == null) return null;
  return Common(
      lineHeight: getIntAttributeByLocalName(node, 'lineHeight'),
      base: getIntAttributeByLocalName(node, 'base'),
      scaleW: getIntAttributeByLocalName(node, 'scaleW'),
      scaleH: getIntAttributeByLocalName(node, 'scaleH'),
      pages: getIntAttributeByLocalName(node, 'pages'),
      packed: getBoolAttributeByLocalName(node, 'packed'),
      alphaChnl: getIntAttributeByLocalName(node, 'alphaChnl'),
      redChnl: getIntAttributeByLocalName(node, 'redChnl'),
      blueChnl: getIntAttributeByLocalName(node, 'blueChnl'),
      greenChnl: getIntAttributeByLocalName(node, 'greenChnl'));
}

Page _parsePage(XmlElement node) {
  if (node == null) throw Exception('');
  return Page(
      id: getIntAttributeByLocalName(node, 'id'),
      file: getStringAttributeByLocalName(node, 'file'));
}

List<Page> _parsePages(XmlElement node) {
  if (node == null) return <Page>[];
  return node.children
      .whereType<XmlElement>()
      .where((element) => element.name.local == 'page')
      .map(_parsePage)
      .toList();
}

Kerning _parseKerning(XmlElement node) {
  if (node == null) throw Exception('');
  return Kerning(
      first: getIntAttributeByLocalName(node, 'first'),
      second: getIntAttributeByLocalName(node, 'second'),
      amount: getIntAttributeByLocalName(node, 'amount'));
}

List<Kerning> _parseKernings(XmlElement node) {
  return node.children
      .whereType<XmlElement>()
      .where((e) => e.name.local == 'kerning')
      .map(_parseKerning)
      .toList();
}

Char _parseChar(XmlElement node) {
  if (node == null) throw Exception();
  return Char(
      id: getIntAttributeByLocalName(node, 'id'),
      x: getIntAttributeByLocalName(node, 'x'),
      y: getIntAttributeByLocalName(node, 'y'),
      width: getIntAttributeByLocalName(node, 'width'),
      height: getIntAttributeByLocalName(node, 'height'),
      xOffset: getIntAttributeByLocalName(node, 'xOffset'),
      yOffset: getIntAttributeByLocalName(node, 'yOffset'),
      page: getIntAttributeByLocalName(node, 'page'),
      xAdvance: getIntAttributeByLocalName(node, 'xAdvance'),
      chnl: getIntAttributeByLocalName(node, 'chnl'));
}

Map<int, Char> _parseChars(XmlElement node) {
  if (node == null) return <int, Char>{};
  return Map.fromEntries(node.children
      .whereType<XmlElement>()
      .where((e) => e.name.local == 'char')
      .map(_parseChar)
      .map((e) => MapEntry(e.id, e)));
}
