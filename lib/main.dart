import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:small_seller/ManageAccount.dart';
import 'package:small_seller/MainPage.dart';
import 'package:http/http.dart' as http;

void main() {
  runApp(MaterialApp(
    home: AccountScreen(),
    theme: ThemeData(
      brightness: Brightness.light,
    ),
  ));
}

class AccountScreen extends StatefulWidget {
  @override
  _AccountScreenState createState() => _AccountScreenState();
}

class _AccountScreenState extends State<AccountScreen> {
  @override
  void initState() {
    super.initState();
  }

  TextEditingController productname = TextEditingController();
  TextEditingController price = TextEditingController();
  TextEditingController quantity = TextEditingController();
  TextEditingController total = TextEditingController();

  String _productname = "";
  String _price = "";
  String _quantity = "";
  String _total = "";

  bool agree = true;
  var _formKey = GlobalKey<FormState>();
  var isLoading = false;

  // This function is triggered when the button is clicked

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
                      'Update Selling',
                      style: TextStyle(
                          color: Colors.yellow,
                          fontWeight: FontWeight.w500,
                          fontSize: 30),
                    )),
                MyTextFieldDatePicker(
                  labelText: "Date",
                  prefixIcon: Icon(Icons.date_range),
                  suffixIcon: Icon(Icons.arrow_drop_down),
                  lastDate: DateTime.now().add(Duration(days: 366)),
                  firstDate: DateTime.now(),
                  initialDate: DateTime.now().add(Duration(days: 1)),
                  onDateChanged: (selectedDate) {
                    // Do something with the selected date
                  },
                ),
                Container(
                  padding: EdgeInsets.all(5),
                  child: TextField(
                    controller: productname,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Product Name',
                    ),
                  ),
                ),
                Container(
                  padding: EdgeInsets.all(5),
                  child: TextField(
                    key: _formKey,
                    controller: price,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Price',
                    ),
                    keyboardType: TextInputType.emailAddress,
                  ),
                ),
                Container(
                  padding: EdgeInsets.all(5),
                  child: TextField(
                    controller: quantity,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Quantity',
                    ),
                  ),
                ),
                Container(
                  padding: EdgeInsets.all(5),
                  child: TextField(
                    controller: total,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Total',
                    ),
                  ),
                ),
                Container(
                    height: 50,
                    padding: EdgeInsets.fromLTRB(5, 10, 10, 5),
                    child: RaisedButton(
                      textColor: Colors.white,
                      color: Colors.blue,
                      child: Text('Save'),
                      onPressed: () {
                        _productname = productname.text;
                        _price = price.text;
                        _quantity = quantity.text;

                        http.post(
                            "https://abiykuomel.com/smallseller/php/register_selling.php",
                            body: {
                              "productname": _productname,
                              "price": _price,
                              "quantity": _quantity,
                              "total": _total,
                            }).then((res) {
                          print(res.body);
                        }).catchError((err) {
                          print(err);
                        });
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => MyGridScreen()),
                        );
                      },
                    )),
              ],
            )));
  }
}
