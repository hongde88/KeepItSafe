import 'package:flutter/material.dart';
import 'package:keep_it_safe/components/rounded_button.dart';
import 'package:keep_it_safe/cores/password_brainer.dart';
import 'package:keep_it_safe/screens/login_screen.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:keep_it_safe/constants.dart' as Constants;
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CreateScreen extends StatefulWidget {
  static const id = 'create_screen';

  @override
  _CreateScreenState createState() => _CreateScreenState();
}

class _CreateScreenState extends State<CreateScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _passwordController = TextEditingController();
  bool showSpinner = false;
  String password;

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

                        if (value.length < 6) {
                          return 'Master password must be at least 6 characters';
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

                          final hashedPassword =
                              PasswordBrainer.generateHashedPassword(password);

                          SharedPreferences prefs =
                              Provider.of<SharedPreferences>(context,
                                  listen: false);

                          await prefs.setString('kis_hash', hashedPassword);

                          await Navigator.pushNamed(context, LoginScreen.id);
                          _passwordController.clear();

                          setState(() {
                            showSpinner = false;
                          });
                        }
                      },
                      title: 'Create Master Password',
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
