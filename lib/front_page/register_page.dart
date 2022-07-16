import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:rose_project/service/auth/fire_auth.dart';
import 'package:rose_project/user_page/landing_page.dart';

class RegisterPage extends StatefulWidget {
  final VoidCallback showLoginPage;
  const RegisterPage({Key? key, required this.showLoginPage}) : super(key: key);

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  //Controllers for the text fields
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  final _firstNameController = TextEditingController();
  final _lastNameController = TextEditingController();
  final _registerFormKey = GlobalKey<FormState>();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    _firstNameController.dispose();
    _lastNameController.dispose();
    super.dispose();
  }

  bool _isProcessing = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(35.0),
            child: Form(
              key: _registerFormKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Hello,",
                        style: GoogleFonts.roboto(
                          fontSize: Theme.of(context)
                              .textTheme
                              .displaySmall
                              ?.fontSize,
                          fontWeight:
                              Theme.of(context).textTheme.bodyLarge?.fontWeight,
                        ),
                      ),
                      Text(
                        "Start Register.",
                        style: GoogleFonts.poppins(
                          fontSize: Theme.of(context)
                              .textTheme
                              .displaySmall
                              ?.fontSize,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 15.0, bottom: 50.0),
                        child: Row(
                          children: [
                            const Text(
                              "If you have an account already /",
                              style: TextStyle(
                                color: Colors.grey,
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(left: 8.0),
                              child: TextButton(
                                  onPressed: widget.showLoginPage,
                                  child: const Text('Login')),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  TextField(
                      controller: _firstNameController,
                      decoration: const InputDecoration(
                        labelText: 'First Name',
                      )),
                  TextField(
                      controller: _lastNameController,
                      decoration: const InputDecoration(
                        labelText: 'Last Name',
                      )),
                  TextField(
                    controller: _emailController,
                    decoration: const InputDecoration(
                      labelText: 'Email',
                    ),
                  ),
                  TextField(
                    obscureText: true,
                    controller: _passwordController,
                    decoration: const InputDecoration(
                      labelText: 'Password',
                    ),
                  ),
                  TextField(
                    obscureText: true,
                    controller: _confirmPasswordController,
                    decoration: const InputDecoration(
                      labelText: 'Confirm Password',
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 15.0, bottom: 50.0),
                    child: Row(
                      children: const [
                        Text(
                          "Make sure your password secure.",
                          maxLines: 1,
                          style: TextStyle(
                            color: Colors.grey,
                          ),
                        ),
                      ],
                    ),
                  ),
                  _isProcessing
                      ? CircularProgressIndicator()
                      : ElevatedButton(
                          onPressed: () async {
                            setState(() {
                              _isProcessing = true;
                            });

                            if (_registerFormKey.currentState!.validate()) {
                              User? user = await FireAuth.register(
                                email: _emailController.text,
                                password: _passwordController.text,
                                firstName: _firstNameController.text,
                                lastName: _lastNameController.text,
                                confirmPassword:
                                    _confirmPasswordController.text,
                                context: context,
                              );

                              setState(() {
                                _isProcessing = false;
                              });

                              if (user != null) {
                                Navigator.of(context).pushAndRemoveUntil(
                                  MaterialPageRoute(
                                    builder: (context) => LandingPage(
                                      user: user,
                                    ),
                                  ),
                                  ModalRoute.withName('/'),
                                );
                              }
                            }
                          },
                          style: ElevatedButton.styleFrom(
                            minimumSize: const Size.fromHeight(50),
                            maximumSize: const Size.fromHeight(250),
                            onPrimary: Theme.of(context).colorScheme.onPrimary,
                            primary: Theme.of(context).colorScheme.primary,
                          ).copyWith(
                            elevation: ButtonStyleButton.allOrNull(0.0),
                          ),
                          child: Text('Register'),
                        ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
