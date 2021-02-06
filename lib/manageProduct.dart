import 'dart:io';

import 'package:flutter/material.dart';
import 'package:small_seller/mainPage.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';

import 'package:image_cropper/image_cropper.dart';

void main() {
  runApp(MaterialApp(
    home: ManageStallScreen(),
    theme: ThemeData(
      brightness: Brightness.light,
    ),
  ));
}

class Item {
  const Item(this.name, this.icon);
  final String name;
  final Icon icon;
}

class ManageStallScreen extends StatefulWidget {
  @override
  _ManageStallScreenState createState() => _ManageStallScreenState();
}

class _ManageStallScreenState extends State<ManageStallScreen> {
  TextEditingController productname = TextEditingController();
  TextEditingController price = TextEditingController();
  TextEditingController productdescription = TextEditingController();

  double screenHeight, screenWidth;

  String _images = "";
  String _productname = "";
  String _price = "";
  String _productdescription = "";

  var _formKey = GlobalKey<FormState>();
  Item selectedUser;

  File _image;
  String pathAsset = 'assets/images/camera.png';
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    screenHeight = MediaQuery.of(context).size.height;
    screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
        appBar: AppBar(
          title: Text("Small Seller"),
          backgroundColor: Colors.yellow,
        ),
        body: // SingleChildScrollView(
            //   child: Column(
            //  mainAxisAlignment: MainAxisAlignment.start,
            //  children: [
            //   SizedBox(height: 30),
            //   GestureDetector(
            //   onTap: () => {_onPictureSelection()},
            // child: //Container(
            // decoration:
            //  BoxDecoration(
            //    image: DecorationImage(
            //      image: _images == null
            //       ? AssetImage(pathAsset)
            //      : FileImage(_images),

            //    CircleAvatar(
            //    backgroundColor: Colors.orange,
            //   radius: 80,
            //                child: ClipOval(
            //   child: (_image != null)
            //   ? Image.file(_image)
            //   : Image.asset('images/newimage.png'),
            // )
            //  child: IconButton(
            //    onPressed: () {},
            //   icon: Icon(
            //     Icons.add_a_photo,
            //       color: Colors.white,
            //     ),
            //     iconSize: 70.0,
            //     ),
            //    )),
            Container(
                child: Padding(
                    padding: EdgeInsets.fromLTRB(30, 10, 30, 10),
                    child: SingleChildScrollView(
                        child: Column(
                      children: [
                        GestureDetector(
                            onTap: () => {_onPictureSelection()},
                            child: Container(
                              height: screenHeight / 3.2,
                              width: screenWidth / 1.8,
                              decoration: BoxDecoration(
                                image: DecorationImage(
                                  image: _image == null
                                      ? AssetImage(pathAsset)
                                      : FileImage(_image),
                                  fit: BoxFit.cover,
                                ),
                                border: Border.all(
                                  width: 3.0,
                                  color: Colors.grey,
                                ),
                                borderRadius: BorderRadius.all(Radius.circular(
                                        5.0) //         <--- border radius here
                                    ),
                              ),
                            )),
                        SizedBox(height: 5),
                        Text("Click image to take product picture",
                            style:
                                TextStyle(fontSize: 15.0, color: Colors.black)),
                        SizedBox(height: 5),
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
                            controller: productdescription,
                            decoration: InputDecoration(
                              border: OutlineInputBorder(),
                              labelText: 'Product description',
                            ),
                          ),
                        ),
                        Column(children: [
                          RaisedButton(
                              color: Colors.blue,
                              onPressed: () {
                                _productname = productname.text;
                                _price = price.text;
                                _productdescription = productdescription.text;

                                http.post(
                                    "https://abiykuomel.com/smallseller/php/register_product.php",
                                    body: {
                                      "images": _images,
                                      "productname": _productname,
                                      "price": _price,
                                      "productdescription": _productdescription,
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
                              child: Text('Realese'))
                        ]),
                      ],
                    )))));
  }

  _onPictureSelection() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        var screenHeight = MediaQuery.of(context).size.height;
        return AlertDialog(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(20.0))),
            content: new Container(
              height: screenHeight / 4,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Container(
                      alignment: Alignment.center,
                      child: Text(
                        "Take picture from:",
                        style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 16),
                      )),
                  SizedBox(height: 16),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Flexible(
                          child: MaterialButton(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(5.0)),
                        minWidth: 100,
                        height: 100,
                        child: Text('camera',
                            style: TextStyle(
                              color: Colors.black,
                            )),
                        color: Color.fromRGBO(101, 255, 218, 50),
                        textColor: Colors.white,
                        elevation: 10,
                        onPressed: () =>
                            {Navigator.pop(context), _chooseCamera()},
                      )),
                      SizedBox(width: 10),
                      Flexible(
                          child: MaterialButton(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(5.0)),
                        minWidth: 100,
                        height: 100,
                        child: Text('Gallery',
                            style: TextStyle(
                              color: Colors.black,
                            )),
                        color: Color.fromRGBO(101, 255, 218, 50),
                        textColor: Colors.white,
                        elevation: 10,
                        onPressed: () => {
                          Navigator.pop(context),
                          _chooseGallery(),
                        },
                      )),
                    ],
                  ),
                ],
              ),
            ));
      },
    );
  }

  void _chooseCamera() async {
    // ignore: deprecated_member_use
    _image = await ImagePicker.pickImage(
        source: ImageSource.camera, maxHeight: 800, maxWidth: 800);
    _cropImage();
    setState(() {});
  }

  void _chooseGallery() async {
    // ignore: deprecated_member_use
    _image = await ImagePicker.pickImage(
        source: ImageSource.gallery, maxHeight: 800, maxWidth: 800);
    _cropImage();
    setState(() {});
  }

  Future<Null> _cropImage() async {
    File croppedFile = await ImageCropper.cropImage(
        sourcePath: _image.path,
        aspectRatioPresets: Platform.isAndroid
            ? [
                CropAspectRatioPreset.square,
              ]
            : [
                CropAspectRatioPreset.square,
              ],
        androidUiSettings: AndroidUiSettings(
            toolbarTitle: 'Resize',
            toolbarColor: Colors.deepOrange,
            toolbarWidgetColor: Colors.white,
            initAspectRatio: CropAspectRatioPreset.square,
            lockAspectRatio: false),
        iosUiSettings: IOSUiSettings(
          title: 'Cropper',
        ));
    if (croppedFile != null) {
      _image = croppedFile;
      setState(() {});
    }
  }
}
