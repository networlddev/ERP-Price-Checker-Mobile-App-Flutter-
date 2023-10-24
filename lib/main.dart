import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:netpospricechecker/app_constants/hive_boxes.dart';
import 'package:netpospricechecker/app_constants/strings.dart';
import 'package:netpospricechecker/core/routes_manager.dart';
import 'package:netpospricechecker/view/navigation_check.dart';
import 'package:netpospricechecker/view/price_checker_screen.dart';
import 'package:netpospricechecker/view_models/price_checker_view_model.dart';
import 'package:netpospricechecker/view_models/user_validation_view_model.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  await Hive.openBox(HiveBoxes.authenticationBox);
  await Hive.openBox(HiveBoxes.urlBox);
  await Hive.openBox<String>(HiveBoxes.expiryDateBox);
    // barcodeFocusNode.addListener(() {
    //   if (barcodeFocusNode.hasFocus) {
    //     controllerBarcode.clear();
    //   }
    // });
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => UserValidationViewModel(),
        ),
        ChangeNotifierProvider(
          create: (_) => PriceCheckerViewModel(),
        )
      ],
      child: MaterialApp(
        title: 'Price Checker',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        debugShowCheckedModeBanner: false,
        // initialRoute: Routes.userValidationScreen,
        home: const NavigationCheck(),
        onGenerateRoute: RouteGenerator.getRoute,
      ),
    );
  }
}
