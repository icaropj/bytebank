import 'package:bytebank/database/dao/contact_dao.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

Future<Database> getDatabase() async {
  var path = await getDatabasesPath();
  final String finalPath = join(path, 'bytebank.db');
  return openDatabase(finalPath, onCreate: (db, version) {
    db.execute(ContactDao.TABLE_SQL);
  }, version: 1);
}

//Future<Database> createDatabase() {
//  return getDatabasesPath().then((path) {
//    final String finalPath = join(path, 'bytebank.db');
//    return openDatabase(
//      finalPath,
//      onCreate: (db, version) {
//        db.execute('CREATE TABLE contact('
//            'id INTEGER PRIMARY KEY, '
//            'name TEXT, '
//            'account_number INTEGER)');
//      },
//      version: 1,
////      onDowngrade: onDatabaseDowngradeDelete,
//    );
//  });
//}

//Future<int> save(Contact contact) {
//  return createDatabase().then((db) {
//    final Map<String, dynamic> contactMap = Map();
//    contactMap['name'] = contact.name;
//    contactMap['account_number'] = contact.accountNumber;
//    return db.insert('contact', contactMap);
//  });
//}

//Future<List<Contact>> findAll() {
//  return getDatabase().then((db) {
//    return db.query('contact').then((maps) {
//      final List<Contact> contacts = List();
//      for (Map<String, dynamic> map in maps) {
//        final Contact contact = Contact(
//          map['id'],
//          map['name'],
//          map['account_number'],
//        );
//        contacts.add(contact);
//      }
//      return contacts;
//    });
//  });
//}
