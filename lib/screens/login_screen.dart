import 'package:flutter/material.dart';
import 'package:keep_it_safe/components/rounded_button.dart';
import 'package:keep_it_safe/screens/main_screen.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:keep_it_safe/constants.dart' as Constants;
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:keep_it_safe/cores/password_brainer.dart';

class LoginScreen extends StatefulWidget {
  static const id = 'login_screen';

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController _passwordController;
  bool showSpinner = false;
  String password;

  @override
  void initState() {
    super.initState();
    _passwordController = TextEditingController();
  }

  @override
  void dispose() {
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: ModalProgressHUD(
          inAsyncCall: showSpinner,
          child: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 24.0),
              child: Form(
                key: _formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Hero(
                      tag: 'logo',
                      child: Container(
                        height: 200.0,
                        child: Image.asset('images/lock.png'),
                      ),
                    ),
                    SizedBox(
                      height: 48.0,
                    ),
                    TextFormField(
                      decoration: Constants.kTextFieldDecoration.copyWith(
                        hintText: 'Enter your master password',
                      ),
                      textAlign: TextAlign.center,
                      obscureText: true,
                      controller: _passwordController,
                      onChanged: (value) {
                        password = value;
                      },
                      validator: (value) {
                        if (value.isEmpty) {
                          return 'Master password cannot be empty';
                        }

                        return null;
                      },
                    ),
                    SizedBox(
                      height: 24.0,
                    ),
                    RoundedButton(
                      color: Colors.lightBlueAccent,
                      onPressed: () async {
                        if (_formKey.currentState.validate()) {
                          setState(() {
                            showSpinner = true;
                          });

                          try {
                            final SharedPreferences prefs =
                                Provider.of<SharedPreferences>(context,
                                    listen: false);

                            final savedHash = prefs.getString('kis_hash') ?? '';
                            final hashedPass =
                                PasswordBrainer.generateHashedPassword(
                                    password);

                            if (savedHash == hashedPass) {
                              await Navigator.pushNamed(context, MainScreen.id);
                            }
                          } catch (err) {
                            showDialog(
                                context: context,
                                useSafeArea: true,
                                barrierDismissible: false,
                                builder: (context) {
                                  return AlertDialog(
                                    title: Text('Warning'),
                                    content: Text(
                                        'Invalid Master Password. Try again'),
                                    actions: [
                                      FlatButton(
                                        child: Text('Ok'),
                                        onPressed: () {
                                          Navigator.pop(context);
                                        },
                                      ),
                                    ],
                                  );
                                });
                          } finally {
                            setState(() {
                              showSpinner = false;
                            });
                          }
                        }

                        _passwordController.clear();
                      },
                      title: 'Log In',
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
