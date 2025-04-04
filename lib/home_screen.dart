import 'package:flutter/material.dart';
import 'contact.dart';
import 'contact_service.dart';
import 'add_edit_contact.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  ContactService contactService = ContactService();
  TextEditingController searchController = TextEditingController();
  List<Contact> filteredContacts = [];

  @override
  void initState() {
    super.initState();
    filteredContacts = contactService.contacts;
  }

  void _searchContacts(String query) {
    setState(() {
      filteredContacts = contactService.contacts
          .where((contact) =>
      contact.name.toLowerCase().contains(query.toLowerCase()) ||
          contact.phone.contains(query))
          .toList();
    });
  }

  void _navigateToAddEditContact({Contact? contact, int? index}) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => AddEditContact(
          contact: contact,
          onSave: (newContact) {
            setState(() {
              if (index != null) {
                contactService.updateContact(index, newContact);
              } else {
                contactService.addContact(newContact);
              }
              filteredContacts = contactService.contacts;
            });
          },
        ),
      ),
    );
  }

  void _deleteContact(int index) {
    setState(() {
      contactService.deleteContact(index);
      filteredContacts = contactService.contacts;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Contacts")),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: searchController,
              decoration: InputDecoration(
                labelText: "Search Contacts",
                prefixIcon: Icon(Icons.search),
                border: OutlineInputBorder(),
              ),
              onChanged: _searchContacts,
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: filteredContacts.length,
              itemBuilder: (context, index) {
                final contact = filteredContacts[index];
                return ListTile(
                  title: Text(contact.name),
                  subtitle: Text(contact.phone),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                        icon: Icon(Icons.edit, color: Colors.blue),
                        onPressed: () =>
                            _navigateToAddEditContact(contact: contact, index: index),
                      ),
                      IconButton(
                        icon: Icon(Icons.delete, color: Colors.red),
                        onPressed: () => _deleteContact(index),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () => _navigateToAddEditContact(),
      ),
    );
  }
}
