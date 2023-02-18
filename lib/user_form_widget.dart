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
  late TextEditingController controllerId;
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
    final id = widget.user == null ? '' : widget.user!.id.toString();
    final name = widget.user == null ? '' : widget.user!.name;
    final detail = widget.user == null ? '' : widget.user!.detail;
    final isTrue = widget.user == null ? true : widget.user!.isTrue;

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
                final isValid = form.validate();

                if (isValid) {
                  final user = User(
                      id: int.tryParse(controllerId.text),
                      name: controllerName.text,
                      detail: controllerDetail.text,
                      isTrue: isTrue);
                  widget.onSavedUser(user);
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
      );

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
