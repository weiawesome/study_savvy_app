import 'package:device_preview/device_preview.dart';
import 'package:flutter/material.dart';
import 'package:study_savvy_app/models/model_noteTaker.dart';

abstract class audioEvent {}

class audioChanged extends audioEvent {
  final noteTaker_audio note;
  audioChanged(this.note);
}

class audioEventRefresh extends audioEvent {}

class audioEventUnknown extends audioEvent{}
