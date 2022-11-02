import 'package:flutter/material.dart';
import '/acara3/LoginScreen.dart';
import '/acara3/profile.dart';
import 'HomeScreen.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'profile.dart';

class MyDrawer extends StatefulWidget {
  const MyDrawer({super.key});

  @override
  State<MyDrawer> createState() => _MyDrawerState();
}

class _MyDrawerState extends State<MyDrawer> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _numberController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    logout() async {
      var pref = await SharedPreferences.getInstance();
      pref.remove("username");
      Navigator.of(context).push(MaterialPageRoute(
        builder: (context) => LoginScreen(),
      ));
    }

    FirebaseAuth auth = FirebaseAuth.instance;
    if (auth.currentUser != null) {
      print(auth.currentUser!.email);
    }

    return Drawer(
        child: ListView(padding: EdgeInsets.zero, children: [
      //kotak profil
      UserAccountsDrawerHeader(
        accountName: Text(auth.currentUser!.email.toString()),
        accountEmail: Text(auth.currentUser!.email.toString()),
        currentAccountPicture: CircleAvatar(
          child: ClipOval(
            child: Image.network(
              "https://images.wallpapersden.com/image/download/jennie-kim-4k_a2xmbGqUmZqaraWkpJRnZmtlrWhtaWU.jpg",
              width: 90,
              height: 90,
              fit: BoxFit.cover,
            ),
          ),
        ),
        decoration: BoxDecoration(
          color: Colors.blue,
        ),
      ),

      // menu list
      ListTile(
        onTap: () {
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => HomeScreen()));
        },
        leading: Icon(
          Icons.home,
          color: Colors.grey,
        ),
        title: Text(
          "Home",
          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.grey),
        ),
      ),
      ListTile(
        onTap: () {
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => MyProfile()));
        },
        leading: Icon(
          Icons.person,
          color: Colors.grey,
        ),
        title: Text(
          "Profile",
          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.grey),
        ),
      ),
      ListTile(
        leading: IconButton(
          onPressed: () {
            logout();
          },
          icon: Icon(Icons.logout, color: Colors.grey),
        ),
      ),
    ]));
  }
}
