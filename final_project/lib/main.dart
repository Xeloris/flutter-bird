import 'package:final_project/undertale.dart';
import 'package:flame/game.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

void main() {
  Undertale game = Undertale();
  runApp(GameWidget(game: kDebugMode ? Undertale() : game));
}
