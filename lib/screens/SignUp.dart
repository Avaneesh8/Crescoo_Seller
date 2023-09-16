import 'package:crescoo_seller/widgets/top_part_white.dart';
import 'package:flutter/material.dart';

import '../widgets/Top_part.dart';
import 'Details.dart';

class SignUp extends StatefulWidget {
  const SignUp({Key? key}) : super(key: key);

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  final TextEditingController name = TextEditingController();
  final TextEditingController age = TextEditingController();
  String gender = 'Male';

  @override
  Widget build(BuildContext context) {
    name.selection = TextSelection.fromPosition(
      TextPosition(
        offset: name.text.length,
      ),
    );
    age.selection = TextSelection.fromPosition(
      TextPosition(
        offset: age.text.length,
      ),
    );

    return Scaffold(
      body: Container(
        color: Colors.white,
        child: ListView(
          children: [
            Column(
              children: [
                SizedBox(
                    width: MediaQuery.of(context).size.width,
                    height: .200 * MediaQuery.of(context).size.height,
                    child: const Top_part()),
                SizedBox(
                  width: .25 * MediaQuery.of(context).size.width,
                  height: .1 * MediaQuery.of(context).size.height,
                  child: FittedBox(
                    fit: BoxFit.scaleDown,
                    child: Text(
                      'SignUp',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 35,
                        fontFamily: 'Poppins',
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding:
                  const EdgeInsets.symmetric(vertical: 25, horizontal: 35),
                  child: TextFormField(
                    cursorColor: Colors.black,
                    controller: name,
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                    onChanged: (value) {
                      setState(() {
                        name.text = value;
                      });
                    },
                    decoration: InputDecoration(
                      hintText: "Name",
                      hintStyle: TextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: 15,
                        color: Colors.grey.shade600,
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: const BorderSide(color: Colors.black12),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: const BorderSide(color: Colors.black12),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding:
                  const EdgeInsets.symmetric(vertical: 25, horizontal: 35),
                  child: TextFormField(
                    cursorColor: Colors.black,
                    controller: age,
                    keyboardType: TextInputType.number,
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                    onChanged: (value) {
                      setState(() {
                        age.text = value;
                      });
                    },
                    decoration: InputDecoration(
                      hintText: "Age",
                      hintStyle: TextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: 15,
                        color: Colors.grey.shade600,
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: const BorderSide(color: Colors.black12),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: const BorderSide(color: Colors.black12),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding:
                  const EdgeInsets.symmetric(vertical: 25, horizontal: 35),
                  child: DropdownButtonFormField<String>(
                    decoration: InputDecoration(
                      hintText: "Gender",
                      hintStyle: TextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: 15,
                        color: Colors.grey.shade100,
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: const BorderSide(color: Colors.black12),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: const BorderSide(color: Colors.black12),
                      ),
                    ),
                    value: gender,
                    onChanged: (String? newValue) {
                      setState(() {
                        gender = newValue ?? 'Male';
                      });
                    },
                    items: <String>['Male', 'Female', 'Other']
                        .map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: GestureDetector(
                    onTap: () {},
                    child: Container(
                      decoration: BoxDecoration(
                        color: Color.fromRGBO(189, 189, 199, 1),
                        border: Border.all(
                          color: Color.fromRGBO(189, 189, 199, 1),
                        ),
                        borderRadius: BorderRadius.all(Radius.circular(25)),
                      ),
                      constraints: BoxConstraints(
                          minWidth: 200,
                          maxWidth: .5 * MediaQuery.of(context).size.width),
                      height: 50,
                      child: Center(
                        child: Text(
                          "Proceed",
                          style: TextStyle(color: Colors.white, fontSize: 25),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

}
