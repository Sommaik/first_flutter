import 'dart:io';
import 'package:flutter/material.dart';
import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:intl/intl.dart';
import 'package:image_picker/image_picker.dart';

class ProfileScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return ProfileState();
  }
}

class ProfileState extends State<ProfileScreen> {
  String sex = 'M';
  bool isAdmin = false;
  List<String> adminLevel = ['', '1', '2', '3'];
  String adminLevelValue;
  DateFormat _dateFormat = DateFormat("dd/MM/yyyy");
  DateTime dob;
  File avatar;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Profile"),
      ),
      body: Padding(
        padding: EdgeInsets.all(15.0),
        child: Form(
          child: ListView(
            children: <Widget>[
              buildAvatar(),
              buildSexField(),
              buildIsAdminField(),
              buildAdminLevel(),
              buildDOBField(),
            ],
          ),
        ),
      ),
    );
  }

  Row buildSexField() {
    return Row(
      children: <Widget>[
        Radio(
          value: 'M',
          groupValue: sex,
          onChanged: (String value) {
            setState(() {
              sex = value;
            });
          },
        ),
        Text("Male"),
        Radio(
          value: 'F',
          groupValue: sex,
          onChanged: (String value) {
            setState(() {
              sex = value;
            });
          },
        ),
        Text("Female")
      ],
    );
  }

  Row buildIsAdminField() {
    return Row(
      children: <Widget>[
        Checkbox(
          value: isAdmin,
          onChanged: (bool value) {
            setState(() {
              isAdmin = value;
            });
          },
        ),
        Text("Is Admin")
      ],
    );
  }

  Widget buildAdminLevel() {
    return InputDecorator(
      decoration: InputDecoration(
        labelText: 'Admin Level',
      ),
      isEmpty: adminLevelValue == '',
      child: DropdownButtonHideUnderline(
        child: DropdownButton(
          isDense: true,
          value: adminLevelValue,
          onChanged: (String value) {
            setState(() {
              adminLevelValue = value;
            });
          },
          items: adminLevel.map((String level) {
            return DropdownMenuItem(
              value: level,
              child: Text(level),
            );
          }).toList(),
        ),
      ),
    );
  }

  Widget buildDOBField() {
    return DateTimePickerFormField(
      inputType: InputType.date,
      decoration: InputDecoration(
        labelText: "DOB",
      ),
      format: _dateFormat,
      onChanged: (DateTime value) {
        setState(() {
          dob = value;
        });
      },
    );
  }

  Widget buildAvatar() {
    return avatar == null
        ? FlatButton(
            child: Text("Upload image"),
            onPressed: uploadImage,
          )
        : Image.file(avatar);
  }

  Future uploadImage() async {
    File img = await ImagePicker.pickImage(source: ImageSource.camera);
    setState(() {
      avatar = img;
    });
  }
}
