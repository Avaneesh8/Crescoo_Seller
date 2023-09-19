import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:crescoo_seller/screens/SplashScreen.dart';
import 'package:firebase_auth/firebase_auth.dart';
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
  TextEditingController _shopNameController = TextEditingController();
  TextEditingController _ownerNameController = TextEditingController();
  TextEditingController _addressController = TextEditingController();
  TextEditingController _phoneNumberController = TextEditingController();
  String _selectedCity = "Mumbai"; // Default city selection
  bool _isEditing = false; // Flag to track if editing mode is enabled

  // List of cities for the dropdown menu
  final List<String> cities = [
    "Mumbai",
    "Delhi",
    "Bangalore",
    "Hyderabad",
    "Chennai",
    "Kolkata",
    "Pune",
  ];

  @override
  void initState() {
    super.initState();
    final ap = Provider.of<AuthProvider>(context, listen: false);
    // Initialize the controllers with user data
    _shopNameController.text = ap.userModel.shopname;
    _ownerNameController.text = ap.userModel.ownername;
    _addressController.text = ap.userModel.address;
    _phoneNumberController.text = ap.userModel.phoneNumber;
    _selectedCity = ap.userModel.city;
  }

  @override
  void dispose() {
    _shopNameController.dispose();
    _ownerNameController.dispose();
    _addressController.dispose();
    _phoneNumberController.dispose();
    super.dispose();
  }

  void _toggleEdit() {
    setState(() {
      _isEditing = !_isEditing;
    });
  }

  Future<void> _saveChanges() async {
    final ap = Provider.of<AuthProvider>(context, listen: false);
    final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
    // Get the edited values from controllers
    String editedShopName = _shopNameController.text;
    String editedOwnerName = _ownerNameController.text;
    String editedAddress = _addressController.text;
    String editedPhoneNumber = _phoneNumberController.text;

    // Update the userModel with the edited values
    ap.userModel.shopname = editedShopName;
    ap.userModel.ownername = editedOwnerName;
    ap.userModel.address = editedAddress;
    ap.userModel.phoneNumber = editedPhoneNumber;
    ap.userModel.city = _selectedCity;

    try {
      // Update the user data in Firestore
      await FirebaseFirestore.instance
          .collection('sellers') // Change to your Firestore collection name
          .doc(_firebaseAuth.currentUser!
              .uid) // Assuming userId uniquely identifies the user document
          .update({
        'shop name': editedShopName,
        'owner name': editedOwnerName,
        'address': editedAddress,
        'phoneNumber': editedPhoneNumber,
        'city': _selectedCity,
      });

      // Exit edit mode
      _toggleEdit();
    } catch (e) {
      // Handle errors here, e.g., show an error message
      print('Error updating user data: $e');
    }
  }

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
                  child: const Top_part(),
                ),
                SizedBox(height: MediaQuery.of(context).size.height * .04),
                SingleChildScrollView(
                  child: Container(
                    width: MediaQuery.of(context).size.width * .85,
                    height: MediaQuery.of(context).size.height * .50,
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
                      padding: const EdgeInsets.only(left: 35,right: 35,top:10,bottom: 10),
                      child: SingleChildScrollView(
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
                                _isEditing
                                    ? IconButton(
                                        icon: Icon(Icons.save),
                                        onPressed: _saveChanges,
                                      )
                                    : IconButton(
                                        icon: Icon(Icons.edit),
                                        onPressed: _toggleEdit,
                                      ),
                              ],
                            ),
                            Container(
                              padding: EdgeInsets.symmetric(vertical: 8.0), // Add vertical padding
                              constraints: BoxConstraints(
                                maxWidth: 400.0, // Limit the maximum width
                              ),
                              child: TextFormField(
                                controller: _shopNameController,
                                readOnly: !_isEditing,
                                decoration: InputDecoration(
                                  labelText: 'Shop Name',
                                  enabledBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                      color: Color.fromRGBO(26, 50, 81, 1), // Set border color when not focused
                                    ),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                      color: Color.fromRGBO(26, 50, 81, 1), // Set border color when focused
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            Container(
                              padding: EdgeInsets.symmetric(vertical: 8.0), // Add vertical padding
                              constraints: BoxConstraints(
                                maxWidth: 400.0, // Limit the maximum width
                              ),
                              child: TextFormField(
                                controller: _ownerNameController,
                                readOnly: true, // Always read-only
                                decoration: InputDecoration(
                                  labelText: 'Owner Name',
                                  enabledBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                      color: Color.fromRGBO(26, 50, 81, 1), // Set border color when not focused
                                    ),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                      color: Color.fromRGBO(26, 50, 81, 1), // Set border color when focused
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            Container(
                              padding: EdgeInsets.symmetric(vertical: 8.0), // Add vertical padding
                              constraints: BoxConstraints(
                                maxWidth: 400.0, // Limit the maximum width
                              ),
                              child: TextFormField(
                                controller: _addressController,
                                readOnly: !_isEditing,
                                decoration: InputDecoration(
                                  labelText: 'Address',
                                  enabledBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                      color: Color.fromRGBO(26, 50, 81, 1), // Set border color when not focused
                                    ),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                      color: Color.fromRGBO(26, 50, 81, 1), // Set border color when focused
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            _isEditing
                                ? Container(
                              padding: EdgeInsets.symmetric(vertical: 8.0),
                              constraints: BoxConstraints(
                                maxWidth: 400.0,
                              ),
                              child: DropdownButtonFormField<String>(
                                value: _selectedCity,
                                items: cities.map((city) {
                                  return DropdownMenuItem<String>(
                                    value: city,
                                    child: Text(city),
                                  );
                                }).toList(),
                                onChanged: (value) {
                                  setState(() {
                                    _selectedCity = value!;
                                  });
                                },
                                decoration: InputDecoration(
                                  labelText: 'City',
                                  labelStyle: TextStyle(
                                    color: Color.fromRGBO(26, 50, 81, 1),
                                  ),
                                  enabledBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                      color: Color.fromRGBO(26, 50, 81, 1),
                                    ),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                      color: Color.fromRGBO(26, 50, 81, 1),
                                    ),
                                  ),
                                ),
                              ),
                            )
                                : Container(
                              padding: EdgeInsets.symmetric(vertical: 8.0),
                              constraints: BoxConstraints(
                                maxWidth: 400.0,
                              ),
                              child: TextFormField(
                                controller: TextEditingController(text: _selectedCity),
                                readOnly: true,
                                decoration: InputDecoration(
                                  labelText: 'City',
                                  labelStyle: TextStyle(
                                    color: Color.fromRGBO(26, 50, 81, 1),
                                  ),
                                  enabledBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                      color: Color.fromRGBO(26, 50, 81, 1),
                                    ),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                      color: Color.fromRGBO(26, 50, 81, 1),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            Container(
                              padding: EdgeInsets.symmetric(vertical: 8.0), // Add vertical padding
                              constraints: BoxConstraints(
                                maxWidth: 400.0, // Limit the maximum width
                              ),
                              child: TextFormField(
                                controller: _phoneNumberController,
                                readOnly: true,
                                decoration: InputDecoration(
                                  labelText: 'Phone Number',
                                  enabledBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                      color: Color.fromRGBO(26, 50, 81, 1), // Set border color when not focused
                                    ),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                      color: Color.fromRGBO(26, 50, 81, 1), // Set border color when focused
                                    ),
                                  ),
                                ),
                              ),
                            ),

                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                (.02 * MediaQuery.of(context).size.height).heightBox,
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
                        borderRadius: BorderRadius.all(Radius.circular(25)),
                      ),
                      constraints: BoxConstraints(
                        minWidth: 200,
                        maxWidth: .5 * MediaQuery.of(context).size.width,
                      ),
                      height: 50,
                      child: Center(
                        child: Text(
                          'Log Out',
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
