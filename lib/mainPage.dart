import 'dart:convert';

import 'package:flutter/material.dart';

import 'package:small_seller/loginscreen.dart';
import 'package:small_seller/editprofile.dart';
import 'package:small_seller/ManageProduct.dart';
import 'package:small_seller/main.dart';
import 'package:http/http.dart' as http;
import 'package:cached_network_image/cached_network_image.dart';
import 'package:small_seller/product.dart';
import 'package:small_seller/sellingdetails.dart';
import 'package:small_seller/user.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: MyGridScreen(),
    );
  }
}

class MyGridScreen extends StatefulWidget {
  MyGridScreen({Key key, Smallseller seller, Smallseller user})
      : super(key: key);

  @override
  _MyGridScreenState createState() => _MyGridScreenState();
}

class _MyGridScreenState extends State<MyGridScreen> {
  List productList;
  double screenWidth, screenHeight;
  String titlecenter = "NO DATA";

  @override
  void initState() {
    super.initState();
    _loadproduct();
  }

  Widget build(BuildContext context) {
    screenHeight = MediaQuery.of(context).size.height;
    screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        title: Text("Small Seller"),
        backgroundColor: Colors.yellow,
      ),
      body: Column(
        children: [
          productList == null
              ? Flexible(
                  child: Container(
                      child: Center(
                          child: Text(
                  titlecenter,
                  style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.black),
                ))))
              : Flexible(
                  child: GridView.count(
                  crossAxisCount: 2,
                  childAspectRatio: (screenWidth / screenHeight) / 0.8,
                  children: List.generate(productList.length, (index) {
                    return Padding(
                        padding: EdgeInsets.all(1),
                        child: Card(
                          child: InkWell(
                            onTap: () => _loadselling(index),
                            child: Column(
                              children: [
                                Container(
                                    height: screenHeight / 3.8,
                                    width: screenWidth / 1.2,
                                    child: CachedNetworkImage(
                                      imageUrl:
                                          "https://abiykuomel.com/smallseller/images/productimages/${productList[index]['Images']}.jpg",
                                      fit: BoxFit.fill,
                                      placeholder: (context, url) =>
                                          new CircularProgressIndicator(),
                                      errorWidget: (context, url, error) =>
                                          new Icon(
                                        Icons.broken_image,
                                        size: screenWidth / 2,
                                      ),
                                    )),
                                Text(productList[index]['Productname'],
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 18,
                                    )),
                                Text(productList[index]['Price'],
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16,
                                    ))
                              ],
                            ),
                          ),
                        ));
                  }),
                ))
        ],
      ),
      drawer: Drawer(
        child: ListView(
          // Important: Remove any padding from the ListView.
          padding: EdgeInsets.zero,
          children: <Widget>[
            UserAccountsDrawerHeader(
              accountName: Text("Pakya kedai runcit"),
              accountEmail: Text("pakya2@gmail.com"),
              currentAccountPicture: CircleAvatar(
                backgroundColor: Colors.orange,
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
                  iconSize: 40.0,
                ),
              ),
            ),
            ListTile(
              leading: Icon(Icons.add_business_outlined),
              title: Text("Manage Stall"),
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => ManageStallScreen()));
              },
            ),
            ListTile(
              leading: Icon(Icons.account_balance),
              title: Text("Manage Selling"),
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => AccountScreen()));
              },
            ),
            ListTile(
              leading: Icon(Icons.logout),
              title: Text("Log Out"),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => LoginScreen()),
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  void _loadproduct() {
    http.post("https://abiykuomel.com/smallseller/php/load_product.php",
        body: {}).then((res) {
      print(res.body);
      if (res.body == "no data") {
        productList = null;
      } else {
        setState(() {
          var jsondata = json.decode(res.body);
          productList = jsondata["product"];
        });
      }
    }).catchError((err) {
      print(err);
    });
  }

  _loadselling(int index) {
    // print(productList[index]['Productname']);
    Sellerproduct productD = new Sellerproduct(
      productid: productList[index]['productid'],
      images: productList[index]['Images'],
      productname: productList[index]['Productname'],
      price: productList[index]['Price'],
      productdescription: productList[index]['Productdescription'],
    );
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => SalesDetails(product: productD)));
  }
}
