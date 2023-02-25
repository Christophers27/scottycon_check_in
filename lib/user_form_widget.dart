import 'package:flutter/material.dart';
import 'package:scottycon_check_in/gsheets_api.dart';
import 'package:scottycon_check_in/user.dart';

class UserFormWidget extends StatefulWidget {
  final User? user;
  final ValueChanged<int?> onSavedUser;
  final ValueChanged<bool> onCheckIn;

  const UserFormWidget(
      {super.key,
      required this.onSavedUser,
      this.user,
      required this.onCheckIn});

  @override
  State<UserFormWidget> createState() => _UserFormWidgetState();
}

class _UserFormWidgetState extends State<UserFormWidget> {
  final formKey = GlobalKey<FormState>();
  late TextEditingController controllerId;
  late TextEditingController controllerFirstName;
  late TextEditingController controllerLastName;
  late bool isStudent;
  late bool giftCard;
  User? user;
  late int? id;

  @override
  void initState() {
    super.initState();

    initUser();
  }

  void initUser() {
    final id = widget.user == null ? '' : widget.user!.id.toString();
    final firstName = widget.user == null ? '' : widget.user!.firstName;
    final lastName = widget.user == null ? '' : widget.user!.lastName;
    final isStudent = widget.user == null ? false : widget.user!.isStudent;
    final giftCard = widget.user == null ? false : widget.user!.giftCard;

    setState(() {
      controllerId = TextEditingController(text: id);
      controllerFirstName = TextEditingController(text: firstName);
      controllerLastName = TextEditingController(text: lastName);
      this.giftCard = giftCard;
      this.isStudent = isStudent;
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
          buildFirstName(),
          SizedBox(height: 8),
          buildLastName(),
          SizedBox(height: 16),
          buildGiftCard(),
          SizedBox(height: 16),
          buildIsStudent(),
          SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(
                  onPressed: () {
                    final form = formKey.currentState!;
                    id = int.tryParse(controllerId.text);
                    final isValid = form.validate();

                    if (isValid) {
                      widget.onSavedUser(id);
                    }
                  },
                  child: Text("Search")),
              SizedBox(width: 16),
              ElevatedButton(
                  onPressed: () {
                    final form = formKey.currentState!;
                    final isValid = form.validate();

                    if (isValid) {
                      widget.onCheckIn(true);
                    }
                  },
                  child: Text("Check in this user"))
            ],
          )
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

  Widget buildFirstName() => Card(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text("First Name: ${controllerFirstName.text}"),
        ),
      );

  Widget buildLastName() => Card(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text("Last Name: ${controllerLastName.text}"),
        ),
      );

  Widget buildIsStudent() => Text("Is Student? : ${isStudent.toString()}");

  Widget buildGiftCard() => Text("Gift Card? : ${giftCard.toString()}");
}
