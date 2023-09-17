import 'package:flutter/material.dart';
import 'package:velocity_x/velocity_x.dart';

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

  FocusNode _itemNameFocusNode = FocusNode();
  FocusNode _stockFocusNode = FocusNode();
  FocusNode _priceFocusNode = FocusNode();

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

  void _handleAddItem() {
    String itemName = _itemNameController.text;
    String stockText = _stockController.text;
    String priceText = _priceController.text;

    if (itemName.isNotEmpty && stockText.isNotEmpty && priceText.isNotEmpty) {
      int stock = int.tryParse(stockText) ?? 0;
      double price = double.tryParse(priceText) ?? 0.0;

      // Process the data here (e.g., save to database)
      print('Item Name: $itemName');
      print('Stock: $stock');
      print('Price: $price');

      // Clear text fields
      _itemNameController.clear();
      _stockController.clear();
      _priceController.clear();
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
              'Please fill in all fields.',
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
            (.05 * MediaQuery.of(context).size.height).heightBox,
            Padding(
              padding: const EdgeInsets.only(left: 40, right: 40, top: 20),
              child: Text(
                "Inventory Management",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
            ),
            (.05 * MediaQuery.of(context).size.height).heightBox,
            Container(
              width: MediaQuery.of(context).size.width * .85,
              height: MediaQuery.of(context).size.height * .35,
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
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Item Name Input
                    TextField(
                      controller: _itemNameController,
                      decoration: InputDecoration(
                        hintText: 'Item Name',
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.transparent),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.transparent),
                        ),
                      ),
                      textInputAction: TextInputAction.next,
                      focusNode: _itemNameFocusNode,
                      onSubmitted: (value) {
                        FocusScope.of(context).requestFocus(_stockFocusNode);
                      },
                    ),
                    SizedBox(height: 20),

                    // Stock Input
                    TextField(
                      controller: _stockController,
                      decoration: InputDecoration(
                        hintText: 'Stock',
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.transparent),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.transparent),
                        ),
                      ),
                      keyboardType: TextInputType.number,
                      textInputAction: TextInputAction.next,
                      focusNode: _stockFocusNode,
                      onSubmitted: (value) {
                        FocusScope.of(context).requestFocus(_priceFocusNode);
                      },
                    ),
                    SizedBox(height: 20),

                    // Price Input
                    TextField(
                      controller: _priceController,
                      decoration: InputDecoration(
                        hintText: 'Price',
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.transparent),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.transparent),
                        ),
                      ),
                      keyboardType: TextInputType.numberWithOptions(decimal: true),
                      textInputAction: TextInputAction.done,
                      focusNode: _priceFocusNode,
                      onSubmitted: (value) {
                        _handleAddItem();
                      },
                    ),
                  ],
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
