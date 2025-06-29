// import 'package:portfolio_flutter/injection_container.dart';
import 'package:flutter/material.dart';
import 'package:portfolio_flutter/values/values.dart';
import 'package:layout/layout.dart';

import 'app_theme.dart';
import 'configure_web.dart';
import 'sections/pages/home_page.dart';
import 'sections/routes/routes.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // configureDependencies();
  configureApp();
  runApp(MyPortfolio());
}

class MyPortfolio extends StatelessWidget {
  const MyPortfolio({super.key});

  @override
  Widget build(BuildContext context) {
    return Layout(
      child: MaterialApp(
        title: StringConst.APP_TITLE,
        theme: AppTheme.lightThemeData,
        debugShowCheckedModeBanner: false,
        initialRoute: HomePage.homePageRoute,
        onGenerateRoute: RouteConfiguration.onGenerateRoute,
      ),
    );
  }
}
