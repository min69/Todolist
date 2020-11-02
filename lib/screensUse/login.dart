import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:todolist/nuility/normal_Dialog.dart';
import 'package:todolist/screensUse/home.dart';
import 'package:todolist/screensUse/signUp.dart';

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  //Field
  String email, password;

  //Logo
  Widget showLogo() {
    return Container(
        width: 130.0, height: 140.0, child: Image.asset('images/flutter.webp'));
  }

  //ชื่อแอป
  /* Widget showAppname() {
    return Text(
      'Fox App Test',
      style: TextStyle(fontSize: 28.0, color: Colors.blue),
    );
  } */

  Widget showUsername() {
    return Text('Email:                                          ',
        style: TextStyle(
          fontSize: 18.0,
        ));
  }

  Widget showPassword() {
    return Text('Password:                                 ',
        style: TextStyle(
          fontSize: 18.0,
        ));
  }

  Widget showText() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Text("Don,t have an Account?", style: TextStyle(color: Colors.black)),
        GestureDetector(
          onTap: () {
            Navigator.pop(context);
            MaterialPageRoute route =
                MaterialPageRoute(builder: (value) => SignUp());
            Navigator.push(context, route);
          },
          child: Text(
            ' Sign Up',
            style: TextStyle(color: Colors.blue[400]),
          ),
        ),
      ],
    );
  }

//เเสดงผลออกหน้าจอ
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Center(
            child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              showLogo(),
              mySizebox(),
              //showAppname(),
              mySizebox(),
              showUsername(),
              emailForm(),
              mySizebox(),
              showPassword(),
              passForm(),
              mySizebox(),
              loginButton(),
              mySizebox(),
              showText(),
            ],
          ),
        )),
      ),
    );
  }

  // ปุ่ม login
  Container loginButton() => Container(
      width: 250.0,
      child: ClipRRect(
        //ลดเหลี่ยมปุ่ม
        borderRadius: BorderRadius.circular(10),
        child: FlatButton(
          padding: EdgeInsets.symmetric(vertical: 15, horizontal: 20),
          color: Colors.blue,
          onPressed: () {
            //print('username=$username ,password=$password');
            if (email == null ||
                email.isEmpty ||
                password == null ||
                password.isEmpty) {
              normalDialog(context, 'Please fill in all fields.');
            } else {
              checkAuthe();
            }
          },
          child: Text(
            'Login',
            style: TextStyle(color: Colors.white, fontSize: 18.0),
          ),
        ),
      ));

  //ระยะห่างระหว่างบรรทัด
  mySizebox() => SizedBox(
        width: 8.0,
        height: 20.0,
      );

//กรอกข้อมูลการเข้าสู่ระบบ
  Widget emailForm() => Container(
        width: 250.0,
        child: TextField(
          onChanged: (value) => email = value.trim(),
          decoration: InputDecoration(
            prefixIcon: Icon(
              Icons.account_circle,
              color: Colors.grey,
            ),
          ),
        ),
      );
//กรอกรหัสผ่าน
  Widget passForm() => Container(
        width: 250.0,
        child: TextField(
          obscureText: true,
          onChanged: (value) => password = value.trim(),
          decoration: InputDecoration(
              prefixIcon: Icon(
                Icons.lock,
                color: Colors.grey,
              ),
              suffixIcon: IconButton(
                icon: Icon(Icons.visibility),
                onPressed: () {
                  Visibility(
                    child: TextField(
                      obscureText: false,
                    ),
                  );
                },
              )),
        ),
      );

  Future<void> checkAuthe() async {
    FirebaseAuth firebaseAuth = FirebaseAuth.instance;
    await firebaseAuth
        .signInWithEmailAndPassword(email: email, password: password)
        .then((response) {
      //print('Authen Success');
      MaterialPageRoute materialPageRoute =
          MaterialPageRoute(builder: (BuildContext context) => HomePage());
      Navigator.of(context).pushAndRemoveUntil(
          materialPageRoute, (Route<dynamic> route) => false);
    }).catchError((response) {
      //print('ไม่ผ่าน');
      normalDialog(context, 'ไม่ข้อมูลในระบบ');
    });
  }
}
