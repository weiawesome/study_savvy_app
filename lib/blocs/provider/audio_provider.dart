import 'dart:io';
import 'dart:typed_data';
import 'package:flutter/material.dart';

class FileProvider extends ChangeNotifier {
  bool status = true;
  String? _path;
  Uint8List? _data;
  File? _file;

  get data => _data;
  get path => _path;
  get file => _file;

  Future<void> set(File file) async {
    _data = await file.readAsBytes();
    _path = file.path;
    _file = file;
    notifyListeners();
  }

  void clear() {
    _data = null;
    _path = null;
    _file = null;
    notifyListeners();
  }

  bool isNull() {
    return _file == null;
  }

  void setStatus(bool status) {
    this.status = status;
  }

  Future<void> closeStatusFuture() async {
    await Future.delayed(const Duration(seconds: 5));
    status = true;
  }
}
