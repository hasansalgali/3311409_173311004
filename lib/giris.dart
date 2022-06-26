import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cepfinans/kayit.dart';
import 'package:cepfinans/sayfalar.dart';

class GirisSayfasi extends StatefulWidget {
   GirisSayfasi({Key? key}) : super(key: key);

  @override
  State<GirisSayfasi> createState() => _GirisSayfasiState();
}

class _GirisSayfasiState extends State<GirisSayfasi> {
  String? email;

  String? password;

  final _auth = FirebaseAuth.instance;

  User? loggedInUser;
  @override
  void initState() {
    super.initState();
    getCurrentUser();

  }
  void getCurrentUser() async {
    try {
      final user = await _auth.currentUser;
      if (user != null) {
        Route route = MaterialPageRoute(builder: (context) => MyHomePage());
        Navigator.push(context, route);
      }
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
              children: [
                Image.asset(
                  'assets/logo.png',
                  width: 100,
                ),
                SizedBox(
                  width: 20,
                ),
                Text(
                  "Giris",
                  style: TextStyle(color: Colors.white, fontSize: 40),
                ),
              ],
            ),
            SizedBox(
              height: 20,
            ),
            TextField(

              style: TextStyle(
                color: Colors.grey,
              ),
              decoration: InputDecoration(
                hintText: 'E - posta',
                hintStyle: TextStyle(color: Colors.grey),
                contentPadding: const EdgeInsets.all(10.0),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: Colors.grey,
                    width: 2,
                  ),
                  borderRadius: BorderRadius.circular(10.0),
                ),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: Colors.grey,
                    width: 2,
                  ),
                  borderRadius: BorderRadius.circular(10.0),
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
              ),
              onChanged: (value) {
                email = value;
              },
            ),
            SizedBox(
              height: 20,
            ),
            TextField(
         obscureText: true,
              style: TextStyle(
                color: Colors.grey,
              ),
              decoration: InputDecoration(
                hintText: 'Şifre',
                hintStyle: TextStyle(color: Colors.grey),
                contentPadding: const EdgeInsets.all(10.0),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: Colors.grey,
                    width: 2,
                  ),
                  borderRadius: BorderRadius.circular(10.0),
                ),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: Colors.grey,
                    width: 2,
                  ),
                  borderRadius: BorderRadius.circular(10.0),
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
              ),
              onChanged: (value) {
                password = value;
              },
            ),
            Row(children: [
              MaterialButton(
                onPressed: () async {
                  try {
                    final user = await _auth.signInWithEmailAndPassword(
                        email: email!, password: password!);
                    if (user != null) {
                      Route route = MaterialPageRoute(
                          builder: (context) => MyHomePage());
                      Navigator.push(context, route);
                    }
                  } catch (e) {
                    print(e);
                  }
                },
                child: Text(
                  "Giris",
                  style: TextStyle(color: Colors.white),
                ),
              ),
              MaterialButton(
                onPressed: () {


                  Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) =>  KayitSayfasi()),
                );},
                child: Text(
                  "Kayıt",
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ],)

          ],
        ),
      ),
    );
  }
}
