import 'package:bytebank/database/app_database.dart';
import 'package:bytebank/models/contact.dart';

class ContactDao {

  static const String TABLE_SQL = 'CREATE TABLE $_TABLE_NAME('
      '$_ID INTEGER PRIMARY KEY, '
      '$_NAME TEXT, '
      '$_ACCOUNT_NUMBER INTEGER)';

  static const String _TABLE_NAME = 'contact';
  static const String _ID = 'id';
  static const String _NAME = 'name';
  static const String _ACCOUNT_NUMBER = 'account_number';

  Future<int> save(Contact contact) async {
    var db = await getDatabase();
    Map<String, dynamic> contactMap = _toMap(contact);
    return db.insert(_TABLE_NAME, contactMap);
  }

  Future<List<Contact>> findAll() async {
    var db = await getDatabase();
    final List<Map<String, dynamic>> result = await db.query(_TABLE_NAME);
    final List<Contact> contacts = List();
    _toList(result, contacts);
    return contacts;
  }

  Map<String, dynamic> _toMap(Contact contact) {
    final Map<String, dynamic> contactMap = Map();
    contactMap[_NAME] = contact.name;
    contactMap[_ACCOUNT_NUMBER] = contact.accountNumber;
    return contactMap;
  }

  void _toList(List<Map<String, dynamic>> result, List<Contact> contacts) {
    for (Map<String, dynamic> row in result) {
      final Contact contact = Contact(
        row[_ID],
        row[_NAME],
        row[_ACCOUNT_NUMBER],
      );
      contacts.add(contact);
    }
  }

}