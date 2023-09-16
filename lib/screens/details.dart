import 'package:crescoo_seller/widgets/NavBar.dart';
import 'package:crescoo_seller/widgets/Top_part.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../model/user_model.dart';
import '../provider/auth_provider.dart';

class Details extends StatefulWidget {
  const Details({Key? key,}) : super(key: key);

  @override
  State<Details> createState() => _DetailsState();
}

class _DetailsState extends State<Details> {
  final TextEditingController business_name = TextEditingController();
  final TextEditingController owner_name = TextEditingController();
  final TextEditingController address = TextEditingController();

  @override
  Widget build(BuildContext context) {

    business_name.selection = TextSelection.fromPosition(
      TextPosition(
        offset: business_name.text.length,
      ),
    );
    owner_name.selection = TextSelection.fromPosition(
      TextPosition(
        offset: owner_name.text.length,
      ),
    );
    address.selection = TextSelection.fromPosition(
      TextPosition(
        offset: address.text.length,
      ),
    );
    return Scaffold(
      body: Container(
        color: Colors.white,
        child: ListView(children: [
          Column(
            children: [
              SizedBox(
                  width: MediaQuery.of(context).size.width,
                  height: .200 * MediaQuery.of(context).size.height,
                  child: const Top_part()),
              SizedBox(
                width: .25 * MediaQuery.of(context).size.width,
                height: .1 * MediaQuery.of(context).size.height,
                child: const FittedBox(
                  fit: BoxFit.scaleDown,
                  child: Text(
                    'Details',
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
                const EdgeInsets.symmetric(vertical: 20, horizontal: 35),
                child: TextFormField(
                  cursorColor: Colors.black,
                  controller: owner_name,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                  onChanged: (value) {
                    setState(() {
                      owner_name.text = value;
                    });
                  },
                  decoration: InputDecoration(
                    hintText: "Owner Name",
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
                const EdgeInsets.symmetric(vertical: 20, horizontal: 35),
                child: TextFormField(
                  cursorColor: Colors.black,
                  controller: address,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                  onChanged: (value) {
                    setState(() {
                      address.text = value;
                    });
                  },
                  decoration: InputDecoration(
                    hintText: "Address",
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
                const EdgeInsets.symmetric(vertical: 20, horizontal: 35),
                child: TextFormField(
                  cursorColor: Colors.black,
                  controller: business_name,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                  onChanged: (value) {
                    setState(() {
                      business_name.text = value;
                    });
                  },
                  decoration: InputDecoration(
                    hintText: "Business Name",
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
                padding: const EdgeInsets.all(15.0),
                child: GestureDetector(
                  onTap: (){},//storeData(),
                  child: Container(
                    decoration: BoxDecoration(
                        color: const Color.fromRGBO(189, 189, 199, 1),
                        border: Border.all(
                          color: const Color.fromRGBO(189, 189, 199, 1),
                        ),
                        borderRadius:
                        const BorderRadius.all(Radius.circular(25))),
                    constraints: BoxConstraints(
                        minWidth: 200,
                        maxWidth: .5 * MediaQuery.of(context).size.width),
                    height: 50,
                    child: const Center(
                        child: Text(
                          "Proceed",
                          style: TextStyle(color: Colors.white, fontSize: 25),
                        )),
                  ),
                ),
              ),
            ],
          ),
        ]),
      ),
    );
  }

  void storeData() async {
    final ap = Provider.of<AuthProvider>(context, listen: false);
    UserModel userModel = UserModel(
      createdAt: "",
      phoneNumber: "",
      uid: "",
      shopname: business_name.text.trim(),
      ownername: owner_name.text.trim(),
      address: address.text.trim(),
    );
    ap.saveUserDataToFirebase(
      context: context,
      userModel: userModel,
      onSuccess: () {
        ap.saveUserDataToSP().then(
              (value) => ap.setSignIn().then(
                (value) => Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(
                  builder: (context) => const NavBar(),
                ),
                    (route) => false),
          ),
        );
      },
    );
  }
}
