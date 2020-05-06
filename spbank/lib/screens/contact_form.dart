import 'dart:math';

import 'package:flutter/material.dart';
import 'package:spbank/dao/contact_dao.dart';
import 'package:spbank/models/contact.dart';

class ContactForm extends StatefulWidget {
  @override
  _ContactFormState createState() => _ContactFormState();
}

class _ContactFormState extends State<ContactForm> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _accountNumberController =
      TextEditingController();
  final ContactDao _dao = ContactDao();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Add Contact"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(18.0),
        child: Column(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(bottom: 8.0),
              child: TextField(
                  controller: _nameController,
                  decoration: InputDecoration(
                    labelText: "Full Name",
                  ),
                  style: TextStyle(
                    fontSize: 14.0,
                  )),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 18.0),
              child: TextField(
                controller: _accountNumberController,
                decoration: InputDecoration(
                  labelText: "Account Number",
                ),
                style: TextStyle(
                  fontSize: 14.0,
                ),
                keyboardType: TextInputType.number,
              ),
            ),
            SizedBox(
              width: double.maxFinite,
              height: 50.0,
              child: RaisedButton(
                padding: EdgeInsets.only(top: 8.0),
                onPressed: () {
                  final String name = _nameController.text;
                  final int accountNumber =
                      int.tryParse(_accountNumberController.text);
                  final Contact newContact =
                      Contact(new Random().nextInt(100), name, accountNumber);
                  _dao.save(newContact).then((int) => Navigator.pop(context));
                },
                child: Text("Add"),
              ),
            )
          ],
        ),
      ),
    );
  }
}
