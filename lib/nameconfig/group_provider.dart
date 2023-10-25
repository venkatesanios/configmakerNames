import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class NameListProvider with ChangeNotifier {
  List<String> _names = [];

  List<String> get names => _names;

  void addName(String name) {
    _names.add(name);
    notifyListeners();
  }

 

  void removeName(String name) {
    _names.remove(name);
    notifyListeners();
  }

  void removeAll() {
     _names = [];
    notifyListeners();
  }
   

  void updateName(String oldName, String newName) {
    final index = _names.indexOf(oldName);
    _names[index] = newName;
    notifyListeners();
  }
}
