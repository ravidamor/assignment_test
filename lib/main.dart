import 'package:fluitter_machine_test/views/splash_scren.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'controllers/data_controller.dart';
import 'controllers/login_controller.dart';
import 'views/home.dart';
import 'views/login_view.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final String? token;

  MyApp({super.key, this.token});

  @override
  Widget build(BuildContext context) {
    final DataController dataController = DataController();

    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => LoginController()),
        ChangeNotifierProvider(create: (_) => ViewModel(dataController)),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        initialRoute: '/',
        routes: {
          '/': (context) => const SplashScreen(),
          '/login': (context) => const LoginView(),
          '/home': (context) => const HomeScreenUserList(),
        },
      ),
    );
  }
}
