import 'package:flutter/material.dart';
import 'package:passwd_manager_client/classes/user.dart';
import 'package:passwd_manager_client/login/pages/add_existing_user_page.dart';
import 'package:passwd_manager_client/login/pages/add_new_user_page.dart';
import 'package:passwd_manager_client/login/pages/loading_login_page.dart';
import 'package:passwd_manager_client/login/pages/login_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    List<User> userList = [];
    for (var i = 0; i < 5; i++) {
      userList.add(User(name: "User ${i+1}"));
    }
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        
        useMaterial3: true, colorScheme: ColorScheme.fromSeed(seedColor: const Color.fromARGB(255, 34, 9, 44))
        .copyWith(
          background: const Color.fromARGB(255, 34, 9, 44), 
          primary: const Color.fromARGB(255, 135, 35, 65), 
          secondary: const Color.fromARGB(255, 190, 49, 68),
          tertiary: const Color.fromARGB(255, 240, 89, 65),
        ),
        textTheme: TextTheme(
          labelLarge: TextStyle(
            color: Colors.red[50],
            fontWeight: FontWeight.bold,
            fontSize: 30,
          ),
          labelMedium: TextStyle(
            color: Colors.red[50],
            fontWeight: FontWeight.bold,
            fontSize: 20,
          ),
          bodyMedium: TextStyle(
            color: Colors.red[50],
            fontSize: 20,
          ),
        )
      ),
      routes: <String, WidgetBuilder>{
        '/login': (BuildContext context) => LoginPage(userList: userList),
        '/add_existing' :(BuildContext context) => const AddExistingUserPage(),
        '/add_new' :(BuildContext context) => const AddNewUserPage(),
        '/loading_login' :(BuildContext context) => const LoadingLoginPage(),
      },
      initialRoute: '/login',
    );
  }
}