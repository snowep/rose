import 'package:flutter/src/widgets/framework.dart';
import 'package:rose_project/front_page/login_page.dart';
import 'package:rose_project/front_page/register_page.dart';

class PageToggle extends StatefulWidget {
  const PageToggle({Key? key}) : super(key: key);

  @override
  State<PageToggle> createState() => _PageToggleState();
}

class _PageToggleState extends State<PageToggle> {
  bool showLoginPage = true;

  void toggleScreen() {
    setState(() {
      showLoginPage = !showLoginPage;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (showLoginPage) {
      return LoginPage(
        showRegisterPage: toggleScreen,
      );
    } else {
      return RegisterPage(
        showLoginPage: toggleScreen,
      );
    }
  }
}
