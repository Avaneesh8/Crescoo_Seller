import 'package:flutter/material.dart';
import 'package:velocity_x/velocity_x.dart';

import '../../widgets/Top_part.dart';

class Pitch extends StatefulWidget {
  const Pitch({Key? key}) : super(key: key);

  @override
  State<Pitch> createState() => _PitchState();
}

class _PitchState extends State<Pitch> {
  final TextEditingController businessname = TextEditingController();
  final TextEditingController businessidea = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child : Container(
        color: Colors.white,
        height: MediaQuery.of(context).size.height,
        child: Column(
            children: [
              SizedBox(
                  width: MediaQuery.of(context).size.width,
                  height: .200 * MediaQuery.of(context).size.height,
                  child: Top_part()),
              25.heightBox,
              Text(
                "Pitch for Investment",
                style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
              ),
              25.heightBox,
              Container(
                  width: .8 * MediaQuery.of(context).size.width,
                  height: 50,
                  decoration: ShapeDecoration(
                    color: Color(0xFFF3F3F2),
                    shape: RoundedRectangleBorder(
                      side: BorderSide(width: 1),
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
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
                          //color: Color(0xFFA69E9E),
                        ),
                      )
                  )
              ),
              25.heightBox,
              Container(
                  width: .8 * MediaQuery.of(context).size.width,
                  height: 200,
                  decoration: ShapeDecoration(
                    color: Color(0xFFF3F3F2),
                    shape: RoundedRectangleBorder(
                      side: BorderSide(width: 1),
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
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
                        });
                      },
                      maxLines: 7,
                      decoration: InputDecoration(
                        hintText: "Add a description about your business",
                        hintStyle: const TextStyle(
                          fontWeight: FontWeight.w500,
                          fontSize: 15,
                          fontFamily: 'Poppins',
                          //color: Color(0xFFA69E9E),
                        ),
                      )
                  )
              ),
            ],
          ),
      ),
    );
  }
}
