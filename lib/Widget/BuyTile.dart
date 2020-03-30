import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:iaso/Models/Supplies/SuppliesFirebaseManager.dart';
import 'package:iaso/Models/Supplies/Supply.dart';

class BuyTile extends StatefulWidget {
  Supply suply;

  TextEditingController controller;

  BuyTile({this.suply, this.controller});
  BuyTileState createState() => new BuyTileState(this.suply, this.controller);
}

class BuyTileState extends State<BuyTile> {
  Supply suply;

  TextEditingController controller;

  BuyTileState(this.suply, this.controller) {
    _value = suply.status == 1 ? false : true;
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: () => {
              setState(() {
                _value = !_value;
                _addToBuyList();
              })
            },
        child: Container(
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
                        Checkbox(
                          value: _value,
                          onChanged: (bool newValue) {
                            setState(() {
                              _value = newValue;
                              _addToBuyList();
                            });
                          },
                        )
                      ],
                    )
                  ],
                ))));
  }

  bool _value = false;

  _addToBuyList() {
    if (!_value)
      suply.status = 1;
    else
      suply.status = 2;

    SuppliesFirebaseManager i = new SuppliesFirebaseManager();
    i.updateSupply(suply.id, suply);
  }
}
