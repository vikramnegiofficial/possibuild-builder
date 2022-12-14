import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:possibuild/firebase_options.dart';
import 'package:possibuild/models/userModel.dart';
import 'package:possibuild/screens/ProfilePage.dart';
import 'package:possibuild/screens/Catalog.dart';
import 'package:possibuild/screens/HomePage.dart';
import 'package:possibuild/screens/SigninPage.dart';
import 'package:possibuild/screens/SignupPage.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({Key? key}) : super(key: key);
  late User user;

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
          primarySwatch: Colors.blue,
          textTheme: Theme.of(context).textTheme.apply(
              bodyColor: const Color(0xff000000),
              displayColor: const Color(0xffffffff))),
      home: const MainPage(),
      routes: {
        '/signin/': (context) => const SignIn(),
        '/signup/': (context) => const SignUp(),
        '/home/': (context) => const HomePage(),
      },
    );
  }
}

class NavigatorMenu extends StatefulWidget {
  NavigatorMenu({
    Key? key,
    this.user,
    this.userdata,
    this.userModel,
  }) : super(key: key);
  final User? user;
  late Map? userdata;
  final UserModel? userModel;

  @override
  State<NavigatorMenu> createState() => _NavigatorMenuState();
}

class _NavigatorMenuState extends State<NavigatorMenu> {
  int index = 0;

  final TextStyle optionStyle =
      const TextStyle(fontSize: 30, fontWeight: FontWeight.bold);

  void _onItemTapped(int i) {
    setState(() {
      index = i;
    });
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> screens = <Widget>[
      HomePage(),
      Catalog(),
      ProfilePage(
        userModel: widget.userModel,
        userData: widget.userdata,
      ),
    ];
    return Scaffold(
      // appBar: AppBar(
      //   title: TextButton(
      //     onPressed: (){
      //       Navigator.push(context, MaterialPageRoute(builder: (context)=>ProfilePage(userModel: widget.userModel)));
      //     },
      //     child: Text(widget.userModel!.email.toString(),),
      //     ),
      // ),
      body: screens.elementAt(index),
      bottomNavigationBar: BottomNavigationBar(
        items: <BottomNavigationBarItem>[
          navbarItem(icon: Icons.home, label: "Home"),
          navbarItem(icon: Icons.favorite_outline_outlined, label: "Favourite"),
          navbarItem(icon: Icons.account_box, label: "Accounts"),
        ],
        currentIndex: index,
        unselectedItemColor: const Color(0xffa1a1a1),
        selectedItemColor: const Color(0xff415859),
        showUnselectedLabels: true,
        selectedIconTheme: const IconThemeData(size: 30),
        onTap: _onItemTapped,
        type: BottomNavigationBarType.fixed,
      ),
    );
  }

  BottomNavigationBarItem navbarItem(
      {required IconData icon, required String label}) {
    return BottomNavigationBarItem(
      icon: Icon(icon),
      label: label,
    );
  }
}

class MainPage extends StatefulWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: const Color.fromARGB(255, 23, 25, 26),
      body: FutureBuilder(
        future: Firebase.initializeApp(
          options: DefaultFirebaseOptions.currentPlatform,
        ),
        builder: (context, snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.done:
              final User? user = FirebaseAuth.instance.currentUser;
              print(user);
              if (user != null) {
                if (user.emailVerified) {
                  return NavigatorMenu();
                } else {
                  return SendMail();
                  // Center(child : Text("We sent you a verification link"));
                }
              } else {
                return const SignIn();
              }
            default:
              return const Text("data");
          }
        },
      ),
    );
  }
}

class SendMail extends StatefulWidget {
  SendMail({Key? key}) : super(key: key);

  @override
  State<SendMail> createState() => _SendMailState();
}

class _SendMailState extends State<SendMail> {
  User? user = FirebaseAuth.instance.currentUser;

  bool isMailBtnPressed = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
      child: Center(
          child: Column(
        children: [
          const SizedBox(
            height: 15,
          ),
          const Text("You need to verify your email first",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.w400)),
          TextButton(
              onPressed: () {
                user?.sendEmailVerification();
                setState(() {
                  isMailBtnPressed = !isMailBtnPressed;
                });
              },
              child: const Text(
                "Send Verification mail",
              )),
          Text(isMailBtnPressed ? "We sent you a verification link" : ""),
          TextButton(
              onPressed: () {
                FirebaseAuth.instance.signOut();
                Navigator.of(context).pushAndRemoveUntil(
                    MaterialPageRoute(builder: (context) => const SignIn()),
                    (route) => false);
              },
              child: const Text("Singout")),
          Text(user?.email ?? ""),
        ],
      )),
    ));
  }
}
