import 'package:flutter/material.dart';
import 'package:progress_dialog/progress_dialog.dart';
import 'package:small_seller/signupscreen.dart';
import 'package:small_seller/mainPage.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:toast/toast.dart';
import 'package:http/http.dart' as http;

void main() {
  runApp(MaterialApp(
    home: LoginScreen(),
    theme: ThemeData(
      brightness: Brightness.light,
    ),
  ));
}

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController usernameController = TextEditingController();
  String _username = "";
  final TextEditingController passwordController = TextEditingController();
  String _password = "";

  SharedPreferences prefs;

  @override
  void initState() {
    loadpref();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Small Seller'),
          backgroundColor: Colors.yellow,
        ),
        resizeToAvoidBottomPadding: false,
        body: new Container(
            padding: EdgeInsets.all(30.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Image.asset(
                  'assets/images/smallseller.png',
                  scale: 3.5,
                ),
                Container(
                    alignment: Alignment.center,
                    padding: EdgeInsets.all(10),
                    child: Text(
                      'Sign in',
                      style: TextStyle(fontSize: 20),
                    )),
                Container(
                  padding: EdgeInsets.all(10),
                  child: TextField(
                    controller: usernameController,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'User Name',
                    ),
                  ),
                ),
                Container(
                  padding: EdgeInsets.fromLTRB(10, 10, 10, 0),
                  child: TextField(
                    obscureText: true,
                    controller: passwordController,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Password',
                    ),
                  ),
                ),
                FlatButton(
                  onPressed: () {
                    //forgot password screen
                  },
                  textColor: Colors.blue,
                  child: Text('Forgot Password'),
                ),
                Container(
                  height: 50,
                  padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
                  child: RaisedButton(
                    textColor: Colors.white,
                    color: Colors.blue,
                    child: Text('Sign in'),
                    onPressed: _onPress,
                  ),
                ),
                Container(
                    child: Row(
                  children: <Widget>[
                    Text('Does not have account?'),
                    FlatButton(
                      textColor: Colors.blue,
                      child: Text(
                        'Sign up',
                        style: TextStyle(fontSize: 20),
                      ),
                      onPressed: () {
                        //signup screen
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => RegisterScreen()),
                        );
                      },
                    )
                  ],
                  mainAxisAlignment: MainAxisAlignment.center,
                ))
              ],
            )));
  }

  Future<void> _onPress() async {
    _username = usernameController.text;
    _password = passwordController.text;
    ProgressDialog pr = new ProgressDialog(context,
        type: ProgressDialogType.Normal, isDismissible: false);
    pr.style(message: "Login...");
    await pr.show();
    http.post("https://abiykuomel.com/smallseller/php/loadp.php", body: {
      "username": _username,
      "password": _password,
    }).then((res) {
      print(res.body);
      List userdata = res.body.split(",");
      if (userdata[0] == "success") {
        //   Smallseller user = new Smallseller(
        //      businessname: userdata[1],
        //    email: userdata[0],
        //   );
        Toast.show(
          "Login Succes",
          context,
          duration: Toast.LENGTH_LONG,
          gravity: Toast.TOP,
        );
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (BuildContext context) => MyGridScreen()));
      } else {
        Toast.show(
          "Login failed",
          context,
          duration: Toast.LENGTH_LONG,
          gravity: Toast.TOP,
        );
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (BuildContext context) => LoginScreen()));
      }
    }).catchError((err) {
      print(err);
    });
    await pr.hide();
  }

  void loadpref() {}

//  Future<void> loadpref() async {
  //  prefs = await SharedPreferences.getInstance();
  //  _username = (prefs.getString('username')) ?? '';
  //_password = (prefs.getString('password')) ?? '';

  //if (_username.isNotEmpty) {
  //setState(() {
  //usernameController.text = _username;
  // passwordController.text = _password;
  // });
  // }
  //}
}
