import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:netpospricechecker/app_constants/hive_boxes.dart';
import 'package:netpospricechecker/core/routes_manager.dart';
import 'package:netpospricechecker/view/navigation_check.dart';
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
  runApp(RestartWidget(child: const MyApp()));
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
      //  navigatorKey: navigatorKey,
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
// final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();
// void restartApp() async {
//  navigatorKey.currentState?.pushAndRemoveUntil(
//     MaterialPageRoute(builder: (context) => const MyApp()),
//     (route) => false,
//   );
// }

class RestartWidget extends StatefulWidget {
  final Widget child;

  const RestartWidget({Key? key, required this.child}) : super(key: key);

  static void restartApp(BuildContext context) {
    final state = context.findAncestorStateOfType<_RestartWidgetState>();
    state?.restartApp();
  }

  @override
  State<RestartWidget> createState() => _RestartWidgetState();
}

class _RestartWidgetState extends State<RestartWidget> {
  Key key = UniqueKey();

  void restartApp() {
    setState(() {
      key = UniqueKey(); // Completely rebuilds the subtree
    });
  }

  @override
  Widget build(BuildContext context) {
    return KeyedSubtree(key: key, child: widget.child);
  }
}