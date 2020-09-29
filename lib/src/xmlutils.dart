import 'package:xml/xml.dart';

XmlAttribute getAttributeByLocalName(XmlNode n, String name) {
  return n.attributes
      .whereType<XmlAttribute>()
      .firstWhere((n) => n.name.local == name, orElse: () => null);
}

String getStringAttributeByLocalName(XmlNode n, String name) {
  final attr = getAttributeByLocalName(n, name);
  if (attr == null) {
    return null;
  }
  return attr.value;
}

int getIntAttributeByLocalName(XmlNode n, String name) {
  final attr = getAttributeByLocalName(n, name);
  if (attr == null) {
    return null;
  }
  try {
    return int.parse(attr.value);
  } catch(e) {
    print(name);
    rethrow;
  }
}

bool getBoolAttributeByLocalName(XmlNode n, String name,
    {Set<String> trueValues = const {
      '1',
      'true',
      't',
      'TRUE',
      'True',
      'T',
      'yes',
      'YES',
      'Yes',
      'y',
      'Y'
    },
    Set<String> falseValues = const {
      '0',
      'false',
      'f',
      'FALSE',
      'False',
      'F',
      'no',
      'NO',
      'No',
      'n',
      'N'
    }}) {
  final attr = getAttributeByLocalName(n, name);
  if (attr == null) {
    return null;
  }

  final t = attr.value;

  if (trueValues.contains(t)) {
    return true;
  }
  if (falseValues.contains(t)) {
    return false;
  }

  throw Exception('Unknown boolean value ${t}');
}
