import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:rose_project/user_page/landing_page.dart';

class LoginPage extends StatefulWidget {
  final VoidCallback showRegisterPage;
  const LoginPage({Key? key, required this.showRegisterPage}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  Future<FirebaseApp> _initializeFirebase() async {
    FirebaseApp firebaseApp = await Firebase.initializeApp();
    User? user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (context) => LandingPage(user: user),
        ),
      );
    }

    return firebaseApp;
  }

  static Future<User?> login({
    required String email,
    required String password,
    required BuildContext context,
  }) async {
    FirebaseAuth auth = FirebaseAuth.instance; // get instance of firebase auth
    User? user; // user will be null if login fails

    try {
      UserCredential userCredential = await auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      ); // sign in with email and password
      showDialog(
          context: context,
          builder: (context) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }); // show loading dialog
      user = userCredential.user; // get user from user credential
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
                'Whoops! No user with ${email} found in our database. Try another user or maybe create one.'),
            behavior: SnackBarBehavior.floating,
          ),
        );
      } else if (e.code == 'wrong-password') {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text(
                "It's just me or you entered wrong password? Let's try again."),
            behavior: SnackBarBehavior.floating,
          ),
        );
      }
    }
    return user;
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
          future: _initializeFirebase(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              return Center(
                child: SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.all(35.0),
                    child: Form(
                      key: _formKey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Hey!",
                                style: GoogleFonts.roboto(
                                  fontSize: Theme.of(context)
                                      .textTheme
                                      .displaySmall
                                      ?.fontSize,
                                  fontWeight: Theme.of(context)
                                      .textTheme
                                      .bodyLarge
                                      ?.fontWeight,
                                ),
                              ),
                              Text(
                                "Let's Login.",
                                style: GoogleFonts.poppins(
                                  fontSize: Theme.of(context)
                                      .textTheme
                                      .displaySmall
                                      ?.fontSize,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(
                                    top: 15.0, bottom: 50.0),
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
                                          onPressed: widget.showRegisterPage,
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
                            obscureText: true,
                            controller: _passwordController,
                            decoration: const InputDecoration(
                              labelText: 'Password',
                            ),
                          ),
                          Padding(
                            padding:
                                const EdgeInsets.only(top: 15.0, bottom: 50.0),
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
                                      onPressed: () {},
                                      child: const Text('Reset')),
                                ),
                              ],
                            ),
                          ),
                          ElevatedButton(
                            onPressed: () async {
                              if (_formKey.currentState!.validate()) {
                                User? user = await login(
                                  email: _emailController.text,
                                  password: _passwordController.text,
                                  context: context,
                                );
                                if (user != null) {
                                  Navigator.of(context).pushReplacement(
                                    MaterialPageRoute(
                                      builder: (context) => LandingPage(
                                        user: user,
                                      ),
                                    ),
                                  );
                                }
                              }
                            },
                            style: ElevatedButton.styleFrom(
                              minimumSize: const Size.fromHeight(50),
                              maximumSize: const Size.fromHeight(250),
                              onPrimary:
                                  Theme.of(context).colorScheme.onPrimary,
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
            return const Center(
              child: CircularProgressIndicator(),
            );
          }),
    );
  }
}
