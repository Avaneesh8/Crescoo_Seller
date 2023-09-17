import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';

import '../../provider/auth_provider.dart';
import '../../widgets/NavBar.dart';
import '../../widgets/Top_part.dart';

class Inventory extends StatefulWidget {
  const Inventory({Key? key}) : super(key: key);

  @override
  State<Inventory> createState() => _InventoryState();
}

class _InventoryState extends State<Inventory> {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  late Future<QuerySnapshot> _inventoryItems;
  bool isEven = false;

  Future<void> deleteItem(String documentId) async {
    try {
      await _firestore.collection('items').doc(documentId).delete();
      Fluttertoast.showToast(
        msg: 'Item deleted successfully!',
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        backgroundColor: Color.fromRGBO(26, 50, 81, 1),
        textColor: Colors.white,
      );
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => const NavBar(
            index: 0,
          ),
        ),
      );
    } catch (e) {
      print('Error deleting item: $e');
    }
  }

  Future<void> editItem(String documentId, String newName, String newCategory, String newStock, String newPrice) async {
    try {
      await _firestore.collection('items').doc(documentId).update({
        'productID': newName,
        'category': newCategory,
        'stock': int.parse(newStock),
        'price': double.parse(newPrice),
      });
      Fluttertoast.showToast(
        msg: 'Item updated successfully!',
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        backgroundColor: Color.fromRGBO(26, 50, 81, 1),
        textColor: Colors.white,
      );
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => const NavBar(
            index: 0,
          ),
        ),
      );
    } catch (e) {
      print('Error updating item: $e');
    }
  }

  @override
  void initState() {
    super.initState();
    final ap = Provider.of<AuthProvider>(context, listen: false);
    _inventoryItems = FirebaseFirestore.instance
        .collection('items')
        .where('phoneNumber', isEqualTo: ap.userModel.phoneNumber)
        .get();
  }

  Color getBackgroundColor() {
    isEven = !isEven;
    return isEven ? Color(0xFFBDBDC7) : Color(0xFF1B3858);
  }

  @override
  Widget build(BuildContext context) {
    final ap = Provider.of<AuthProvider>(context, listen: false);
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          SizedBox(
            width: MediaQuery.of(context).size.width,
            height: .200 * MediaQuery.of(context).size.height,
            child: Top_part(),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 40, right: 40, top: 20),
            child: Text(
              "Inventory",
              style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
            ),
          ),
          Expanded(
            child: Container(
              margin: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
              ),
              child: FutureBuilder(
                future: _inventoryItems,
                builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return CircularProgressIndicator();
                  } else if (snapshot.hasError) {
                    return Text('Error: ${snapshot.error}');
                  } else if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                    return Text('No items found.');
                  } else {
                    return ListView(
                      children: snapshot.data!.docs.map((DocumentSnapshot document) {
                        final documentId = document.id;
                        String productID = document['productID'];
                        String category = document['category'];
                        final stock = document['stock'];
                        final price = document['price'];

                        return Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Container(
                            decoration: ShapeDecoration(
                              color: getBackgroundColor(),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(15),
                              ),
                            ),
                            child: ListTile(
                              title: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text('Item Name : $productID', style: TextStyle(color: Colors.white, fontSize: 20)),
                              ),
                              subtitle: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text('Category : $category\nStock: $stock\t Price: $price', style: TextStyle(color: Colors.white)),
                              ),
                              trailing: Row(
                                mainAxisSize: MainAxisSize.min,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  IconButton(
                                    icon: Icon(Icons.edit, color: Colors.white70),
                                    onPressed: () {
                                      showDialog(
                                        context: context,
                                        builder: (context) {
                                          TextEditingController nameController =
                                          TextEditingController(text: productID);
                                          TextEditingController categoryController =
                                          TextEditingController(text: category);
                                          TextEditingController stockController =
                                          TextEditingController(text: stock.toString());
                                          TextEditingController priceController =
                                          TextEditingController(text: price.toString());

                                          return AlertDialog(
                                            title: Text('Edit Item'),
                                            content: Column(
                                              mainAxisSize: MainAxisSize.min,
                                              children: [
                                                TextField(
                                                  controller: nameController,
                                                  decoration: InputDecoration(
                                                    labelText: 'Item Name',
                                                  ),
                                                ),
                                                TextField(
                                                  controller: categoryController,
                                                  decoration: InputDecoration(
                                                    labelText: 'Category',
                                                  ),
                                                ),
                                                TextField(
                                                  controller: stockController,
                                                  keyboardType: TextInputType.number,
                                                  decoration: InputDecoration(
                                                    labelText: 'Stock',
                                                  ),
                                                ),
                                                TextField(
                                                  controller: priceController,
                                                  keyboardType: TextInputType.number,
                                                  decoration: InputDecoration(
                                                    labelText: 'Price',
                                                  ),
                                                ),
                                              ],
                                            ),
                                            actions: [
                                              TextButton(
                                                onPressed: () {
                                                  Navigator.pop(context);
                                                },
                                                child: Text('Cancel'),
                                              ),
                                              TextButton(
                                                onPressed: () {
                                                  String newName = nameController.text;
                                                  String newCategory = categoryController.text;
                                                  String newStock = stockController.text;
                                                  String newPrice = priceController.text;
                                                  editItem(documentId, newName, newCategory, newStock, newPrice);
                                                  Navigator.pop(context);
                                                },
                                                child: Text('Save'),
                                              ),
                                            ],
                                          );
                                        },
                                      );
                                    },
                                  ),
                                  IconButton(
                                    icon: Icon(Icons.delete, color: Colors.white70),
                                    onPressed: () {
                                      showDialog(
                                        context: context,
                                        builder: (context) {
                                          return AlertDialog(
                                            title: Text('Delete Item'),
                                            content: Text('Are you sure you want to delete this item?'),
                                            actions: [
                                              TextButton(
                                                onPressed: () {
                                                  Navigator.pop(context);
                                                },
                                                child: Text('Cancel'),
                                              ),
                                              TextButton(
                                                onPressed: () {
                                                  deleteItem(documentId);
                                                  Navigator.pop(context);
                                                },
                                                child: Text('Delete'),
                                              ),
                                            ],
                                          );
                                        },
                                      );
                                    },
                                  ),
                                ],
                              ),
                            ),
                          ),
                        );
                      }).toList(),
                    );
                  }
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
