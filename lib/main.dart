import 'package:flutter/material.dart';
import 'package:realtime_innovations/data/database/hive_initalisation.dart';
import 'package:realtime_innovations/routes/create_routes.dart';
import 'package:realtime_innovations/utils/constant/appconstant.dart';
import 'package:realtime_innovations/utils/decoration/size_config.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  HiveManager hiveManager = HiveManager.getInstance();
  await hiveManager.initHive();

  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints) {
      SizeConfig().init(constraints, Orientation.portrait);
      return MaterialApp(
        debugShowCheckedModeBanner: false,
        onGenerateRoute: createRoute,
        scaffoldMessengerKey: AppConsts.scaffoldMessengerKey,
      );
    });
  }
}
