import 'dart:ffi';

import 'package:gsheets/gsheets.dart';
import 'package:scottycon_check_in/user.dart';

class GoogleSheetsApi {
  // Set up credentials
  static const _credentials = r'''
  {
    "type": "service_account",
    "project_id": "scottycon-check-in",
    "private_key_id": "51e9d1cc2e663fe1aaa3a08100b80013bd6a9f77",
    "private_key": "-----BEGIN PRIVATE KEY-----\nMIIEvwIBADANBgkqhkiG9w0BAQEFAASCBKkwggSlAgEAAoIBAQCyiAu52IHP1SYd\npRUWAOgchRiQM/Ng9iSMaVRKufeKNKsdQB1g2/O+wr5PU2rojI51grQwPEYVJ0kU\ntdrBcdmuxtON+unPdrAfj7RKO0zv1c7/bX6jqasdEbog81+47vigwAiUVMreiYgo\nH4w20ga4su4O3RbkxKM1teB3M5JCu0n1Qb0VZ3cPqXIY3gPSdeaFsT2avwNZWUjF\n7nUnOAH8L258ZS2atRZ4/cSswcF9zgDv9jE5T3LRTw9nxtdwi5uiQzon02znefxf\nMXVpo1kua14Pw4vpw9mv+cmUtQ3EiBSWKrRm/MdV8aeUVCcAkaC9PM50ypCKITEg\nXpMesay9AgMBAAECggEAJlVTTTl5b/5ok3tvelzB+eOzGT1qX9KiGNsB3BSvm8eA\nyURLupEntjk64y36WcnaSc2BcozykFax2KZOfPQ85Qvwfz8VpnPpz7ELqVevxpxu\nOIaSZ0JGSTTV9f7DuiHnlR5+iRjmwV8e8tyJPvkcM9rJhjv/DypQj/cIJhgW6shO\no2irvOURIaBQ7jPTSrI5Ke5I13VX4S9xutKqsWTG4dSgJv6DbYGoecDXFfhhUNrP\nSO2cF4VWgoo5bVdqo2QXm4O3bTVUMstHwRy+si8tRDhqWbRoEzUmceOApn8W3AB0\nn10TJKKqga2PyxWfz4scmhf64lDND1oLD4IjjrzLQQKBgQD5/kajw6rDxoyLFW08\nuNC3xlj4aN1AjAEm++3IpCMj97fzmd5QCmtw6p+I298SDdHyuDQrKjRg6sWa9dOt\nIb1WQATl5Lkz+qSzlpfBUzh28cYTUBcB1tRGLqXVhvzSDSPDdZztDH536fvKbp2m\npWeqrgY/MNWT7FXp5yMeBooOfQKBgQC20jQkrxBDMGrlpg72IJlbAcaMUrF1VDVT\np4L2rC3KXPIY/lcQ8FZ9rN8DFOTmSubIDLUTJpIdy8x/0Zqta4OKeOjyyJzEy7bQ\nybghG3a0h7kEEZqKuhDoFfrJZ+i4Bh+IjvJdZGJtfNUq/qxf6CJgdqdwl5RzXprr\nbrbqNxkrQQKBgQDupSAGASmozocn1oJ7LuqAJOaV7HUZwwzujByIJrgtA7Mk5sPk\noK3EExXMbihacbrz+4hBlH5/7l5I+VbitYyrI14Jn/h0eFZ14dJoiOskENVHZnMw\nHEZz4OAKIFyEoGp9km8Fk6G/Eyx8KHByvv9hXdM0y4d3OGsjaLSLWy67eQKBgQCB\n0PFFuymJDDBbsXaePremb7RUn8Ny1MCpDiFolwpMz4L5TGD2njJMOxyAS63d+QG2\nu484cgL/NV+Yw3VZ/yYAhaqj+t+WvjCqQRKGL8Iyns05nmZma4jlw/W4XhhZ079A\ncICY4Fcj96hGR2CPGX6PkLGEuZ2n7l2DH7KyzT0KAQKBgQCAuHLa1wJWkOwTg/GI\nMSgcLjv8madNByb+CElR4Tm95NXP/SwTdxZrAkTA78UjaKcFaaudRZ3jMPqblVXe\nNDvjQ+bJyyChM1hz+3/S9BtcL0yK2rV2Dg5Yz87xDnGKN/TE3kqtc00SmFjOwvJz\nG6krIxJV24SjAmws+dUFUcmhog==\n-----END PRIVATE KEY-----\n",
    "client_email": "scottycon-check-in@scottycon-check-in.iam.gserviceaccount.com",
    "client_id": "116041226306751530949",
    "auth_uri": "https://accounts.google.com/o/oauth2/auth",
    "token_uri": "https://oauth2.googleapis.com/token",
    "auth_provider_x509_cert_url": "https://www.googleapis.com/oauth2/v1/certs",
    "client_x509_cert_url": "https://www.googleapis.com/robot/v1/metadata/x509/scottycon-check-in%40scottycon-check-in.iam.gserviceaccount.com"
  }
  ''';

  // Set up GSheets object
  static const _spreadsheetId = '1XuWRWuJHHjWy4iVQv0WPOF9yg-Njs9FJGyPlmx0qAy8';
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

  static Future<int> getRowCount() async {
    if (_worksheet == null) return 0;

    final lastRow = await _worksheet!.values.lastRow();
    return lastRow == null ? 0 : int.tryParse(lastRow.first) ?? 0;
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
}
