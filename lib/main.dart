import 'dart:developer';

import 'package:flirt/configs/themes.dart';
import 'package:flirt/infrastructures/local_auth.dart';
import 'package:flirt/module/home/interfaces/screens/home_screen.dart';
import 'package:flirt/routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() => runApp(const App());

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flirt',
      home: _HomePageState(),
      theme: defaultTheme,
      supportedLocales: const <Locale>[
        Locale('en'),
      ],
      routes: routes,
      debugShowCheckedModeBanner: false,
    );
  }
}

class _HomePageState extends StatefulWidget {
  @override
  State<_HomePageState> createState() => _HomePageStateState();
}

class _HomePageStateState extends State<_HomePageState> {
  bool _isAuthenticated = false;

  Future<void> _authenticateUser() async {
    final String res = await LocalAuthApi.authenticate(
      messageReason: 'Authenticate to access app flirt',
    );
    if (res == 'authenticated') {
      // navigate to home page since it is authenticated
      setState(() => _isAuthenticated = true);
    } else if (res == 'NotEnrolled') {
      // informs the user that they need to enroll biometrics such as finger print or face id
      log(res);
    } else if (res.contains('Device is not supported')) {
      // informs the user that they need to setup password either pin,etc.
      log(res);
    } else {
      //if the authenticatoin is failed then app will automatically exitted
      SystemNavigator.pop();
    }
  }

  @override
  void initState() {
    super.initState();

    _authenticateUser();
  }

  @override
  Widget build(BuildContext context) {
    return _isAuthenticated ? const HomeScreen() : const Sample();
  }
}

//if not yet authenticated display this widget
class Sample extends StatelessWidget {
  const Sample({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text('Login sa'),
    );
  }
}
