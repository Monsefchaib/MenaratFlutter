import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';

import '../constants.dart';

class PDFApi{
  static Future<File> loadNetwork(String url) async {
    final response = await http.get(Uri.parse('http://$urlApi:3000/media/$url'));
    final bytes = response.bodyBytes;

    return _storeFile(url, bytes);
  }
  static Future<File> loadCommande(String url) async {
    final response = await http.get(Uri.parse('http://$urlApi:3000/media/$url'));
    final bytes = response.bodyBytes;
    return _storeFile(url, bytes);
  }
  static Future<File> loadBonCarburant(String url) async {
    final response = await http.get(Uri.parse('http://$urlApi:3000/media/$url'));
    final bytes = response.bodyBytes;

    return _storeFile(url, bytes);
  }


  static Future<File> _storeFile(String url, List<int> bytes) async {
    final filename = basename(url);
    final dir = await getApplicationDocumentsDirectory();

    final file = File('${dir.path}/$filename');
    await file.writeAsBytes(bytes, flush: true);
    return file;
  }


}