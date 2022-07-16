import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:rose_project/front_page/login_page.dart';
import 'package:rose_project/service/auth/toggle.dart';

class LandingPage extends StatefulWidget {
  final User user;
  const LandingPage({Key? key, required this.user}) : super(key: key);

  @override
  State<LandingPage> createState() => _LandingPageState();
}

class _LandingPageState extends State<LandingPage> {
  late User _currentUser;

  @override
  void initState() {
    super.initState();
    _currentUser = widget.user;
  }

  @override
  Widget build(BuildContext context) {
    String? str = _currentUser.displayName;
    List<String> strarray = str!.split(' ');
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Welcome, ${strarray[0]}'),
            ElevatedButton(
              onPressed: () async {
                await FirebaseAuth.instance.signOut();
                Navigator.of(context).pushReplacement(
                  MaterialPageRoute(
                    builder: (context) => PageToggle(),
                  ),
                );
              },
              child: Text('Logout'),
            ),
          ],
        ),
      ),
      drawer: Drawer(),
    );
  }
}
