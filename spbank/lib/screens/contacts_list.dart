import 'package:flutter/material.dart';
import 'package:spbank/component/loading.dart';
import 'package:spbank/dao/contact_dao.dart';
import 'package:spbank/models/contact.dart';
import 'package:spbank/screens/contact_form.dart';
import 'package:spbank/screens/transaction_form.dart';

class ContactsList extends StatefulWidget {
  @override
  _ContactsListState createState() => _ContactsListState();
}

class _ContactsListState extends State<ContactsList> {
  final ContactDao _dao = ContactDao();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Transfer"),
      ),
      body: FutureBuilder<List<Contact>>(
        initialData: List(),
        future: _dao.findAll(),
        builder: (context, snapshot) {
          // if (snapshot.data != null) {
          switch (snapshot.connectionState) {
            case ConnectionState.none:
              break;
            case ConnectionState.waiting:
              return Loading();
              break;
            case ConnectionState.active:
              break;
            case ConnectionState.done:
              final List<Contact> contacts = snapshot.data;
              return ListView.builder(
                itemBuilder: (context, index) {
                  final contact = contacts[index];
                  return _ContactCard(
                    contact,
                    onClick: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                            builder: (context) => TransactionForm(contact)),
                      );
                    },
                  );
                },
                itemCount: contacts.length,
              );
              break;
          }
          return Text("Ocorreu um erro desconhecido");
        },
      ),
      floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.of(context)
                .push(MaterialPageRoute(builder: (context) => ContactForm()));
          },
          child: Icon(Icons.add)),
    );
  }
}

class _ContactCard extends StatelessWidget {
  final Contact contact;
  final Function onClick;

  _ContactCard(this.contact, {@required this.onClick});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        title: Text(
          contact.name,
          style: TextStyle(
            fontSize: 18.0,
          ),
        ),
        subtitle: Text(
          contact.accountNumber.toString(),
          style: TextStyle(fontSize: 14.0),
        ),
        onLongPress: () => onClick(),
      ),
    );
  }
}
