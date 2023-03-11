import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:scottycon_check_in/user.dart';
import 'package:barcode_scan2/barcode_scan2.dart';

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
          buildGiftCard(),
          const SizedBox(height: 16),
          buildIsStudent(),
          const SizedBox(height: 16),
          
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(
                onPressed: scan, 
                child: const Text("Scan")
              ),

              const SizedBox(width: 16),

              ElevatedButton(
                  onPressed: () {
                    final form = formKey.currentState!;
                    id = int.tryParse(controllerId.text);
                    final isValid = form.validate();

                    if (isValid) {
                      widget.onSavedUser(id);
                    }
                  },
                  child: const Text("Search")),

              const SizedBox(width: 16),

              ElevatedButton(
                  onPressed: () {
                    final form = formKey.currentState!;
                    final isValid = form.validate();

                    if (isValid) {
                      widget.onCheckIn(true);
                    }
                  },
                  child: const Text("Check In"))
            ],
          )
        ],
      ),
    );
  }

  Future scan() async {
    try {
      var res = await BarcodeScanner.scan();
      setState(() {
        controllerId.text = res.rawContent;
      });
    } on PlatformException catch (e) {
      if (e.code == BarcodeScanner.cameraAccessDenied) {
        setState(() {
          controllerId.text = 'The user did not grant the camera permission!';
        });
      } else {
        setState(() => controllerId.text = 'Unknown error: $e');
      }
    } on FormatException {
      setState(() => controllerId.text =
          'null (User returned using the "back"-button before scanning anything. Result)');
    } catch (e) {
      setState(() => controllerId.text = 'Unknown error: $e');
    }
  }

  Widget buildId() => Padding(
    padding: const EdgeInsets.all(16.0),
    child: TextFormField(
          controller: controllerId,
          decoration: const InputDecoration(
            labelText: "Id",
            border: OutlineInputBorder(),
          ),
          validator: (value) =>
              value != null && value.isEmpty ? 'Enter ID' : null,
        ),
  );

  Widget buildIsStudent() => Card(
    child: Padding(
      padding: const EdgeInsets.all(8.0),
      child: Text(isStudent ? "Student" : "Not Student"),
    )
  );

  Widget buildGiftCard() => Card(
    child: Padding(
      padding: const EdgeInsets.all(8.0),
      child: Text(giftCard ? "Has Gift Card" : "No Gift Card"),
    ),
  );
}
