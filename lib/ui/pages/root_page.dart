import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:strength_project/ui/pages/login.dart';
import 'package:strength_project/core/services/auth.dart';
import 'package:strength_project/ui/pages/home.dart';

// class RootPage extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return ChangeNotifierProvider(
//       builder: (_) => AuthService.instance(),
//       child: Consumer(
//         builder: (context, AuthService auth, _) {
//           switch (auth.status) {
//             case Status.Uninitialized:
//               return LoginPage();
//             case Status.Unauthenticated:
//               return LoginPage();
//             case Status.Authenticating:
//               return buildWaitingScreen();
//             case Status.Authenticated:
//               return Profile();
//           }
//         },
//       ),
//     );
//   }
// }

class RootPage extends StatefulWidget {
  @override
  _RootPageState createState() => _RootPageState();
}

class _RootPageState extends State<RootPage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      builder: (_) => AuthService.instance(),
      child: Consumer<AuthService>(
        builder: (context, AuthService auth, _) {
          switch (auth.status) {
            case Status.Uninitialized:
              return LoginPage();
            case Status.Unauthenticated:
              return LoginPage();
            case Status.Authenticating:
              return buildWaitingScreen();
            case Status.Authenticated:
              return Home();
            default:
              return LoginPage();
          }
        },
        child: Home(),
      ),
    );
  }
}

Widget buildWaitingScreen() {
  return Scaffold(
    body: Container(
      alignment: Alignment.center,
      child: CircularProgressIndicator(),
    ),
  );
}
