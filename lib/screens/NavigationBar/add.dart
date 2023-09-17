import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';
import 'package:velocity_x/velocity_x.dart';

import '../../provider/auth_provider.dart';
import '../../widgets/Top_part.dart';
import '../SplashScreen.dart';

class Billing extends StatefulWidget {
  const Billing({Key? key}) : super(key: key);

  @override
  State<Billing> createState() => _BillingState();
}

class _BillingState extends State<Billing> {
  TextEditingController _itemNameController = TextEditingController();
  TextEditingController _stockController = TextEditingController();
  TextEditingController _priceController = TextEditingController();
  String? _selectedCategory;

  FocusNode _itemNameFocusNode = FocusNode();
  FocusNode _stockFocusNode = FocusNode();
  FocusNode _priceFocusNode = FocusNode();

  final FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;

  @override
  void dispose() {
    _itemNameController.dispose();
    _stockController.dispose();
    _priceController.dispose();
    _itemNameFocusNode.dispose();
    _stockFocusNode.dispose();
    _priceFocusNode.dispose();
    super.dispose();
  }

  void _handleAddItem() async {
    final ap = Provider.of<AuthProvider>(context, listen: false);
    String itemName = _itemNameController.text;
    String stockText = _stockController.text;
    String priceText = _priceController.text;

    if (itemName.isNotEmpty &&
        stockText.isNotEmpty &&
        priceText.isNotEmpty &&
        _selectedCategory != null) {
      int stock = int.tryParse(stockText) ?? 0;
      double price = double.tryParse(priceText) ?? 0.0;
      String productID = itemName; // Use item name as product ID

      // Check if a document with the given product ID and price exists
      QuerySnapshot existingDocs = await _firebaseFirestore
          .collection('items')
          .where('productID', isEqualTo: productID)
          .where('price', isEqualTo: price)
          .where('category', isEqualTo: _selectedCategory)
          .get();

      if (existingDocs.docs.isNotEmpty) {
        // Update the stock of the existing document
        DocumentSnapshot existingDoc = existingDocs.docs.first;
        int currentStock = existingDoc['stock'];
        int updatedStock = currentStock + stock;

        // Update the stock field of the existing document
        try {
          await _firebaseFirestore
              .collection('items')
              .doc(existingDoc.id)
              .update({'stock': updatedStock});
          // Show a success message using Fluttertoast
          Fluttertoast.showToast(
            msg: 'Stock updated successfully!',
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            backgroundColor: Color.fromRGBO(26, 50, 81, 1),
            textColor: Colors.white,
          );
          // Clear text fields
          _itemNameController.clear();
          _stockController.clear();
          _priceController.clear();
          setState(() {
            _selectedCategory = null;
          });
        } catch (e) {
          print('Error updating stock: $e');
          // Handle the error, you can show an error message if needed
        }
      } else {
        // Create a map of the data to be saved
        Map<String, dynamic> itemData = {
          'productID': productID,
          'stock': stock,
          'price': price,
          'category': _selectedCategory,
          'phoneNumber': ap.userModel.phoneNumber,
          'address': ap.userModel.address,
        };

        // Save the data to Firestore
        try {
          await _firebaseFirestore.collection('items').add(itemData);
          Fluttertoast.showToast(
            msg: 'Item added successfully!',
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            backgroundColor: Color.fromRGBO(26, 50, 81, 1),
            textColor: Colors.white,
          );
          // Processed successfully, you can show a success message if needed
          // Clear text fields
          _itemNameController.clear();
          _stockController.clear();
          _priceController.clear();
          setState(() {
            _selectedCategory = null;
          });
        } catch (e) {
          print('Error saving data: $e');
          // Handle the error, you can show an error message if needed
        }
      }
    } else {
      // Show an error message with customized colors
      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text(
              'Error',
              style: TextStyle(
                color: Color.fromRGBO(26, 50, 81, 1),
              ),
            ),
            content: Text(
              'Please fill in all fields and select a category.',
              style: TextStyle(color: Colors.black),
            ),
            backgroundColor: Colors.white,
            actions: <Widget>[
              ElevatedButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                style: ElevatedButton.styleFrom(
                  primary: Color.fromRGBO(26, 50, 81, 1), // Set button color
                ),
                child: Text(
                  'OK',
                  style: TextStyle(color: Colors.white), // Set button text color
                ),
              ),
            ],
          );
        },
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              width: MediaQuery.of(context).size.width,
              height: .200 * MediaQuery.of(context).size.height,
              child: Top_part(),
            ),
            (.02 * MediaQuery.of(context).size.height).heightBox,
            Padding(
              padding: const EdgeInsets.only(left: 40, right: 40, top: 20),
              child: Text(
                "Inventory Management",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
            ),
            (.03 * MediaQuery.of(context).size.height).heightBox,
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
                padding: const EdgeInsets.all(20.0),
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        padding: EdgeInsets.symmetric(vertical: 8.0), // Add vertical padding
                        constraints: BoxConstraints(
                          maxWidth: 400.0, // Limit the maximum width
                        ),
                        child: TextFormField(
                          controller: _itemNameController,
                          decoration: InputDecoration(
                            hintText: 'Item Name',
                            labelText: 'Item Name',
                            labelStyle: TextStyle(
                              color: Color.fromRGBO(26, 50, 81, 1), // Set the color of the label text
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Color.fromRGBO(26, 50, 81, 1)), // Set border color when focused
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Color.fromRGBO(26, 50, 81, 1)), // Set border color when not focused
                            ),
                          ),
                          textInputAction: TextInputAction.next,
                          focusNode: _itemNameFocusNode,
                          onFieldSubmitted: (value) {
                            FocusScope.of(context).requestFocus(_stockFocusNode);
                          },
                        ),
                      ),
                      SizedBox(height: 20),
                      Container(
                        padding: EdgeInsets.symmetric(vertical: 8.0), // Add vertical padding
                        constraints: BoxConstraints(
                          maxWidth: 400.0, // Limit the maximum width
                        ),
                        child: TextFormField(
                          controller: _stockController,
                          decoration: InputDecoration(
                            hintText: 'Stock',
                            labelText: 'Stock',
                            labelStyle: TextStyle(
                              color: Color.fromRGBO(26, 50, 81, 1), // Set the color of the label text
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Color.fromRGBO(26, 50, 81, 1)), // Set border color when focused
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Color.fromRGBO(26, 50, 81, 1)), // Set border color when not focused
                            ),
                          ),
                          keyboardType: TextInputType.number,
                          textInputAction: TextInputAction.next,
                          focusNode: _stockFocusNode,
                          onFieldSubmitted: (value) {
                            FocusScope.of(context).requestFocus(_priceFocusNode);
                          },
                        ),
                      ),
                      SizedBox(height: 20),
                      Container(
                        padding: EdgeInsets.symmetric(vertical: 8.0), // Add vertical padding
                        constraints: BoxConstraints(
                          maxWidth: 400.0, // Limit the maximum width
                        ),
                        child: TextFormField(
                          controller: _priceController,
                          decoration: InputDecoration(
                            hintText: 'Price',
                            labelText: 'Price',
                            labelStyle: TextStyle(
                              color: Color.fromRGBO(26, 50, 81, 1), // Set the color of the label text
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Color.fromRGBO(26, 50, 81, 1)), // Set border color when focused
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Color.fromRGBO(26, 50, 81, 1)), // Set border color when not focused
                            ),
                          ),
                          keyboardType: TextInputType.numberWithOptions(decimal: true),
                          textInputAction: TextInputAction.done,
                          focusNode: _priceFocusNode,
                          onFieldSubmitted: (value) {
                            _handleAddItem();
                          },
                        ),
                      ),
                      SizedBox(height: 20),
                      Container(
                        padding: EdgeInsets.symmetric(vertical: 8.0), // Add vertical padding
                        constraints: BoxConstraints(
                          maxWidth: 400.0, // Limit the maximum width
                        ),
                        child: DropdownButtonFormField<String>(
                          decoration: InputDecoration(
                            labelText: 'Category',
                            labelStyle: TextStyle(
                              color: Color.fromRGBO(26, 50, 81, 1), // Set the color of the label text
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Color.fromRGBO(26, 50, 81, 1)), // Set border color when focused
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Color.fromRGBO(26, 50, 81, 1)), // Set border color when not focused
                            ),
                          ),
                          items: [
                            'Designing',
                            'Hardware',
                            'Sanitary',
                            'Paint',
                            'Tiles',
                            'Electricity',
                            // Add your category options here
                          ].map((String category) {
                            return DropdownMenuItem<String>(
                              value: category,
                              child: Text(category),
                            );
                          }).toList(),
                          value: _selectedCategory,
                          onChanged: (String? value) {
                            setState(() {
                              _selectedCategory = value;
                            });
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            (.02 * MediaQuery.of(context).size.height).heightBox,
            Padding(
              padding: const EdgeInsets.all(15.0),
              child: InkWell(
                onTap: () {
                  _handleAddItem();
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
                      'Add Item',
                      style: TextStyle(color: Colors.white, fontSize: 25),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
