import 'package:flutter/material.dart';
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
  int ticketNum = 0;
  String name = "Name";
  int? id;

  @override
  void initState() {
    super.initState();
  }

  void getUser() async {
    final user = await GoogleSheetsApi.getById(this.id!);

    if (user == null) {
      const snackBar = SnackBar(content: Text('User not found'));
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
      return;
    }

    setState(() {
      this.user = user;
      this.ticketNum = user.ticketNum;
      name = "${user.firstName} ${user.lastName}";
    });
  }

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    var style = theme.textTheme.headlineLarge!
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
                      name,
                      style: style,
                    ),
                  )),
              SingleChildScrollView(
                child: UserFormWidget(
                    user: user,
                    onSavedUser: (id) async {
                      print("Tests");
                      if (id != null) {
                        this.id = id;
                        getUser();
                      } else {
                        Navigator.pop(context, "User not found");
                      }
                    },
                    onCheckIn: (checkin) async {
                      if (id != null) {
                        this.id = id;
                        getUser();
                      }
                      if (user != null) {
                        GoogleSheetsApi.setCheckIn(user!, checkin ? "true" : "false");
                        getUser();
                      }
                    }),
              )
            ],
          ),
        ),
      ),
    );
  }
}
