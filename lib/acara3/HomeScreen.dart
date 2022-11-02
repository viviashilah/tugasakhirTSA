import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import '/acara3/drawer.dart';
import '/acara3/LoginScreen.dart';
import '/persiapan/Lokasi.dart';
import 'RegisterScreen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  Future<void> _signOut() async {
    await FirebaseAuth.instance.signOut();
  }

  @override
  Widget build(BuildContext context) {
    FirebaseAuth auth = FirebaseAuth.instance;
    if (auth.currentUser != null) {
      print(auth.currentUser!.email);
    }
    return Scaffold(
      appBar: AppBar(
        title: Text("home"),
      ),
      drawer: MyDrawer(),
      body: Padding(
        padding: EdgeInsets.all(30),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 60,
            ),
            Text.rich(
              TextSpan(children: [
                TextSpan(
                    text: "Welcome, \n",
                    style: TextStyle(color: Colors.blue[300])),
                TextSpan(
                    text: auth.currentUser!.email,
                    style: TextStyle(color: Colors.blue[900])),
              ]),
              style: TextStyle(fontSize: 30),
            ),
            SizedBox(
              height: 20,
            ),
            Container(
              child: ElevatedButton(
                  onPressed: () {
                    _signOut().then((value) =>
                        Navigator.of(context).pushReplacement(MaterialPageRoute(
                          builder: (context) => LoginScreen(),
                        )));
                  },
                  child: Text("Logout")),
            ),
            SizedBox(
              height: 20,
            ),
            Lokasi(),
          ],
        ),
      ),
    );
  }
}
