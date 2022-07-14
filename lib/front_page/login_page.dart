import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  login() {}

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(35.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Hey!",
                      style: GoogleFonts.roboto(
                        fontSize:
                            Theme.of(context).textTheme.displaySmall?.fontSize,
                        fontWeight:
                            Theme.of(context).textTheme.bodyLarge?.fontWeight,
                      ),
                    ),
                    Text(
                      "Let's Login.",
                      style: GoogleFonts.poppins(
                        fontSize:
                            Theme.of(context).textTheme.displaySmall?.fontSize,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 15.0, bottom: 50.0),
                      child: Row(
                        children: [
                          const Text(
                            "If you are new /",
                            style: TextStyle(
                              color: Colors.grey,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 8.0),
                            child: TextButton(
                                onPressed: () {}, //TODO: show register page
                                child: const Text('Create New')),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                TextField(
                  controller: _emailController,
                  decoration: const InputDecoration(
                    labelText: 'Email',
                  ),
                ),
                TextField(
                  controller: _passwordController,
                  decoration: const InputDecoration(
                    labelText: 'Password',
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 15.0, bottom: 50.0),
                  child: Row(
                    children: [
                      const Text(
                        "If you forgot your password /",
                        style: TextStyle(
                          color: Colors.grey,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 8.0),
                        child: TextButton(
                            onPressed: () {}, //TODO: show forgot password page
                            child: const Text('Reset')),
                      ),
                    ],
                  ),
                ),
                ElevatedButton(
                  onPressed: login,
                  style: ElevatedButton.styleFrom(
                    minimumSize: const Size.fromHeight(50),
                    maximumSize: const Size.fromHeight(250),
                    onPrimary: Theme.of(context).colorScheme.onPrimary,
                    primary: Theme.of(context).colorScheme.primary,
                  ).copyWith(
                    elevation: ButtonStyleButton.allOrNull(0.0),
                  ),
                  child: const Text('Login'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
