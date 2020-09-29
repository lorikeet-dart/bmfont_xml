import 'dart:io';

import 'package:bmfont_xml/bmfont_xml.dart';
import 'package:bmfont_xml/src/parse/parse_json.dart';
import 'package:bmfont_xml/src/parse/parse_xml.dart';
import 'dart:convert';

void main() {
  final file = File('./data/font/roboto/Roboto-Regular.fnt').readAsStringSync();
  final bmfont = parseJson(jsonDecode(file));
  print(bmfont);
}
