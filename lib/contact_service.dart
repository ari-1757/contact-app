import 'contact.dart';

class ContactService {
  List<Contact> contacts = [];

  void addContact(Contact contact) {
    contacts.add(contact);
  }

  void deleteContact(int index) {
    contacts.removeAt(index);
  }

  void updateContact(int index, Contact updatedContact) {
    contacts[index] = updatedContact;
  }
}

