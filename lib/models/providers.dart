import 'package:flutter/material.dart';
import 'package:gastro_lens/models/shared_pref.dart';
import 'upload.dart';

class NavProvider with ChangeNotifier {
  int _selectedIndex = 0;

  int get selectedIndex => _selectedIndex;

  set selectedIndex(int index) {
    _selectedIndex = index;
    notifyListeners();
  }
}

class ThemeProvider with ChangeNotifier {
  late bool _isLightMode = true;
  late ThemeMode _themeMode = ThemeMode.light;

  ThemeMode get themeMode => _themeMode;
  void setThemeMode(ThemeMode value) {
    _themeMode = value;
    notifyListeners();
  }

  bool get isLightMode => _isLightMode;
  void toggleMode() {
    _isLightMode = !_isLightMode;
    _themeMode = (_themeMode == ThemeMode.dark) ? ThemeMode.light : ThemeMode.dark;
    notifyListeners();
  }
}

class UploadsProvider with ChangeNotifier {
  List<Upload> _uploads = [];
  bool _justAdded = false;

  List<Upload> get uploads => _uploads;
  bool get justAdded => _justAdded;

  Future<void> loadUploads() async {
    _uploads = await readSharedPrefs();
    notifyListeners();
  }

  Future<void> clearUploads() async {
    clearSharedPrefs();
    _uploads = [];
    notifyListeners();
  }

  Future<void> updateUploads(List<Upload> newUploads) async {
    _uploads = newUploads;
    await writeSharedPrefs(_uploads);
    notifyListeners();
  }

  Future<void> addUpload(Upload newUpload) async {
    _uploads.add(newUpload);
    await writeSharedPrefs(_uploads);
    _justAdded = true;
    notifyListeners();
  }

  Future<void> simulateUploads() async {
    List<Upload> temp = simulatedUploads;
    temp.shuffle();
    for (Upload u in temp) {
      _uploads.add(u);
    }
    await writeSharedPrefs(_uploads);
    _justAdded = true;
    notifyListeners();
  }

  void clearJustAdded() {
    _justAdded = false;
  }
}


