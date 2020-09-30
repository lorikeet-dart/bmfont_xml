import 'dart:io';

import 'package:bmfont_xml/bmfont_xml.dart';
import 'dart:convert';

void main() {
  final file = File('./data/font/roboto/Roboto-Regular.fnt').readAsStringSync();
  final bmfont = parseJson(jsonDecode(file));
  print(bmfont);

  final text = "Hello world!".runes.toList();
  print(text);

  final l = layout(200, 100, text, bmfont);
  print(l);
}
