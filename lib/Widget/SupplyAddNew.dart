import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:iaso/Models/Supplies/SuppliesFirebaseManager.dart';
import 'package:iaso/Models/Supplies/Supply.dart';

class SupplyAddNew extends StatefulWidget {
  SupplyAddNewState createState() => new SupplyAddNewState();
}

class SupplyAddNewState extends State<SupplyAddNew> {
  TextEditingController nameController = new TextEditingController();
  TextEditingController amountController = new TextEditingController();
  TextEditingController defaultController = new TextEditingController();

  Color gradientStart = Color(0xFFD92525);
  final Map<int, Widget> odabir = const <int, Widget>{
    0: Text('No'),
    1: Text('Yes'),
  };

  int odabraniMedical = 0, odabraniBuyList = 1;

  SupplyAddNewState() {
    _resetAmounts();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: EdgeInsets.only(left: 20, right: 20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            SizedBox(
              height: 30,
            ),
            Text(
              "Suply name:",
              style: TextStyle(fontSize: 18.0, color: Colors.black54),
            ),
            SizedBox(
              height: 10,
            ),
            CupertinoTextField(controller: nameController),
            SizedBox(
              height: 30,
            ),
            Text(
              "Current stock amount:",
              style: TextStyle(fontSize: 18.0, color: Colors.black54),
            ),
            Row(
              children: <Widget>[
                CupertinoButton(
                  child: Text("-",
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                  onPressed: null,
                ),
                Expanded(
                  child: CupertinoTextField(
                    keyboardType: TextInputType.number,
                    controller: amountController,
                  ),
                ),
                CupertinoButton(
                  child: Text(
                    "+",
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  onPressed: null,
                ),
              ],
            ),
            SizedBox(
              height: 30,
            ),
            Text(
              "Default packet size:",
              style: TextStyle(fontSize: 18.0, color: Colors.black54),
            ),
            Row(
              children: <Widget>[
                CupertinoButton(
                  child: Text("-",
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                  onPressed: null,
                ),
                Expanded(
                  child: CupertinoTextField(
                    keyboardType: TextInputType.number,
                    controller: defaultController,
                  ),
                ),
                CupertinoButton(
                  child: Text(
                    "+",
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  onPressed: null,
                ),
              ],
            ),
            SizedBox(
              height: 30,
            ),
            Text(
              "Is it a medical product?:",
              style: TextStyle(fontSize: 18.0, color: Colors.black54),
            ),
            SizedBox(
              height: 10,
            ),
            Container(
                width: double.infinity,
                child: CupertinoSegmentedControl(
                    selectedColor: gradientStart,
                    borderColor: gradientStart,
                    children: odabir,
                    groupValue: odabraniMedical,
                    onValueChanged: (value) {
                      odabraniMedical = value;
                      setState(() {});
                    })),
            SizedBox(
              height: 30,
            ),
            Text(
              "Automatically add to buy list?:",
              style: TextStyle(fontSize: 18.0, color: Colors.black54),
            ),
            SizedBox(
              height: 10,
            ),
            Container(
                width: double.infinity,
                child: CupertinoSegmentedControl(
                    selectedColor: gradientStart,
                    borderColor: gradientStart,
                    children: odabir,
                    groupValue: odabraniBuyList,
                    onValueChanged: (value) {
                      odabraniBuyList = value;
                      setState(() {});
                    })),
            Expanded(child: Material()),
            Center(
                child: CupertinoButton(
              child: Text(
                'SAVE DATA',
                style: TextStyle(fontSize: 20),
              ),
              onPressed: () => _saveData(),
            ))
          ],
        ));
  }

  _saveData() {
    Supply supply = new Supply();
    supply.name = nameController.text;
    supply.amount = int.parse(amountController.text);
    supply.defaultAmount = int.parse(defaultController.text);

    if (odabraniBuyList == 0)
      supply.setStatus(SupplyStatus.toBuy);
    else
      supply.setStatus(SupplyStatus.ok);

    if (odabraniMedical == 0)
      supply.setType(SupplyType.medicine);
    else
      supply.setType(SupplyType.household);

    SuppliesFirebaseManager db = new SuppliesFirebaseManager();
    db.addSupply(supply);

    final snackBar = SnackBar(content: Text("Added " + supply.name));
    Scaffold.of(context).showSnackBar(snackBar);
    _resetAmounts();
  }

  void _resetAmounts() {
    amountController.text = "1";
    defaultController.text = "1";
  }
}
