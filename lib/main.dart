import 'package:flutter/material.dart';
import 'package:portfolio_flutter/values/values.dart';
import 'package:layout/layout.dart';

import 'app_theme.dart';
import 'configure_web.dart';
import 'sections/pages/home_page.dart';
import 'sections/routes/routes.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  configureApp();
  runApp(const MyPortfolio());
}

class MyPortfolio extends StatelessWidget {
  const MyPortfolio({super.key});

  @override
  Widget build(BuildContext context) {
    MaterialTheme theme = MaterialTheme(
      Theme.of(context).textTheme.apply(fontFamily: "Montserrat"),
    );

    return Layout(
      child: MaterialApp(
        title: StringConst.APP_TITLE,
        theme: theme.dark(),
        debugShowCheckedModeBanner: false,
        initialRoute: HomePage.homePageRoute,
        onGenerateRoute: RouteConfiguration.onGenerateRoute,
      ),
    );
  }
}
