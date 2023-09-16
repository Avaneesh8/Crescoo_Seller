import 'package:country_picker/country_picker.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../provider/auth_provider.dart';
import '../../widgets/Top_part.dart';

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final TextEditingController phoneController = TextEditingController();

  Country selectedCountry = Country(
    phoneCode: "91",
    countryCode: "IN",
    e164Sc: 0,
    geographic: true,
    level: 1,
    name: "India",
    example: "India",
    displayName: "India",
    displayNameNoCountryCode: "IN",
    e164Key: "",
  );
  @override
  Widget build(BuildContext context) {
    phoneController.selection = TextSelection.fromPosition(
      TextPosition(
        offset: phoneController.text.length,
      ),
    );
    return Scaffold(
      body: Container(
        color: Colors.white,
        child: ListView(
            children: [Container(
              //color: Colors.white,
              child: Column(
                children: [
                  SizedBox(
                      width: MediaQuery.of(context).size.width,
                      height: .200 * MediaQuery.of(context).size.height,
                      child: Top_part()),
                  SizedBox(
                    //Use of SizedBox
                    height: .12 * MediaQuery.of(context).size.height,
                  ),
                  SizedBox(
                    width: .25 * MediaQuery.of(context).size.width,
                    height: .075 * MediaQuery.of(context).size.height,
                    child: FittedBox(
                      fit: BoxFit.scaleDown,
                      child: Text(
                        'Login',
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 35,
                          fontFamily: 'Poppins',
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),
                  Column(
                    children: [
                      Padding(
                        padding:
                        const EdgeInsets.symmetric(vertical: 25, horizontal: 35),
                        child: TextFormField(
                          cursorColor: Colors.black,
                          controller: phoneController,
                          keyboardType: TextInputType.number,
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                          onChanged: (value) {
                            setState(() {
                              phoneController.text = value;
                            });
                          },
                          decoration: InputDecoration(
                            hintText: "Enter phone number",
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
                            prefixIcon: Container(
                              padding: const EdgeInsets.all(8.0),
                              child: InkWell(
                                onTap: () {
                                  showCountryPicker(
                                      context: context,
                                      countryListTheme: const CountryListThemeData(
                                        bottomSheetHeight: 550,
                                      ),
                                      onSelect: (value) {
                                        setState(() {
                                          selectedCountry = value;
                                        });
                                      });
                                },
                                child: Padding(
                                  padding: const EdgeInsets.all(15.0),
                                  child: Text(
                                    "${selectedCountry.flagEmoji} + ${selectedCountry.phoneCode}",
                                    style: const TextStyle(
                                      fontSize: 18,
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            suffixIcon: phoneController.text.length > 9
                                ? Container(
                              height: 30,
                              width: 30,
                              margin: const EdgeInsets.all(10.0),
                              decoration: const BoxDecoration(
                                shape: BoxShape.circle,
                                color: Colors.green,
                              ),
                              child: const Icon(
                                Icons.done,
                                color: Colors.white,
                                size: 20,
                              ),
                            )
                                : null,
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(15.0),
                        child: InkWell(
                          onTap: ()=>sendPhoneNumber(),
                          child: Container(
                            decoration: BoxDecoration(
                                color: Color.fromRGBO(189, 189, 199, 1),
                                border: Border.all(
                                  color: Color.fromRGBO(189, 189, 199, 1),
                                ),
                                borderRadius: BorderRadius.all(Radius.circular(25))),
                            constraints: BoxConstraints(
                                minWidth: 200,
                                maxWidth: .5 * MediaQuery.of(context).size.width),
                            height: 50,
                            child: Center(
                                child: Text(
                                  "Send OTP",
                                  style: TextStyle(color: Colors.white, fontSize: 25),
                                )),
                          ),
                        ),
                      ),

                    ],
                  ),
                ],
              ),
            ),
            ]),
      ),
    );
  }
  void sendPhoneNumber() {
    final ap = Provider.of<AuthProvider>(context, listen: false);
    String phoneNumber = phoneController.text.trim();
    ap.signInWithPhone(context, "+${selectedCountry.phoneCode}$phoneNumber");
  }
}
