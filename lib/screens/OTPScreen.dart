import 'package:crescoo_seller/screens/Details.dart';
import 'package:crescoo_seller/screens/SignUp.dart';
import 'package:crescoo_seller/widgets/NavBar.dart';
import 'package:flutter/material.dart';
import 'package:pinput/pinput.dart';
import 'package:provider/provider.dart';
import '../provider/auth_provider.dart';
import '../widgets/SnackBar.dart';
import '../widgets/Top_part.dart';

class OTPScreen extends StatefulWidget {

  final String verificationId;
  final String number;
  const OTPScreen({super.key, required this.verificationId,required this.number});

  @override
  State<OTPScreen> createState() => _OTPScreenState();
}

class _OTPScreenState extends State<OTPScreen> {
  String? otpCode;

  @override
  Widget build(BuildContext context) {
    final isLoading =
        Provider.of<AuthProvider>(context, listen: true).isLoading;

    return Scaffold(
        body: SafeArea(
          child: isLoading == true
              ? const Center(
            child: CircularProgressIndicator(
              color: Color(0xFFA18030),
            ),
          )
              : Container(
            color: Colors.white,
            child: ListView(
                children:[ Container(
                  height: MediaQuery.of(context).size.height,
                  //color: Colors.white,
                  child: Center(
                    child: Column(
                      children: [
                        SizedBox(
                            width: MediaQuery.of(context).size.width,
                            height: .200 * MediaQuery.of(context).size.height,
                            child: const Top_part()),
                        SizedBox(height: MediaQuery.of(context).size.height*.13),
                        const Padding(
                          padding:
                          EdgeInsets.only(left: 35),
                          child: Text(
                            'Enter the OTP',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 30,
                              fontFamily: 'Poppins',
                              fontWeight: FontWeight.w500,
                              height: 1.63,
                            ),
                          ),
                        ),
                        SizedBox(height: MediaQuery.of(context).size.height*.05),
                        Pinput(
                          length: 6,
                          showCursor: true,
                          defaultPinTheme: PinTheme(
                            width: 60,
                            height: 60,
                            decoration: BoxDecoration(

                              color: Colors.white,
                              borderRadius: BorderRadius.circular(20),
                              border: Border.all(
                                  color: Color(0xFFCAC6C6)
                              ),
                            ),
                            textStyle: const TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          onCompleted: (value) {
                            setState(() {
                              otpCode = value;
                            });
                          },
                        ),
                        SizedBox(height: MediaQuery.of(context).size.height*.05),
                        Padding(
                          padding: const EdgeInsets.all(15.0),
                          child: GestureDetector(
                            onTap: () {
                              if (otpCode != null) {
                                verifyOtp(context, otpCode!);
                              } else {
                                showSnackBar(context, "Enter 6-Digit code");
                              }
                            },
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
                                    "Proceed",
                                    style: TextStyle(color: Colors.white, fontSize: 25,fontWeight: FontWeight.w400,),
                                  )),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                ]),
          ),
        ));
  }
  void verifyOtp(BuildContext context, String userOtp) {
    final ap = Provider.of<AuthProvider>(context, listen: false);
    ap.verifyOtp(
      context: context,
      verificationId: widget.verificationId,
      userOtp: userOtp,
      onSuccess: () {
        // checking whether user exists in the db
        ap.checkExistingUser().then(
              (value) async {
            if (value == true) {
              // user exists in our app
              ap.getDataFromFirestore().then(
                    (value) => ap.saveUserDataToSP().then(
                      (value) => ap.setSignIn().then(
                        (value) => Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(
                          builder: (context) => NavBar(index: 0,),
                        ),
                            (route) => false),
                  ),
                ),
              );
            } else {
              // new user
              Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(builder: (context) => const Details()),
                      (route) => false);
            }
          },
        );
      },
    );
  }
  void sendPhoneNumber() {
    final ap = Provider.of<AuthProvider>(context, listen: false);
    ap.signInWithPhone(context, widget.number);
  }
}

