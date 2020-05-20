import 'package:bytebank/database/app_database.dart';
import 'package:bytebank/models/contact.dart';

class ContactDao {

  Future<int> save(Contact contact) async {
    var db = await getDatabase();
    final Map<String, dynamic> contactMap = Map();
    contactMap['name'] = contact.name;
    contactMap['account_number'] = contact.accountNumber;
    return db.insert('contact', contactMap);
  }

  Future<List<Contact>> findAll() async {
    var db = await getDatabase();
    final List<Map<String, dynamic>> result = await db.query('contact');
    final List<Contact> contacts = List();
    for (Map<String, dynamic> row in result) {
      final Contact contact = Contact(
        row['id'],
        row['name'],
        row['account_number'],
      );
      contacts.add(contact);
    }
    return contacts;
  }

}