import 'package:bytebank/models/contact.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

Future<Database> createDatabase() {
  return getDatabasesPath().then((path) {
    final String finalPath = join(path, 'bytebank.db');
    return openDatabase(finalPath, onCreate: (db, version) {
      db.execute('CREATE TABLE contact('
          'id INTEGER PRIMARY KEY, '
          'name TEXT, '
          'account_number INTEGER)');
    }, version: 1);
  });
}

Future<int> save(Contact contact) {
  return createDatabase().then((db) {
    final Map<String, dynamic> contactMap = Map();
    contactMap['name'] = contact.name;
    contactMap['account_number'] = contact.accountNumber;
    return db.insert('contact', contactMap);
  });
}

Future<List<Contact>> findAll() {
  return createDatabase().then((db) {
    return db.query('contact').then((maps) {
      final List<Contact> contacts = List();
      for (Map<String, dynamic> map in maps) {
        final Contact contact = Contact(
          map['id'],
          map['name'],
          map['account_number'],
        );
        contacts.add(contact);
      }
      return contacts;
    });
  });
}