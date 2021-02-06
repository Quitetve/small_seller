import 'package:flutter/material.dart';
import 'package:small_seller/mainPage.dart';

import 'package:small_seller/user.dart';

void main() {
  runApp(MaterialApp(
    home: ProfileScreen(),
    theme: ThemeData(
      brightness: Brightness.dark,
    ),
  ));
}

class Item {
  const Item(this.name, this.icon);
  final String name;
  final Icon icon;
}

class ProfileScreen extends StatefulWidget {
  final Smallseller user;

  const ProfileScreen({Key key, this.user}) : super(key: key);
  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final TextEditingController bNController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController userController = TextEditingController();
  final TextEditingController add1Controller = TextEditingController();
  final TextEditingController add2Controller = TextEditingController();
  final TextEditingController poscodeController = TextEditingController();
  final TextEditingController stateController = TextEditingController();
  final TextEditingController cityController = TextEditingController();

  // String _addres1 = "";
  // String _address2 = "";
  // String _state = "";
  // String _city = "";
  // String _poscode = "";

  var _formKey = GlobalKey<FormState>();
  Item selectedUser;
  List<Item> users = <Item>[
    const Item(
        'Makanan Kering',
        Icon(
          Icons.fastfood,
          color: const Color(0xFF167F67),
        )),
    const Item(
        'Masakan Panas',
        Icon(
          Icons.fastfood,
          color: const Color(0xFF167F67),
        )),
    const Item(
        'Makanan Bergoreng',
        Icon(
          Icons.fastfood,
          color: const Color(0xFF167F67),
        )),
    const Item(
        'Kedai Runcit',
        Icon(
          Icons.fastfood,
          color: const Color(0xFF167F67),
        )),
  ];

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
          appBar: AppBar(
            title: Text("Small Seller"),
            backgroundColor: Colors.yellow,
          ),
          body: SingleChildScrollView(
              child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              SizedBox(height: 30),
              CircleAvatar(
                backgroundColor: Colors.orange,
                radius: 80,
                child: IconButton(
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => ProfileScreen()));
                  },
                  icon: Icon(
                    Icons.account_circle,
                    color: Colors.white,
                  ),
                  iconSize: 70.0,
                ),
              ),
              Container(
                padding: EdgeInsets.all(5),
                child: TextField(
                  controller: bNController,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Business Name',
                  ),
                ),
              ),
              Container(
                  child: DropdownButton<Item>(
                hint: Text("Business Type"),
                value: selectedUser,
                onChanged: (Item value) {
                  setState(() {
                    selectedUser = value;
                  });
                },
                items: users.map((Item user) {
                  return DropdownMenuItem<Item>(
                    value: user,
                    child: Row(
                      children: <Widget>[
                        user.icon,
                        SizedBox(
                          width: 200,
                        ),
                        Text(
                          user.name,
                          style: TextStyle(color: Colors.black),
                        ),
                      ],
                    ),
                  );
                }).toList(),
              )),
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
                  controller: add1Controller,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Address 1',
                  ),
                ),
              ),
              Container(
                padding: EdgeInsets.fromLTRB(5, 5, 5, 5),
                child: TextField(
                  obscureText: true,
                  controller: add2Controller,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Address 2',
                  ),
                ),
              ),
              Container(
                padding: EdgeInsets.fromLTRB(5, 5, 5, 5),
                child: TextField(
                  obscureText: true,
                  controller: poscodeController,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Poscode',
                  ),
                ),
              ),
              Container(
                padding: EdgeInsets.fromLTRB(5, 5, 5, 5),
                child: TextField(
                  obscureText: true,
                  controller: cityController,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'City',
                  ),
                ),
              ),
              Container(
                padding: EdgeInsets.fromLTRB(5, 5, 5, 5),
                child: TextField(
                  obscureText: true,
                  controller: stateController,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'State',
                  ),
                ),
              ),
              Column(children: [
                RaisedButton(
                    color: Colors.blue,
                    onPressed: () {
                      //      _addres1 = add1Controller.text;
                      //      _address2 = add2Controller.text;
                      //     _state = stateController.text;
                      ///    _city = cityController.text;
                      //    _poscode = cityController.text;
//
                      //     http.post(
                      //          "https://abiykuomel.com/smallseller/php/register_product.php",
                      //          body: {
                      //           "images": _images,
                      //          "productname": _productname,
                      //         "price": _price,
                      //       "productdescription": _productdescription,
                      //     }).then((res) {
                      //       print(res.body);
                      //    }).catchError((err) {
                      //    print(err);
                      //   });
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => MyGridScreen()),
                      );
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => MyGridScreen()),
                      );
                    },
                    child: Text('Save'))
              ]),
            ],
          ))),
    );
  }
}
