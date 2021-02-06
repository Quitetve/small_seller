import 'package:flutter/material.dart';
import 'package:small_seller/loginscreen.dart';
import 'package:http/http.dart' as http;
// import 'package:small_seller/user.dart';

void main() {
  runApp(MaterialApp(
    home: RegisterScreen(),
    theme: ThemeData(
      brightness: Brightness.light,
    ),
  ));
}

class RegisterScreen extends StatefulWidget {
  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController userController = TextEditingController();
  TextEditingController passController = TextEditingController();
  TextEditingController repassController = TextEditingController();

  String _businessname = "";
  String _email = "";
  String _username = "";
  String _password = "";

  bool agree = false;
  var _formKey = GlobalKey<FormState>();
  var isLoading = false;

  // This function is triggered when the button is clicked
  void _doSomethingelse() {
    // Do something
    _businessname = nameController.text;
    _email = emailController.text;
    _username = userController.text;
    _password = passController.text;

    http.post("https://abiykuomel.com/smallseller/php/register_seller.php",
        body: {
          "businessname": _businessname,
          "email": _email,
          "username": _username,
          "password": _password,
        }).then((res) {
      print(res.body);
    }).catchError((err) {
      print(err);
    });
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => LoginScreen()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Small Seller'),
          backgroundColor: Colors.yellow,
        ),
        body: Padding(
            padding: EdgeInsets.all(5),
            child: ListView(
              children: <Widget>[
                Container(
                    alignment: Alignment.center,
                    padding: EdgeInsets.all(5),
                    child: Text(
                      'Register Your Account',
                      style: TextStyle(
                          color: Colors.yellow,
                          fontWeight: FontWeight.w500,
                          fontSize: 30),
                    )),
                Container(
                  padding: EdgeInsets.all(5),
                  child: TextField(
                    controller: nameController,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Business Name',
                    ),
                  ),
                ),
                Container(
                  padding: EdgeInsets.all(5),
                  child: TextField(
                    key: _formKey,
                    controller: emailController,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Email',
                    ),
                    keyboardType: TextInputType.emailAddress,
                  ),
                ),
                Container(
                  padding: EdgeInsets.all(5),
                  child: TextField(
                    controller: userController,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'User Name',
                    ),
                  ),
                ),
                Container(
                  padding: EdgeInsets.all(5),
                  child: TextField(
                    obscureText: true,
                    controller: passController,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Password',
                    ),
                  ),
                ),
                Container(
                  padding: EdgeInsets.fromLTRB(5, 5, 5, 5),
                  child: TextField(
                    obscureText: true,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Re-Password',
                    ),
                  ),
                ),
                Column(children: [
                  Row(
                    children: [
                      Material(
                        child: Checkbox(
                          value: agree,
                          onChanged: (value) {
                            setState(() {
                              agree = value;
                            });
                          },
                        ),
                      ),
                      Text(
                        'I have read and accept terms and conditions',
                        overflow: TextOverflow.ellipsis,
                      )
                    ],
                  ),
                  RaisedButton(
                      onPressed: agree ? _doSomethingelse : null,
                      child: Text('Sign up'))
                ]),
                Container(
                    child: Row(
                  children: <Widget>[
                    Text('Already registered?'),
                    FlatButton(
                      textColor: Colors.blue,
                      child: Text(
                        'Sign in',
                        style: TextStyle(fontSize: 20),
                      ),
                      onPressed: () {
                        //sigin screen
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => LoginScreen()));
                      },
                    )
                  ],
                  mainAxisAlignment: MainAxisAlignment.center,
                ))
              ],
            )));
  }
}
