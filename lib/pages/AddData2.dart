//import 'package:flutter/material.dart';
//import 'package:cloud_firestore/cloud_firestore.dart';
////import 'package:intl/intl.dart';
//import 'package:sendhappiness/Modal/UserData.dart';
////import 'package:path/path.dart';
//import 'package:contacts_service/contacts_service.dart';
//import 'package:sendhappiness/Modal/contacts_dialog.dart';
//import 'package:flutter/services.dart';
//import 'package:permission_handler/permission_handler.dart';
//class AddData2 extends StatefulWidget {
//  final String datacol;
//  AddData2(this.datacol);
//  @override
//  _AddDataState createState() => _AddDataState(datacol);
//}
//
//class _AddDataState extends State<AddData> {
//
//  String codeArea;
//  String phoneNumberForm;
//  String guestName;
//
//  //Contacts
//  Iterable<Contact> _contacts;
//  Contact _actualContact;
//
//
//  TextEditingController phoneTextFieldController = TextEditingController();
//  TextEditingController guestnameTextFieldController = TextEditingController();
//
//
//
//
//  String datacol;
//  _AddDataState(this.datacol);
//
//  //final FirebaseAuth _auth =FirebaseAuth.instance;
//  final databaseReference = Firestore.instance;
//  String name,phone,message,date,time,status="false";
//
//
//
//  saveUser(BuildContext context) async{
//    if(name.isNotEmpty&&phone.isNotEmpty&&message.isNotEmpty&&date.isNotEmpty&&time.isNotEmpty&&status.isNotEmpty){
//
//      UserData data = UserData(this.name,this.phone,this.message,this.date,this.time,this.status);
//
//      await databaseReference.collection(datacol).document()
//          .setData(data.toJson());
//      navigateToLastScreen(context);
//
//    }else{
//      showDialog(
//          context: context,
//          builder: (BuildContext context){
//            return AlertDialog(
//              title: Text('Error Message'),
//              content: Text("All Feild Are Required"),
//              actions: <Widget>[
//                FlatButton(
//                  child: Text('Ok'),
//                  onPressed: (){
//                    Navigator.of(context).pop();
//                  },
//                ),
//              ],
//            );
//          }
//      );
//    }
//  }
//
//  navigateToLastScreen(context){
//
//    Navigator.of(context).pop();
//
//  }
//
//  @override
//  Widget build(BuildContext context) {
//    return Scaffold(
//      appBar: AppBar(
//        title: Text("Add Data"),
//      ),
//      body: Container(
//        child: Padding(
//          padding: EdgeInsets.all(20.0),
//          child: ListView(
//            children: <Widget>[
//              //image view
//
//              Container(
//                margin: EdgeInsets.only(top: 20.0),
//                child: TextField(
//                  onChanged: (value) {
//                    setState(() {
//                      name = value;
//                    });
//                  },
//                  decoration: InputDecoration(
//                    labelText: 'Name',
//                    border: OutlineInputBorder(
//                        borderRadius: BorderRadius.circular(5.0)),
//                  ),
//                ),
//              ),
//              //
//              Container(
//                margin: EdgeInsets.only(top: 20.0),
//                child: TextField(
//                  onTap: ()  {
//                    //_showContactList(context);
//                  },
//                  //keyboardType: TextInputType.number,
//                  controller: phoneTextFieldController,
//
//                  decoration: InputDecoration(
//                    labelText: 'Phone',
//                    border: OutlineInputBorder(
//                        borderRadius: BorderRadius.circular(5.0)),
//                  ),
//                ),
//              ),
//              //
////              Container(
////                margin: EdgeInsets.only(top: 20.0),
////                child: TextField(
////                  onChanged: (value) {
////                    setState(() {
////                      date = value;
////                    });
////                  },
////                  onTap: _selectDate(context),
////                  decoration: InputDecoration(
////                    labelText: 'Date',
////                    border: OutlineInputBorder(
////                        borderRadius: BorderRadius.circular(5.0)),
////                  ),
////                ),
////              ),
//              Container(
//                margin: EdgeInsets.only(top: 20.0),
//                child: TextField(
//                  onChanged: (value) {
//                    setState(() {
//                      time = value;
//                    });
//                  },
//                  keyboardType: TextInputType.datetime,
//                  decoration: InputDecoration(
//                    labelText: 'Time',
//                    border: OutlineInputBorder(
//                        borderRadius: BorderRadius.circular(5.0)),
//                  ),
//                ),
//              ),
//
//              Container(
//                margin: EdgeInsets.only(top: 20.0),
//                child: TextField(
//                  onChanged: (value) {
//                    setState(() {
//                      message = value;
//                    });
//                  },
//                  keyboardType: TextInputType.text,
//                  decoration: InputDecoration(
//                    labelText: 'Message',
//                    border: OutlineInputBorder(
//                        borderRadius: BorderRadius.circular(5.0)),
//                  ),
//                ),
//              ),
//              // update button
//              Container(
//                padding: EdgeInsets.only(top: 20.0),
//                child: RaisedButton(
//                  padding: EdgeInsets.fromLTRB(100.0, 20.0, 100.0, 20.0),
//                  onPressed: () {
//                    saveUser(context);
//                  },
//                  color: Colors.red,
//                  child: Text(
//                    "Submit",
//                    style: TextStyle(
//                      fontSize: 20.0,
//                      color: Colors.white,
//                    ),
//                  ),
//                ),
//              )
//            ],
//          ),
//        ),
//      ),
//    );
//  }
//}
//
//
//
////// Getting list of contacts from AGENDA
////refreshContacts() async {
////  PermissionStatus permissionStatus = await _getContactPermission();
////  if (permissionStatus == PermissionStatus.granted) {
////    //var contacts = await ContactsService.getContacts();
////    Iterable<Contact> _contacts = await ContactsService.getContacts();
////
////    setState((){
////      _contacts = _contacts;
////
////    });
////
////  } else {
////    _handleInvalidPermissions(permissionStatus);
////  }
////}
////
////// Asking Contact permissions
////Future<PermissionStatus> _getContactPermission() async {
////  PermissionStatus permission = await PermissionHandler().checkPermissionStatus(PermissionGroup.contacts);
////  if (permission != PermissionStatus.granted && permission != PermissionStatus.disabled) {
////    Map<PermissionGroup, PermissionStatus> permissionStatus = await PermissionHandler().requestPermissions([PermissionGroup.contacts]);
////    return permissionStatus[PermissionGroup.contacts] ?? PermissionStatus.unknown;
////  } else {
////    return permission;
////  }
////}
////
////// Managing error when you don't have permissions
////void _handleInvalidPermissions(PermissionStatus permissionStatus) {
////  if (permissionStatus == PermissionStatus.denied) {
////    throw new PlatformException(
////        code: "PERMISSION_DENIED",
////        message: "Access to location data denied",
////        details: null);
////  } else if (permissionStatus == PermissionStatus.disabled) {
////    throw new PlatformException(
////        code: "PERMISSION_DISABLED",
////        message: "Location data is not available on device",
////        details: null);
////  }
////}
////
////// Showing contact list.
////Future<Null> _showContactList(BuildContext context) async {
////
////  List<Contact> favoriteElements = [];
////  final InputDecoration searchDecoration = const InputDecoration();
////
////  refreshContacts();
////  if (_contacts != null)
////  {
////    showDialog(
////      context: context,
////      builder: (_) =>
////          SelectionDialogContacts(
////            _contacts.toList(),
////            favoriteElements,
////            showCountryOnly: false,
////            emptySearchBuilder: null,
////            searchDecoration: searchDecoration,
////          ),
////    ).then((e) {
////      if (e != null) {
////        setState(() {
////          _actualContact = e;
////        });
////
////        //guestnameTextFieldController.text = _actualContact.middleName;
////        phoneTextFieldController.text = _actualContact.phones.first.value;
////
////
////      }
////    });
////
////
////  }
////
////}