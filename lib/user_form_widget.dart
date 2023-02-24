import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:scottycon_check_in/gsheets_api.dart';
import 'package:scottycon_check_in/user.dart';

class UserFormWidget extends StatefulWidget {
  final User? user;
  final ValueChanged<int?> onSavedUser;

  const UserFormWidget({super.key, required this.onSavedUser, this.user});

  @override
  State<UserFormWidget> createState() => _UserFormWidgetState();
}

class _UserFormWidgetState extends State<UserFormWidget> {
  final formKey = GlobalKey<FormState>();
  late TextEditingController controllerId;
  late TextEditingController controllerName;
  late TextEditingController controllerDetail;
  late bool isTrue;
  User? user;
  late int? id;

  @override
  void initState() {
    super.initState();

    initUser();
  }

  void initUser() {
    final id = widget.user == null ? '' : widget.user!.id.toString();
    final name = widget.user == null ? '' : widget.user!.firstName;
    final detail = widget.user == null ? '' : widget.user!.isStudent;
    final isTrue = widget.user == null ? true : widget.user!.giftCard;

    setState(() {
      controllerId = TextEditingController(text: id);
      controllerName = TextEditingController(text: name);
      controllerDetail = TextEditingController(text: detail);
      this.isTrue = isTrue;
    });
  }

  @override
  void didUpdateWidget(covariant UserFormWidget oldWidget) {
    super.didUpdateWidget(oldWidget);

    initUser();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: formKey,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          buildId(),
          SizedBox(height: 16),
          buildName(),
          SizedBox(height: 16),
          buildDetails(),
          SizedBox(height: 16),
          buildIsTrue(),
          SizedBox(height: 16),
          ElevatedButton(
              onPressed: () {
                final form = formKey.currentState!;
                id = int.tryParse(controllerId.text);
                final isValid = form.validate();

                if (isValid) {
                  widget.onSavedUser(id);
                }
              },
              child: Text("Search"))
        ],
      ),
    );
  }

  Widget buildId() => TextFormField(
        controller: controllerId,
        decoration: const InputDecoration(
          labelText: "Id",
          border: OutlineInputBorder(),
        ),
        validator: (value) =>
            value != null && value.isEmpty ? 'Enter ID' : null,
      );

  Widget buildName() => Text(controllerName.text);

  Widget buildDetails() => Text(controllerDetail.text);

  Widget buildIsTrue() => Text(isTrue.toString());
}
