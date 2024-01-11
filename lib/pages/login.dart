import 'package:flutter/material.dart';
import 'package:mobile_akhir/pages/home.dart';
import 'package:mobile_akhir/bottombar/bottom_navbar.dart';
import 'package:mobile_akhir/pages/registrasi.dart';
import 'package:flutter/material.dart';

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  void showLoginFailedDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Login Gagal'),
          content: Text('Login gagal! Periksa kembali username dan password.'),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('OK'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text('Login'),
        foregroundColor: Color(0xffedfcdc),
        backgroundColor: Color(0xff88a26a),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: usernameController,
              decoration: InputDecoration(
                labelText: 'Username',
              ),
            ),
            TextField(
              controller: passwordController,
              decoration: InputDecoration(
                labelText: 'Password',
              ),
              obscureText: true,
            ),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                final String username = usernameController.text;
                final String password = passwordController.text;

                // Validasi login
                if (registeredUsers.containsKey(username) &&
                    registeredUsers[username] == password) {
                  ScaffoldMessenger.of(context).showSnackBar(

                    SnackBar(
                      content: Text('Login berhasil!'),
                    ),
                  );
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => BottomNavbar(),
                    ),
                  );
                } else {
                  showLoginFailedDialog();
                }
              },
              child: Text('Login'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => Registrasi(),
                  ),
                );
              },
              child: Text('Register'),
            ),
          ],
        ),
      ),
    );
  }
}

// Simpan data pendaftaran dalam variabel global (untuk keperluan contoh)
Map<String, String> registeredUsers = {};

