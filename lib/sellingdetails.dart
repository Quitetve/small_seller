import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:small_seller/editprofile.dart';
import 'package:small_seller/loginscreen.dart';
import 'package:small_seller/main.dart';
import 'package:small_seller/manageProduct.dart';
import 'product.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:http/http.dart' as http;

class SalesDetails extends StatefulWidget {
  final Sellerproduct product;

  const SalesDetails({Key key, this.product}) : super(key: key);
  @override
  _SalesDetailsState createState() => _SalesDetailsState();
}

class _SalesDetailsState extends State<SalesDetails> {
  List sellingList;
  double screenWidth, screenHeight;
  String titlecenter = "NO DATA";

  @override
  void initState() {
    super.initState();
    _loadsales();
  }

  Widget build(BuildContext context) {
    screenHeight = MediaQuery.of(context).size.height;
    screenWidth = MediaQuery.of(context).size.width;
    return MaterialApp(
        title: 'Material App',
        home: Scaffold(
          appBar: AppBar(
            title: Text(widget.product.productname),
          ),
          body: Column(children: [
            Container(
                height: screenHeight / 2,
                width: screenWidth / 0.3,
                child: CachedNetworkImage(
                  imageUrl:
                      "https://abiykuomel.com/smallseller/images/productimages/${widget.product.images}.jpg",
                  fit: BoxFit.fill,
                  placeholder: (context, url) =>
                      new CircularProgressIndicator(),
                  errorWidget: (context, url, error) => new Icon(
                    Icons.broken_image,
                    size: screenWidth / 2,
                  ),
                )),
            sellingList == null
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
                    crossAxisCount: 1,
                    childAspectRatio: (screenWidth / screenHeight) / 0.8,
                    children: List.generate(sellingList.length, (index) {
                      return Padding(
                          padding: EdgeInsets.all(1),
                          child: Card(
                            child: InkWell(
                              // onTap: () => _loadselling(index),
                              child: Column(
                                children: [
                                  Container(
                                    height: screenHeight / 3.8,
                                    width: screenWidth / 1.2,
                                    //  child: CachedNetworkImage(
                                    //    imageUrl:
                                    //        "https://abiykuomel.com/smallseller/images/productimages/${sellingList[index]['Images']}.jpg",
                                    //    fit: BoxFit.fill,
                                    //    placeholder: (context, url) =>
                                    //        new CircularProgressIndicator(),
                                    //     errorWidget: (context, url, error) =>
                                    //         new Icon(
                                    //      Icons.broken_image,
                                    //       size: screenWidth / 2,
                                    //     ),
                                    // )
                                  ),
                                  Text(sellingList[index]['salesid'],
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 16,
                                      )),
                                  Text(sellingList[index]['Productname'],
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 18,
                                      )),
                                  Text(sellingList[index]['Price'],
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 16,
                                      )),
                                  Text(sellingList[index]['Quantity'],
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 16,
                                      )),
                                  Text(sellingList[index]['Total'],
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 16,
                                      ))
                                ],
                              ),
                            ),
                          ));
                    }),
                  )),
          ]),
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
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => AccountScreen()));
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
        ));
  }

  void _loadsales() {
    http.post("https://abiykuomel.com/smallseller/php/load_selling.php",
        body: {"productid": widget.product.productid}).then((res) {
      print(res.body);
      if (res.body == "no data") {
        sellingList = null;
      } else {
        setState(() {
          var jsondata = json.decode(res.body);
          sellingList = jsondata["selling"];
        });
      }
    }).catchError((err) {
      print(err);
    });
  }
}
