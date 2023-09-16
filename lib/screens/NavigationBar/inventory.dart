import 'package:flutter/material.dart';

import '../../widgets/Top_part.dart';

class Inventory extends StatefulWidget {
  const Inventory({Key? key}) : super(key: key);

  @override
  State<Inventory> createState() => _InventoryState();
}

class _InventoryState extends State<Inventory> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          SizedBox(
              width: MediaQuery.of(context).size.width,
              height: .200 * MediaQuery.of(context).size.height,
              child: Top_part()),
          Padding(
            padding: const EdgeInsets.only(left: 40,right: 40,top: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("Inventory",style: TextStyle(fontSize: 30,fontWeight: FontWeight.bold),),
                IconButton(onPressed: (){}, icon: Icon(Icons.edit),),
              ],
            ),
          ),
          SingleChildScrollView(
            child: Column(
              
            ),
          ),
        ],
      ),
    );
  }
}
