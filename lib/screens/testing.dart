import 'dart:io';


import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import '../constant.dart';
import '../models/api_response.dart';
import '../models/user.dart';
import '../services/user_service.dart';
import 'login.dart';

class testing extends StatefulWidget {
  @override
  _testingState createState() => _testingState();
}

class _testingState extends State<testing> {
  User? user;
  bool loading = true;
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  File? _imageFile;
  final _picker = ImagePicker();
  TextEditingController txtNameController = TextEditingController();

  Future getImage() async {
    final pickedFile = await _picker.getImage(source: ImageSource.gallery);
    if (pickedFile != null){
      setState(() {
        _imageFile = File(pickedFile.path);
      });
    }
  }

  // get user detail
  void getUser() async {
    ApiResponse response = await getUserDetail();
    if(response.error == null) {
      setState(() {
        user = response.data as User;
        loading = false;
        txtNameController.text = user!.name ?? '';
      });
    }
    else if(response.error == unauthorized){
      logout().then((value) => {
        Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context)=>Login()), (route) => false)
      });
    }
    else {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text('${response.error}')
      ));
    }
  }

  //update profile
  void updateProfile() async {
    ApiResponse response = await updateUser(txtNameController.text, getStringImage(_imageFile));
    setState(() {
      loading = false;
    });
    if(response.error == null){
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text('${response.data}')
      ));
    }
    else if(response.error == unauthorized){
      logout().then((value) => {
        Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context)=>Login()), (route) => false)
      });
    }
    else {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text('${response.error}')
      ));
    }
  }

  @override
  void initState() {
    getUser();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return loading
        ? Center(child: CircularProgressIndicator())
        : Scaffold(
      appBar: AppBar(
        title: Text('Your Page Title'),
      ),
      body: Padding(
        padding: EdgeInsets.only(top: 40, left: 40, right: 40),
        child: ListView(
          children: [
            Center(
              child: GestureDetector(
                child: Container(
                  width: 110,
                  height: 110,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(60),
                    image: _imageFile == null
                        ? user!.image != null
                        ? DecorationImage(
                        image: NetworkImage('${user!.image}'),
                        fit: BoxFit.cover)
                        : null
                        : DecorationImage(
                        image: FileImage(_imageFile ?? File('')),
                        fit: BoxFit.cover),
                    color: Colors.amber,
                  ),
                ),
                onTap: () {
                  getImage();
                },
              ),
            ),
            SizedBox(height: 20,),
            Form(
              key: formKey,
              child: TextFormField(
                decoration: kInputDecoration('Name'),
                controller: txtNameController,
                validator: (val) =>
                val!.isEmpty ? 'Invalid Name' : null,
              ),
            ),
            SizedBox(height: 20,),
            kTextButton('Update', () {
              if (formKey.currentState!.validate()) {
                setState(() {
                  loading = true;
                });
                updateProfile();
              }
            })
          ],
        ),
      ),
    );
  }}
