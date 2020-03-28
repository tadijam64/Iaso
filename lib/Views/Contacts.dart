import 'package:contacts_service/contacts_service.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:iaso/Common/Settings.dart';
import 'package:iaso/Models/Contacts/ContactInteractor.dart';
import 'package:iaso/Models/Contacts/FirebaseContact.dart';
import 'package:permission_handler/permission_handler.dart';

class Contacts extends StatefulWidget {
  ContactsState createState() => new ContactsState();
}

class ContactsState extends State<Contacts> {
  List<Contact> contacts = null;
  List<FirebaseContact> request = new List();

  @override
  void initState() {
    super.initState();
    refreshContacts();

    ContactInteractor interactor = new ContactInteractor();
    interactor.getContacts(false).listen((value) {
      setState(() {
        request = value;
      });
    });

    WidgetsBinding.instance.addPostFrameCallback((_) => afterBuild(context));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
      child: Padding(
          padding: EdgeInsets.all(20),
          child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Center(
                    child: Text(
                  "Your contacts",
                  style: TextStyle(
                      fontSize: 24.0,
                      fontWeight: FontWeight.bold,
                      color: Colors.black87),
                )),
                SizedBox(
                  height: 30,
                ),
                Text(
                  "Please select your favorite contacts by pressing \"Request\" button, if they accept your request you will be able to see their info on your \"Family\" card.",
                  style: TextStyle(fontSize: 18.0, color: Colors.black54),
                ),
                SizedBox(
                  height: 20,
                ),
                Container(
                  width: double.infinity,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    mainAxisSize: MainAxisSize.max,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Icon(CupertinoIcons.search, color: Colors.grey),
                      SizedBox(
                        width: 20,
                      ),
                      Flexible(
                          child: CupertinoTextField(
                        placeholder: "Search...",
                      ))
                    ],
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Expanded(
                    child: (contacts != null)
                        ? new ListView.builder(
                            itemCount: contacts.length,
                            itemBuilder: (BuildContext ctxt, int index) {
                              String number = "";
                              Contact c = contacts[index];
                              c.phones.toList().forEach((f) {
                                if (number == "")
                                  number = f.value.trim().replaceAll(" ", "");
                              });

                              List<FirebaseContact> contactsTemp = request
                                  .where((l) => l.phoneNumber.contains(number))
                                  .toList();

                              return ListTile(
                                leading: (c.avatar != null &&
                                        c.avatar.length > 0)
                                    ? CircleAvatar(
                                        backgroundImage: MemoryImage(c.avatar))
                                    : CircleAvatar(child: Text(c.initials())),
                                title: Text(c.displayName),
                                subtitle: Text(number),
                                trailing: CupertinoButton(
                                  child: Text(
                                    contactsTemp.length > 0
                                        ? "Requested"
                                        : "Request",
                                    style: TextStyle(fontSize: 16),
                                  ),
                                  onPressed: contactsTemp.length > 0
                                      ? null
                                      : () => _request(
                                          number.trim().replaceAll(" ", "")),
                                ),
                              );
                            })
                        : Text("Loading contacts...")),
                SizedBox(
                  height: 20,
                ),
                Center(
                    child: CupertinoButton(
                  child: Text(
                    'FINISH',
                    style: TextStyle(fontSize: 20),
                  ),
                  onPressed: () {
                    Settings().setHasUserAddedContacts(true);
                    Settings().startUp();
                  },
                ))
              ])),
    ));
  }

  afterBuild(BuildContext context) {}

  refreshContacts() async {
    PermissionStatus permissionStatus = await _getContactPermission();
    if (permissionStatus == PermissionStatus.granted) {
      var conts =
          (await ContactsService.getContacts(withThumbnails: false)).toList();

      setState(() {
        contacts = conts;
      });

      for (final contact in contacts) {
        ContactsService.getAvatar(contact).then((avatar) {
          if (avatar == null) return;
          setState(() => contact.avatar = avatar);
        });
      }
    }
  }

  Future<PermissionStatus> _getContactPermission() async {
    PermissionStatus permission = await PermissionHandler()
        .checkPermissionStatus(PermissionGroup.contacts);
    if (permission != PermissionStatus.granted) {
      Map<PermissionGroup, PermissionStatus> permissionStatus =
          await PermissionHandler()
              .requestPermissions([PermissionGroup.contacts]);
      return permissionStatus[PermissionGroup.contacts] ??
          PermissionStatus.unknown;
    } else {
      return permission;
    }
  }

  _request(String number) {
    ContactInteractor interactor = new ContactInteractor();
    FirebaseContact contact = new FirebaseContact();
    contact.phoneNumber = number;
    contact.accepted = false;
    interactor.addContactRequest(contact);
    setState(() {});
  }
}
