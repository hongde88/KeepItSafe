import 'package:flutter/material.dart';
import 'package:keep_it_safe/models/main_screen_state.dart';
import 'package:keep_it_safe/screens/create_pass.dart';
import 'package:keep_it_safe/screens/login_screen.dart';
import 'package:keep_it_safe/screens/main_screen.dart';
import 'package:keep_it_safe/screens/welcome_screen.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SharedPreferences prefs = await SharedPreferences.getInstance();
  runApp(KeepItSafe(
    prefs: prefs,
  ));
}

class KeepItSafe extends StatelessWidget {
  final prefs;

  KeepItSafe({this.prefs});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<MainScreenState>(
          create: (context) => MainScreenState(),
        ),
        Provider<SharedPreferences>(
          create: (context) => prefs,
        ),
      ],
      child: MaterialApp(
        initialRoute: WelcomeScreen.id,
        routes: {
          WelcomeScreen.id: (context) => WelcomeScreen(),
          LoginScreen.id: (context) => LoginScreen(),
          CreateScreen.id: (context) => CreateScreen(),
          MainScreen.id: (context) => MainScreen(),
        },
      ),
    );
  }
}
