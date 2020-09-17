import 'package:flutter/material.dart';
import 'package:mymoviesapp/src/app.dart';
import 'package:flutter/services.dart';
import 'package:mymoviesapp/src/di/components/app_component.dart';
import 'package:mymoviesapp/src/di/modules/local_module.dart';
import 'package:mymoviesapp/src/di/modules/netwok_module.dart';
import 'package:mymoviesapp/src/di/modules/preference_module.dart';
import 'package:mymoviesapp/src/di/modules/preference_module.dart';

// global instance for app component
AppComponent appComponent;

void main() async {

  WidgetsFlutterBinding.ensureInitialized();
  await SystemChrome.setPreferredOrientations(<DeviceOrientation>[
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown
  ]).then((_) async {
    appComponent = await AppComponent.create(
      NetworkModule(),
      LocalModule(),
      PreferenceModule(),
    );
    runApp(appComponent.app);
  });

//  await SystemChrome.setPreferredOrientations(<DeviceOrientation>[DeviceOrientation.portraitUp, DeviceOrientation.portraitDown,
//   DeviceOrientation.landscapeLeft,DeviceOrientation.landscapeRight])
//      .then((_) => runApp(App()));
}
