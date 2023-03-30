import 'package:gsheets/gsheets.dart';
import 'package:scottycon_check_in/user.dart';

class GoogleSheetsApi {
  // Set up credentials
  static const _credentials = r'''
  insert credentials here
  ''';

  // Set up GSheets object
  static const _spreadsheetId = 'insert spreadsheet id here';
  static final _gsheets = GSheets(_credentials);
  static Worksheet? _worksheet;

  // Initialize individual sheets to interact with
  static Future init() async {
    try {
      final ss = await _gsheets.spreadsheet(_spreadsheetId);
      _worksheet = await getWorkSheet(ss, title: "Sheet1");

      final firstRow = UserFields.getFields();
      _worksheet!.values.insertRow(1, firstRow);
    } catch (e) {
      print('Init Error: $e');
    }
  }

  static Future<Worksheet> getWorkSheet(Spreadsheet spreadsheet,
      {required String title}) async {
    try {
      return await spreadsheet.addWorksheet(title);
    } catch (e) {
      return spreadsheet.worksheetByTitle(title)!;
    }
  }

  static Future<User?> getById(int id) async {
    if (_worksheet == null) return null;

    final json = await _worksheet!.values.map.rowByKey(id, fromColumn: 1);
    return json == null ? null : User.fromJson(json);
  }

  static Future insert(List<Map<String, dynamic>> rowList) async {
    if (_worksheet == null) return;

    _worksheet!.values.map.appendRows(rowList);
  }

  static Future setCheckIn(User user, String checkInValue) async {
    if (_worksheet == null) return;

    _worksheet!.values.insertValueByKeys(checkInValue,
        columnKey: "Checked-in", rowKey: user.id);
  }
}
