import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:get/get.dart';

class ThemeService {
  final _box = GetStorage();
  final String _key = 'isDarkMode';

  bool _isDarkModel() {
    return _box.read(_key) ?? false;
  }

  void switchThemeModel(bool isDarkModel) {
    _box.write(_key, isDarkModel);
  }

  void switchTheme() {
    bool isDarkModel = _isDarkModel();
    switchThemeModel(!isDarkModel);
    Get.changeThemeMode(theme);
  }

  ThemeMode get theme => _isDarkModel() ? ThemeMode.dark : ThemeMode.light;
}
