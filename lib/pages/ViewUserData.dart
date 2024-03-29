import 'dart:core';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:sendhappiness/Modal/UserData.dart';


class ViewUser extends StatefulWidget {
  final String id;
  final String datacol;
  ViewUser (this.id, this.datacol);
  @override
  _ViewUserState createState() => _ViewUserState(id,datacol);
}

class _ViewUserState extends State<ViewUser> {

  String id , datacol;

  bool isLoading = true;
  _ViewUserState(this.id, this.datacol);

  final databaseReference = Firestore.instance;
   UserData _user;
  //var document;

  getUser(id,datacol) async{
    databaseReference.collection(datacol).document(id).get().then((datasnapshot){

      setState(() {
        _user =UserData.fromDocument(datasnapshot);
        isLoading = false;
      });

    });
  }

  navigateToLastScreen(BuildContext context){

    Navigator.of(context).pop();

  }

//  navigatetoEdit(id,datacol){
//    //Navigator.of(context).pop();
//    Navigator.push(context, MaterialPageRoute(builder: (context) {
//      return EditUser(id,datacol);
//    }));
//  }

  _deleteuser(){
    showDialog(context: context,
        builder: (BuildContext context){
          return AlertDialog(
            title: Text('Delete'),
            content: Text('Are you Sure to Delete ?'),
            actions: <Widget>[
              FlatButton(
                child: Text('Cancel'),
                onPressed: (){
                  Navigator.of(context).pop();
                },
              ),
              FlatButton(
                child: Text('delete'),
                onPressed: ()async{
                  await databaseReference.collection(datacol).document(id).delete();
                  Navigator.of(context).pop();
                  navigateToLastScreen(context);
                },
              ),
            ],
          );

        });
  }

  @override
  void initState() {
    super.initState();
    getUser(id,datacol);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("View Contact"),
      ),
      body: Container(
        child: isLoading
            ? Center(
          child: CircularProgressIndicator(),
        )
            : ListView(
          children: <Widget>[
            Card(
              elevation: 2.0,
              child:ListTile(
                title: Text(_user.name.toUpperCase()),
                subtitle: Text(_user.date),
                leading: Icon(Icons.supervised_user_circle),
                trailing: Text('Time: ${_user.time}'),
              ),
            ),
            // phone
            Card(
              elevation: 2.0,
              child:
              ListTile(
                title: Text('+91${_user.phone}'),
                leading: Icon(Icons.phone),
                trailing: _user.status =='false'? Text('Pending',style: TextStyle(color:Theme.of(context).accentColor),)
                    : Text('Sent',style: TextStyle(color:Theme.of(context).primaryColor)),
              ),
            ),
            // email
            // address
            Card(
              elevation: 2.0,
              child: Container(
                  margin: EdgeInsets.all(20.0),
                  width: double.maxFinite,
                  child: Row(
                    children: <Widget>[
                      Icon(Icons.markunread),
                      Container(
                        width: 10.0,
                      ),
                     Flexible(child: Text(
                        _user.message,
                        style: TextStyle(fontSize: 20.0),
                      ),),
                    ],
                  )),
            ),
//            // call and sms
//            Card(
//              elevation: 2.0,
//              child: Container(
//                  margin: EdgeInsets.all(20.0),
//                  width: double.maxFinite,
//                  child: Row(
//                    mainAxisAlignment: MainAxisAlignment.spaceAround,
//                    children: <Widget>[
//                      IconButton(
//                        iconSize: 30.0,
//                        icon: Icon(Icons.phone),
//                        color: Colors.red,
//                        onPressed: () {
//                          //callAction(_contact.phone);
//                        },
//                      ),
//                      IconButton(
//                        iconSize: 30.0,
//                        icon: Icon(Icons.message),
//                        color: Colors.red,
//                        onPressed: () {
//                          //smsAction(_contact.phone);
//                        },
//                      )
//                    ],
//                  )),
//            ),
//            // edit and delete
            Card(
              elevation: 2.0,
              child: Container(
                  margin: EdgeInsets.all(20.0),
                  width: double.maxFinite,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: <Widget>[
                      IconButton(
                        iconSize: 30.0,
                        icon: Icon(Icons.edit),
                        color: Colors.red,
                        onPressed: () {
                          //navigatetoEdit(id,datacol);
                        },
                      ),
                      IconButton(
                        iconSize: 30.0,
                        icon: Icon(Icons.delete),
                        color: Colors.red,
                        onPressed: () {
                          _deleteuser();
                        },
                      )
                    ],
                  )),
            )
          ],
        ),
      ),
    );
  }
}