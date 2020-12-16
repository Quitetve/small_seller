import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: HomePage(),
      theme: ThemeData(
        brightness: Brightness.dark,
      ),
    );
  }
}

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  var _formKey = GlobalKey<FormState>();
  var isLoading = false;
  bool agree = false;
  void _submit() {
    final isValid = _formKey.currentState.validate();
    if (!isValid) {
      return;
    }
    _formKey.currentState.save();
  }

  void _doSomething() {
    // Do something
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Form Validation"),
          backgroundColor: Colors.yellow,
        ),
        //body
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          //form
          child: Form(
            key: _formKey,
            child: Column(children: <Widget>[
              Text(
                "Register Account ",
                style: TextStyle(fontSize: 24.0, fontWeight: FontWeight.bold),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.width * 0.05,
              ),
              TextFormField(
                decoration: InputDecoration(
                    border: OutlineInputBorder(), labelText: 'Business Name'),
                keyboardType: TextInputType.emailAddress,
                onFieldSubmitted: (value) {
                  //Validator
                },
                validator: (value) {
                  if (value.isEmpty ||
                      !RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                          .hasMatch(value)) {
                    return '';
                  }
                  return null;
                },
              ),
              //box styling
              SizedBox(
                height: MediaQuery.of(context).size.width * 0.05,
              ),
              TextFormField(
                decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Type of Business'),
                keyboardType: TextInputType.emailAddress,
                onFieldSubmitted: (value) {
                  //Validator
                },
                validator: (value) {
                  if (value.isEmpty ||
                      !RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                          .hasMatch(value)) {
                    return 'Enter a valid business type!';
                  }
                  return null;
                },
              ),
              //box styling
              SizedBox(
                height: MediaQuery.of(context).size.width * 0.05,
              ),
              //text input
              TextFormField(
                decoration: InputDecoration(
                    border: OutlineInputBorder(), labelText: 'E-Mail'),
                keyboardType: TextInputType.emailAddress,
                onFieldSubmitted: (value) {
                  //Validator
                },
                validator: (value) {
                  if (value.isEmpty ||
                      !RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                          .hasMatch(value)) {
                    return 'Enter a valid email!';
                  }
                  return null;
                },
              ),
              //box styling

              //text input
              SizedBox(
                height: MediaQuery.of(context).size.width * 0.05,
              ),
              TextFormField(
                decoration: InputDecoration(
                    border: OutlineInputBorder(), labelText: 'Password'),
                keyboardType: TextInputType.emailAddress,
                onFieldSubmitted: (value) {},
                obscureText: true,
                validator: (value) {
                  if (value.isEmpty) {
                    return 'Enter a valid password!';
                  }
                  return null;
                },
              ),
              SizedBox(
                height: MediaQuery.of(context).size.width * 0.05,
              ),
              TextFormField(
                decoration: InputDecoration(
                    border: OutlineInputBorder(), labelText: 'Re-Password'),
                keyboardType: TextInputType.emailAddress,
                onFieldSubmitted: (value) {},
                obscureText: true,
                validator: (value) {
                  if (value.isEmpty) {
                    return 'password not match!';
                  }
                  return null;
                },
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
                    onPressed: agree ? _doSomething : () => _submit(),
                    child: Text('Sign up'))
              ]),
            ]),
          ),
        ));
  }
}
