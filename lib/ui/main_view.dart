import 'package:flutter/material.dart';
import 'package:login_page_1/ui/screens/login_screen.dart';
import 'package:login_page_1/ui/screens/sing_up_screen.dart';
import 'package:login_page_1/ui/screens/specificProduct.dart';
import 'package:login_page_1/ui/screens/verify_screen.dart';
import 'package:login_page_1/ui/screens/home.dart';

class MainView extends StatefulWidget {
  const MainView({super.key});

  @override
  State<MainView> createState() => _MainViewState();
}

class _MainViewState extends State<MainView> {
  PageController controller = PageController(initialPage: 0);
  String email = "";
  String id = "";
  String password = "";
  String idnum = "";
  String phnum = "";
  String name = "";
  void setEmail(String newEmail) {
    setState(() => email = newEmail);
  }

  void setId(String newID) {
    setState(() => id = newID);
  }

  void setPassword(String newPwd) {
    setState(() => password = newPwd);
  }

  void setIdNum(String newIdNum) {
    setState(() => idnum = newIdNum);
  }

  void setPhNum(String newPhNum) {
    setState(() => phnum = newPhNum);
  }

  void setName(String newName) {
    setState(() => name = newName);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView.builder(
        physics: const NeverScrollableScrollPhysics(),
        itemCount: 5,
        controller: controller,
        itemBuilder: (context, index) {
          if (index == 0) {
            return HomeScreen(
              controller: controller,
            );
          } else if (index == 1) {
            return SingUpScreen(
                controller: controller,
                setID: setId,
                setPassword: setPassword,
                setEmail: setEmail,
                setIdNum: setIdNum,
                setName: setName,
                setPhNum: setPhNum);
          } else if (index == 3) {
            return HomeScreen(
              controller: controller,
            );
          } else if (index == 4) {
            return VerifyScreen(
                controller: controller,
                id: id,
                password: password,
                email: email,
                idnum: idnum,
                name: name,
                phnum: phnum);
          }
        },
      ),
    );
  }
}
