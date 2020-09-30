import 'dart:convert';
import 'dart:html';
import 'package:bmfont_xml/bmfont_xml.dart';
import 'package:http/browser_client.dart';
import 'package:http/http.dart';

Future<void> main() async {
  querySelector('#output').text = 'Your Dart app is running.';

  final file = await downloadAsString('/static/font/roboto/Roboto-Regular.fnt');
  final bmfont = parseJson(jsonDecode(file));
  print(bmfont);

  final text = "Hello world!".runes.toList();
  print(text);

  final l = layout(200, 100, text, bmfont);
  print(l);
}

Future<String> downloadAsString(String url) async {
  final resp = await get(url);

  if(resp.statusCode != 200) {
    throw Exception('invalid response status code: ${resp.statusCode}');
  }

  return resp.body;
}
