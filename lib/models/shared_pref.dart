import 'dart:convert';
import 'upload.dart';
import 'package:shared_preferences/shared_preferences.dart';

// KEY = 'global' --> ALL UPLOADS

Future<List<Upload>> readSharedPrefs() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  List<String>? uploadString = prefs.getStringList('global');
  if (uploadString == null) {
    uploadString = [];
    await prefs.setStringList('global', uploadString);
  }
  return uploadString.map((str) => Upload.fromJson(jsonDecode(str))).toList();
}

writeSharedPrefs(List<Upload> uploadsUpload) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  List<String> uploadsString = uploadsUpload.map((upload) => jsonEncode(upload.toJsonMap())).toList();
  await prefs.setStringList('global', uploadsString);
}

clearSharedPrefs() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  await prefs.setStringList('global', []);
}


