import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:scottycon_check_in/main.dart';
import 'package:scottycon_check_in/user.dart';
import 'package:scottycon_check_in/user_form_widget.dart';

import "gsheets_api.dart";

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  User? user;
  String name = "Name";
  int? id;

  @override
  void initState() {
    super.initState();
  }

  void getUsers() async {
    final user = await GoogleSheetsApi.getById(this.id!);
    print(user!.toJson());

    setState(() {
      this.user = user;
      this.name = user.name;
    });
  }

  @override
  Widget build(BuildContext context) {
    var appState = context.watch<AppState>();

    var theme = Theme.of(context);
    var style = theme.textTheme.displayMedium!
        .copyWith(color: theme.colorScheme.onPrimary);

    return Scaffold(
      body: Container(
        color: theme.colorScheme.primaryContainer,
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Card(
                  color: theme.colorScheme.primary,
                  elevation: 10.0,
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Text(
                      this.name,
                      style: style,
                    ),
                  )),
              SingleChildScrollView(
                child: UserFormWidget(
                  user: user,
                  onSavedUser: (id) async {
                    if (id != null) {
                      this.id = id;
                      getUsers();
                    } else {
                      print("error");
                    }
                  },
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Future insertUsers() async {
    const userInfo = User(id: 1, name: "Chris", detail: "Stuff", isTrue: true);

    await GoogleSheetsApi.insert([userInfo.toJson()]);
  }
}
