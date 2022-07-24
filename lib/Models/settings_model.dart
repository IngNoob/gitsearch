import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:gitsearch/Common/utils.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SettingsModel extends ChangeNotifier{

  // Additional shared preferences settings could 
  // be added here at any time

 SettingsModel({
    required this.exceptionCatcher
  });

  // This is a callback to a function that is gonna deal with the 
  // visual feedback to the user. We can leave it as an empty funcion
  // so that there's no feedback to the user or change it for another one to
  // choose different ways of how to provide said feedback
  final OnExceptionCatch exceptionCatcher;

  SharedPreferences? _prefs; 

  ThemeMode _theme = ThemeMode.light;
  ThemeMode get theme => _theme;

  bool _isBusy = false;
  bool get isBusy => _isBusy;

  Future<void> loadSettings()async {

    _prefs ??= await SharedPreferences.getInstance();

    // Looks for data, if there's none uses the system and saves the setting
    bool? darkMode = _prefs?.getBool('darkMode');
    if (darkMode == null){
      _theme =  ThemeMode.system == ThemeMode.dark ? ThemeMode.dark : ThemeMode.light;
      _prefs?.setBool('darkMode', _theme == ThemeMode.dark);
    }else{
      _theme = darkMode ? ThemeMode.dark : ThemeMode.light;
    }
  }

  Future<void> toogleThemeMode () async {

    _isBusy = true;
    notifyListeners();

    try{
      _theme = _theme == ThemeMode.light ? ThemeMode.dark : ThemeMode.light;
      _prefs?.setBool('darkMode', _theme == ThemeMode.dark);
    }catch(e){
      exceptionCatcher('errorSettings'.tr());
    }

    _isBusy = false;
    notifyListeners();

  }

  Future<void> resetSettings() async {

    _isBusy = true;
    notifyListeners();

    await _prefs?.clear();
    _theme = ThemeMode.system;

    _isBusy = false;
    notifyListeners(); 
  }

}