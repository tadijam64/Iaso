import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:iaso/Models/Supplies/SuppliesFirebaseManager.dart';
import 'package:iaso/Models/Supplies/Supply.dart';

class SupplyTile extends StatelessWidget {
  Supply suply;

  TextEditingController controller;

  SupplyTile({this.suply, this.controller});

  @override
  Widget build(BuildContext context) {
    return Container(
        width: double.infinity,
        height: 50,
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
                          color: Colors.grey[800],
                          fontWeight: FontWeight.w600),
                    ),
                  ],
                ),
                Row(
                  children: <Widget>[
                    Container(
                        width: 24,
                        child: FlatButton(
                          child: Text("-", style: TextStyle(fontSize: 30)),
                          onPressed: () => _remove(),
                        )),
                    SizedBox(
                      width: 10,
                    ),
                    Container(
                        width: 40,
                        height: 40,
                        child: Center(
                            child: CupertinoTextField(
                          textAlign: TextAlign.center,
                          textAlignVertical: TextAlignVertical.center,
                          controller: controller,
                          keyboardType: TextInputType.number,
                        ))),
                    Container(
                        width: 26,
                        child: FlatButton(
                          padding: EdgeInsets.all(0),
                          child: Text("+", style: TextStyle(fontSize: 26)),
                          onPressed: () => _add(),
                        )),
                    SizedBox(
                      width: 20,
                    ),
                    Container(
                        width: 24,
                        child: FlatButton(
                            padding: EdgeInsets.all(0),
                            child: Icon(
                              Icons.shopping_basket,
                              size: 24,
                            ),
                            onPressed: () => _addToBuyList(context)))
                  ],
                )
              ],
            )));
  }

  _addToBuyList(BuildContext context) {
    suply.setStatus(SupplyStatus.toBuy);
    SuppliesFirebaseManager i = new SuppliesFirebaseManager();
    i.updateSupply(suply.id, suply);

    final snackBar = SnackBar(
      content: Text("Added " + suply.name + " to buy list!"),
    );
    Scaffold.of(context).showSnackBar(snackBar);
  }

  _add() {
    suply.amount += 1;
    SuppliesFirebaseManager i = new SuppliesFirebaseManager();
    i.updateSupply(suply.id, suply);
  }

  _remove() {
    suply.amount -= 1;
    SuppliesFirebaseManager i = new SuppliesFirebaseManager();
    i.updateSupply(suply.id, suply);
  }
}
