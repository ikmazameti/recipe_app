import 'package:flutter/material.dart';
import 'package:status_alert/status_alert.dart';

import '../services/auth_service.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final GlobalKey<FormState> _loginFormKey = GlobalKey();
  String? username, password;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          "Login",
        ),
      ),
      body: SafeArea(
        child: _buildUI(),
      ),
    );
  }

  Widget _buildUI() => SizedBox(
        width: MediaQuery.sizeOf(context).width,
        child: Column(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            _title(),
            _loginForm(),
            _loginButton(),
          ],
        ),
      );

  Widget _title() => const Text(
        "Recipe Book",
        style: TextStyle(
          fontSize: 35,
          fontWeight: FontWeight.w300,
        ),
      );

  Widget _loginForm() => SizedBox(
        width: MediaQuery.sizeOf(context).width * 0.9,
        height: MediaQuery.sizeOf(context).width * 0.4,
        child: Form(
          key: _loginFormKey,
          child: Column(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                TextFormField(
                  onSaved: (value) {
                    setState(() {
                      username = value;
                    });
                  },
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Enter username!";
                    }
                  },
                  decoration: const InputDecoration(
                    hintText: "Username",
                  ),
                ),
                TextFormField(
                  onSaved: (value) {
                    setState(() {
                      password = value;
                    });
                  },
                  obscureText: true,
                  validator: (value) {
                    if (value == null || value.length < 5) {
                      return "Enter valid password!";
                    }
                  },
                  decoration: const InputDecoration(
                    hintText: "Password",
                  ),
                )
              ]),
        ),
      );

  Widget _loginButton() => SizedBox(
        width: MediaQuery.sizeOf(context).width * 0.6,
        child: ElevatedButton(
          onPressed: () async {
            if (_loginFormKey.currentState?.validate() ?? false) {
              _loginFormKey.currentState?.save();
              bool result = await AuthService().login(username!, password!);

              if (result) {
                Navigator.pushReplacementNamed(context, '/home');
              } else {
                StatusAlert.show(context,
                    duration: const Duration(seconds: 2),
                    title: "Login failed",
                    subtitle: 'Please try again!',
                    configuration: const IconConfiguration(icon: Icons.error),
                    maxWidth: 260);
              }
            }
          },
          child: const Text("Login"),
        ),
      );
}
