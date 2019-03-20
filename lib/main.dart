import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:poke_info/src/app.dart';

void main() =>
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp])
        .then((_) {
      runApp(App());
    });
