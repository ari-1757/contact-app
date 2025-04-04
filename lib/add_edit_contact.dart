import 'package:flutter/material.dart';
import 'contact.dart';

class AddEditContact extends StatefulWidget {
  final Contact? contact;
  final Function(Contact) onSave;

  AddEditContact({this.contact, required this.onSave});

  @override
  _AddEditContactState createState() => _AddEditContactState();
}

class _AddEditContactState extends State<AddEditContact> {
  TextEditingController nameController = TextEditingController();
  TextEditingController phoneController = TextEditingController();

  @override
  void initState() {
    super.initState();
    if (widget.contact != null) {
      nameController.text = widget.contact!.name;
      phoneController.text = widget.contact!.phone;
    }
  }

  void _saveContact() {
    if (nameController.text.isEmpty || phoneController.text.isEmpty) {
      return;
    }
    widget.onSave(Contact(name: nameController.text, phone: phoneController.text));
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget.contact == null ? "Add Contact" : "Edit Contact")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: nameController,
              decoration: InputDecoration(labelText: "Name"),
            ),
            SizedBox(height: 10),
            TextField(
              controller: phoneController,
              decoration: InputDecoration(labelText: "Phone Number"),
              keyboardType: TextInputType.phone,
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _saveContact,
              child: Text("Save Contact"),
            ),
          ],
        ),
      ),
    );
  }
}
