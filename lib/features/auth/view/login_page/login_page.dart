import 'package:cookants/core/constants/color.dart';
import 'package:cookants/features/auth/view/login_page/widgets/login_form.dart';
import 'package:cookants/features/auth/view/login_page/widgets/login_logo.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints) {
          if (constraints.maxWidth > 750) {
            return desktopView();
          } else {
            return mobileView(constraints.maxWidth);
          }
        },
      ),
    );
  }

  Widget desktopView() {
    return const Center(
      child: Row(
        children: [LoginLogo(), LoginForm()],
      ),
    );
  }

  Widget mobileView(double width) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: SingleChildScrollView(
        child: SizedBox(
          width: width,
          child: const Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [LoginLogo(), LoginForm()],
          ),
        ),
      ),
    );
  }
}
