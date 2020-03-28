import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:iaso/Models/Supplies/SuppliesFirebaseManager.dart';
import 'package:iaso/Models/Supplies/Supply.dart';

class SupplyTile extends StatelessWidget {
  Supply suply;
  String id;
  TextEditingController controller;

  SupplyTile({this.suply, this.id, this.controller});

  @override
  Widget build(BuildContext context) {
    return Container(
        width: double.infinity,
        height: 70,
        decoration: BoxDecoration(
            color: Color(0xFFF7F7F7),
            borderRadius: BorderRadius.all(Radius.circular(5))),
        child: Padding(
            padding: EdgeInsets.all(10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text(
                      suply.name,
                      style: TextStyle(
                          fontSize: 20,
                          color: Colors.grey[900],
                          fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
                Row(
                  children: <Widget>[
                    CupertinoButton(
                      child: Text("-", style: TextStyle(fontSize: 24)),
                      onPressed: null,
                    ),
                    Container(
                        width: 40,
                        height: 24,
                        child: Center(
                            child: CupertinoTextField(
                          controller: controller,
                          keyboardType: TextInputType.number,
                        ))),
                    CupertinoButton(
                      child: Text(
                        "+",
                        style: TextStyle(fontSize: 24),
                      ),
                      onPressed: null,
                    ),
                    CupertinoButton(
                        child: Icon(
                          CupertinoIcons.shopping_cart,
                          size: 24,
                        ),
                        onPressed: () => _addToBuyList())
                  ],
                )
              ],
            )));
  }

  _addToBuyList() {
    //print(id);
    SuppliesFirebaseManager i = new SuppliesFirebaseManager();
    i.updateSupply(id, suply);
  }
}
