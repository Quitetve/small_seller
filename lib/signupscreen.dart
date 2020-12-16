import 'package:flutter/material.dart';
import 'package:small_seller/loginscreen.dart';

void main() {
  runApp(MaterialApp(
    home: RegisterScreen(),
    theme: ThemeData(
      brightness: Brightness.dark,
    ),
  ));
}

class RegisterScreen extends StatefulWidget {
  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  TextEditingController nameController1 = TextEditingController();
  TextEditingController nameController2 = TextEditingController();
  TextEditingController nameController3 = TextEditingController();
  TextEditingController nameController4 = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  bool agree = false;
  var _formKey = GlobalKey<FormState>();
  var isLoading = false;

  // This function is triggered when the button is clicked
  void _doSomething() {
    // Do something
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
                    controller: nameController1,
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
                    controller: nameController2,
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
                    controller: nameController3,
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
                    controller: nameController4,
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
                    controller: passwordController,
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
                  ElevatedButton(
                      onPressed: agree ? _doSomething : null,
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
                              builder: (context) => LoginScreen()),
                        );
                      },
                    )
                  ],
                  mainAxisAlignment: MainAxisAlignment.center,
                ))
              ],
            )));
  }
}
