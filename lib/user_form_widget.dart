import 'package:flutter/material.dart';
import 'package:scottycon_check_in/gsheets_api.dart';
import 'package:scottycon_check_in/user.dart';

class UserFormWidget extends StatefulWidget {
  final User? user;
  final ValueChanged<User> onSavedUser;

  const UserFormWidget({super.key, required this.onSavedUser, this.user});

  @override
  State<UserFormWidget> createState() => _UserFormWidgetState();
}

class _UserFormWidgetState extends State<UserFormWidget> {
  final formKey = GlobalKey<FormState>();
  late TextEditingController controllerName;
  late TextEditingController controllerDetail;
  late bool isTrue;
  User? user;

  @override
  void initState() {
    super.initState();

    initUser();
  }

  void initUser() {
    final name = widget.user == null ? '' : widget.user!.name;
    final detail = widget.user == null ? '' : widget.user!.detail;
    final isTrue = widget.user == null ? '' : widget.user!.isTrue;

    setState(() {
      controllerName = TextEditingController(text: name);
      controllerDetail = TextEditingController(text: detail);
      this.isTrue = true;
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
          buildName(),
          SizedBox(height: 16),
          buildDetails(),
          SizedBox(height: 16),
          buildIsTrue(),
          SizedBox(height: 16),
          ElevatedButton(
              onPressed: () {
                final form = formKey.currentState!;
                final isValid = form.validate();

                if (isValid) {
                  final user = User(
                      name: controllerName.text,
                      detail: controllerDetail.text,
                      isTrue: isTrue);
                  widget.onSavedUser(user);
                }
              },
              child: Text("Save"))
        ],
      ),
    );
  }

  Widget buildName() => TextFormField(
        controller: controllerName,
        decoration: const InputDecoration(
          labelText: 'Name',
          border: OutlineInputBorder(),
        ),
        validator: (value) =>
            value != null && value.isEmpty ? 'Enter Name' : null,
      );

  Widget buildDetails() => TextFormField(
        controller: controllerDetail,
        decoration: const InputDecoration(
          labelText: 'Details',
          border: OutlineInputBorder(),
        ),
        validator: (value) =>
            value != null && value.isEmpty ? 'Enter Details' : null,
      );

  Widget buildIsTrue() => SwitchListTile(
        value: isTrue,
        title: const Text("Is True?"),
        onChanged: (value) => setState(() => isTrue = value),
      );
}
