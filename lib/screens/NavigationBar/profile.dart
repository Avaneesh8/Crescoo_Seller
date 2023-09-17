import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:crescoo_seller/screens/SplashScreen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:velocity_x/velocity_x.dart';

import '../../provider/auth_provider.dart';
import '../../widgets/Top_part.dart';

class Profile extends StatefulWidget {
  const Profile({Key? key}) : super(key: key);

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {

  @override
  Widget build(BuildContext context) {
    final ap = Provider.of<AuthProvider>(context, listen: false);
    return Scaffold(
      body: Container(
        height: MediaQuery.of(context).size.height,
        color: Colors.white,
        child: ListView(
          children: [
            Column(
              children: [
                SizedBox(
                    width: MediaQuery.of(context).size.width,
                    height: .200 * MediaQuery.of(context).size.height,
                    child: const Top_part()),
                SizedBox(height: MediaQuery.of(context).size.height * .08),
                Container(
                  width: MediaQuery.of(context).size.width * .85,
                  height: MediaQuery.of(context).size.height * .40,
                  decoration: ShapeDecoration(
                    color: Color(0xFFE0DEDE),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(25),
                    ),
                    shadows: [
                      BoxShadow(
                        color: Color(0x3F000000),
                        blurRadius: 4,
                        offset: Offset(10, 10),
                        spreadRadius: 0,
                      )
                    ],
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(35.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "Seller",
                              style: TextStyle(
                                fontSize: 35,
                                fontFamily: 'Poppins',
                              ),
                            ),
                            Icon(Icons.edit),
                          ],
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 20),
                          child: Text(
                            ap.userModel.shopname,
                            style: TextStyle(fontSize: 20),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 20),
                          child: Text(
                            ap.userModel.ownername,
                            style: TextStyle(fontSize: 20),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 20),
                          child: Text(
                            ap.userModel.address,
                            style: TextStyle(fontSize: 20),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 20),
                          child: Text(
                            ap.userModel.phoneNumber,
                            style: TextStyle(fontSize: 20),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                (.02*MediaQuery.of(context).size.height).heightBox,
                Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: InkWell(
                    onTap: () {
                      ap.userSignOut().then(
                            (value) => Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const SplashScreen(),
                          ),
                              (Route<dynamic> route) => false,
                        ),
                      );
                    },
                    child: Container(
                      decoration: BoxDecoration(
                          color: Color.fromRGBO(26, 50, 81, 1),
                          border: Border.all(
                            color: Color.fromRGBO(26, 50, 81, 1),
                          ),
                          borderRadius: BorderRadius.all(Radius.circular(25))),
                      constraints: BoxConstraints(
                          minWidth: 200,
                          maxWidth: .5 * MediaQuery.of(context).size.width),
                      height: 50,
                      child: Center(
                          child: Text(
                            'Log Out',
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
    );
  }
}
