import 'package:contacts_proj/app/app.bottomsheets.dart';
import 'package:contacts_proj/app/app.dialogs.dart';
import 'package:contacts_proj/app/app.locator.dart';
import 'package:contacts_proj/app/app.router.dart';
import 'package:contacts_proj/core/setup_snackbar_ui.dart';
import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:stacked_services/stacked_services.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await setupLocator();
  setupDialogUi();
  setupBottomSheetUi();
  setupSnackbarUi();
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ResponsiveSizer(builder: (context, orientation, screenType) {
     return MaterialApp(
        initialRoute: Routes.homeView,
        onGenerateRoute: StackedRouter().onGenerateRoute,
        navigatorKey: StackedService.navigatorKey,
        debugShowCheckedModeBanner: false,
        navigatorObservers: [
          StackedService.routeObserver,
        ],
      );
    });
  }
}
