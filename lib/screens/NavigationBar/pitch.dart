import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';
import 'package:velocity_x/velocity_x.dart';

import '../../provider/auth_provider.dart';
import '../../widgets/NavBar.dart';
import '../../widgets/Top_part.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Pitch(),
    );
  }
}

class Pitch extends StatefulWidget {
  const Pitch({Key? key}) : super(key: key);

  @override
  State<Pitch> createState() => _PitchState();
}

class _PitchState extends State<Pitch> {
  final FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;

  final TextEditingController businessname = TextEditingController();
  final TextEditingController businessidea = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  int currentCharacterCount = 0;
  final int maxCharacterCount = 1000;

  void _showErrorDialog(String message) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(
          'Error',
          style: TextStyle(
            color: Color.fromRGBO(26, 50, 81, 1),
          ),
        ),
        content: Text(
          message,
          style: TextStyle(color: Colors.black),
        ),
        backgroundColor: Colors.white,
        actions: <Widget>[
          ElevatedButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            style: ElevatedButton.styleFrom(
              primary: Color.fromRGBO(26, 50, 81, 1),
            ),
            child: Text(
              'OK',
              style: TextStyle(color: Colors.white),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final ap = Provider.of<AuthProvider>(context, listen: false);

    void PitchIdea() async {
      if (_formKey.currentState!.validate()) {
        if (currentCharacterCount > maxCharacterCount) {
          // Show character limit error dialog
          _showErrorDialog(
              'Character limit exceeded ($currentCharacterCount / $maxCharacterCount)');
          return;
        }

        // Save the data to Firestore
        await _firebaseFirestore.collection("Pitch").add({
          "Business Name": businessname.text.trim(),
          "Business Idea": businessidea.text.trim(),
          "Phone Number": ap.userModel.phoneNumber,
          "addreass": ap.userModel.address,
        });

        // Show a toast message
        Fluttertoast.showToast(
          msg: "Idea Pitched",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: Color.fromRGBO(26, 50, 81, 1),
          textColor: Colors.white,
          fontSize: 16.0,
        );

        // Clear the text fields and reset the form
        businessname.clear();
        businessidea.clear();
        setState(() {
          currentCharacterCount = 0;
        });

        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => const NavBar(
              index: 2,
            ),
          ),
        );
      } else {
        // Show validation error dialog
        _showErrorDialog('Please fill in all fields.');
      }
    }

    businessname.selection = TextSelection.fromPosition(
      TextPosition(
        offset: businessname.text.length,
      ),
    );
    businessidea.selection = TextSelection.fromPosition(
      TextPosition(
        offset: businessidea.text.length,
      ),
    );

    return Scaffold(
      // Set resizeToAvoidBottomInset to false to avoid automatically resizing
      // when the keyboard is opened.
      resizeToAvoidBottomInset: false,
      body: ListView(
        keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
        children: [
          Container(
            color: Colors.white,
            height: MediaQuery.of(context).size.height,
            child: Column(
              children: [
                SizedBox(
                  width: MediaQuery.of(context).size.width,
                  height: .200 * MediaQuery.of(context).size.height,
                  child: Top_part(),
                ),
                25.heightBox,
                Text(
                  "Pitch for Investment",
                  style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                ),
                25.heightBox,
                Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      Container(
                        width: .8 * MediaQuery.of(context).size.width,
                        height: 70,
                        decoration: ShapeDecoration(
                            color: Color(0xFFF3F3F2),
                            shape: RoundedRectangleBorder(
                              side: BorderSide(width: 1),
                              borderRadius: BorderRadius.circular(12),
                            ),
                            shadows: [
                              BoxShadow(
                                color: Color(0x3F000000),
                                blurRadius: 4,
                                offset: Offset(4, 4),
                                spreadRadius: 0,
                              )
                            ]),
                        child: TextFormField(
                          cursorColor: Colors.black,
                          controller: businessname,
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                          onChanged: (value) {
                            setState(() {
                              businessname.text = value;
                            });
                          },
                          decoration: InputDecoration(
                            hintText: "Business Name",
                            hintStyle: const TextStyle(
                              fontWeight: FontWeight.w500,
                              fontSize: 15,
                              fontFamily: 'Poppins',
                            ),
                            border: InputBorder.none,
                          ),
                          validator: (value) {
                            if (value!.isEmpty) {
                              return '';
                            }
                            // You can add more constraints here if needed
                            return null;
                          },
                          onEditingComplete: () {
                            FocusScope.of(context).nextFocus();
                          },
                        ),
                      ),
                      25.heightBox,
                      Container(
                        width: .8 * MediaQuery.of(context).size.width,
                        height: 200,
                        decoration: ShapeDecoration(
                          color: Color(0xFFF3F3F2),
                          shape: RoundedRectangleBorder(
                            side: BorderSide(width: 1),
                            borderRadius: BorderRadius.circular(12),
                          ),
                            shadows: [
                              BoxShadow(
                                color: Color(0x3F000000),
                                blurRadius: 4,
                                offset: Offset(4, 4),
                                spreadRadius: 0,
                              )
                            ]
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Expanded(
                              child: TextFormField(
                                cursorColor: Colors.black,
                                controller: businessidea,
                                textAlign: TextAlign.center,
                                style: const TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                ),
                                onChanged: (value) {
                                  setState(() {
                                    businessidea.text = value;
                                    currentCharacterCount = value.length;
                                  });
                                },
                                maxLines: 7,
                                decoration: InputDecoration(
                                  hintText:
                                      "Add a description about your business",
                                  hintStyle: const TextStyle(
                                    fontWeight: FontWeight.w500,
                                    fontSize: 15,
                                    fontFamily: 'Poppins',
                                  ),
                                  border: InputBorder.none,
                                ),
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return '';
                                  }
                                  return null;
                                },
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                'Characters Used: $currentCharacterCount / $maxCharacterCount',
                                style: TextStyle(
                                  color: Colors.grey,
                                  fontSize: 12,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(15.0),
                        child: InkWell(
                          onTap: () => PitchIdea(),
                          child: Container(
                            decoration: BoxDecoration(
                              color: Color.fromRGBO(26, 50, 81, 1),
                              border: Border.all(
                                color: Color.fromRGBO(26, 50, 81, 1),
                              ),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(25)),
                            ),
                            constraints: BoxConstraints(
                              minWidth: 200,
                              maxWidth: .5 * MediaQuery.of(context).size.width,
                            ),
                            height: 50,
                            child: Center(
                              child: Text(
                                "Pitch",
                                style: TextStyle(
                                    color: Colors.white, fontSize: 25),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
