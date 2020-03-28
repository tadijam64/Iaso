import 'package:contacts_service/contacts_service.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:iaso/Common/ContactExtended.dart';
import 'package:iaso/Common/Settings.dart';
import 'package:iaso/Models/ContactInteractor.dart';
import 'package:iaso/Models/PoolInteractor.dart';
import 'package:permission_handler/permission_handler.dart';

class Contacts extends StatefulWidget {
  ContactsState createState() => new ContactsState();
}

class ContactsState extends State<Contacts> {
  List<Contact> contacts = null;
  Map<String, bool> request = new Map<String, bool>();

  //TODO: Search kontakata

  @override
  void initState() {
    super.initState();
    refreshContacts();

    ContactInteractor interactor = new ContactInteractor();
    interactor.getRequested().then((value) {
      setState(() {
        request.addAll(value);
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
                                if (number == "") number = f.value;
                              });

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
                                    request[number] != null
                                        ? "Requested"
                                        : "Request",
                                    style: TextStyle(fontSize: 16),
                                  ),
                                  onPressed: request[number] != null
                                      ? null
                                      : () => _request(number),
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
    interactor.saveData(number);

    setState(() {
      request[number] = true;
    });
  }
}
