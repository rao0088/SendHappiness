import 'dart:async';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firestore_ui/animated_firestore_list.dart';
import 'package:intl/intl.dart';
import 'package:sendhappiness/pages/AddData.dart';
import 'package:sendhappiness/pages/ViewUserData.dart';
import 'package:sms/sms.dart';
//import 'package:sendhappiness/Modal/UserData.dart';
//import 'package:android_alarm_manager/android_alarm_manager.dart';
class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final FirebaseAuth _auth =FirebaseAuth.instance;
  final databaseReference = Firestore.instance;
  DocumentSnapshot snapshot;
        Timer timer;
        String date;
        String time;
        String timedata;
        String messages;
        String phone;
        String status;
        String datacol;
        String id;
       DateTime  open;
       DateTime  closed;
  FirebaseUser user;
  bool isSignedIn= false;
  DateFormat dateFormat = new DateFormat.jm();
  DateTime now = new DateTime.now();
  String formattedDate = DateFormat('d MMMM yyyy').format(DateTime.now());
  //String formattedtime = DateFormat('h:mm a').format(DateTime.now());
  
  sendsms(date,timedata,messages,phone,status,datacol,id,open,closed)async{
     if(date==formattedDate&&status =='false'){
       try{
         SmsSender sender = new SmsSender();
         String address = '+91$phone';
         SmsMessage message = new SmsMessage(address, '$messages');
         message.onStateChanged.listen((state) {
           if (state == SmsMessageState.Sent) {
             print("SMS is sent!");
           } else if (state == SmsMessageState.Delivered) {
             print("SMS is delivered!");
           }
         });
         sender.sendSms(message);
         await databaseReference.collection(datacol).document(id).updateData({'status':'true'});

       }catch(e){

         showError(e.error); 

       }
     }
  }

//  sendSmsdata() async{
//    final int helloAlarmID = 0;
//    await AndroidAlarmManager.initialize();
//    await AndroidAlarmManager.periodic(const Duration(minutes: 1), helloAlarmID,sendsms(date,time,messages,phone,status,datacol,id));
//
//  }

  checkAuthentication() async {
    _auth.onAuthStateChanged.listen((user){
      if(user==null){
        Navigator.pushReplacementNamed(context, "/LoginPage");
      }

    });
  }

  getUser() async{
    FirebaseUser firebaseUser =await _auth.currentUser();
    await firebaseUser?.reload();
    firebaseUser = await _auth.currentUser();

    if(firebaseUser !=null){
      setState(() {
        this.user = firebaseUser;
        this.isSignedIn = true;
      });
    }
  }


  navigateToAddUser(datacol){
    Navigator.push(context, MaterialPageRoute(builder: (context){
      return AddData(datacol);
    }));
  }

  navigateToViewUser(id,datacol){
    Navigator.push(context, MaterialPageRoute(builder: (context){
      return ViewUser(id,datacol);
    }));
  }

  signOut() async{
    _auth.signOut();
  }
 var snedsmsDatas;

  _checkStatus()async{
    if(user.email !=null){
      // ignore: unused_local_variable
      String time = DateFormat('h:mm a').format(DateTime.now());
      await databaseReference.collection(user.email).where('status', isEqualTo: 'false')
          .getDocuments().then((QuerySnapshot datasnapshot){
            datasnapshot.documents.forEach((datastatus){
              if(datastatus.documentID.isNotEmpty) {
                id=datastatus.documentID;
                setState(() {
                  timedata = datastatus.data['time'];
                  phone =datastatus.data['phone'];
                  date = datastatus.data['date'];
                  status =datastatus.data['status'];
                  messages =datastatus.data['message'];
                  datacol= user.email;
                });
                _timecheck(date,timedata,messages,phone,status,datacol,id,);
              }

            });
      });
    }

  }
  _checkupdatedatas(){
    _checkStatus();
  }
  _timecheck(date,timedata,messages,phone,status,datacol,id,){
    if( timedata != null){
      DateTime open = dateFormat.parse(timedata);
      String time = DateFormat('h:mm a').format(DateTime.now());
      open = new DateTime(now.year, now.month, now.day, open.hour, open.minute);
      DateTime closed = dateFormat.parse(time);
      closed = new DateTime(now.year, now.month, now.day, closed.hour, closed.minute);
       print("$timedata");
      if(open.isBefore(closed) && date == formattedDate){
        print('true phone:$phone message:$messages : time $timedata datacol:$datacol id: $id date: $date status:$status');

        sendsms(date,timedata,messages,phone,status,datacol,id,open,closed);
      }else{
        print('false');
        print ('true $open  time: $closed');
      }
    }
 }
  @override
  void initState(){
    super.initState();
    this.checkAuthentication();
    this.getUser();
    //this._timecheck();
    timer = Timer.periodic(Duration(seconds: 15), (Timer t) => _checkupdatedatas());
    if(!isSignedIn) {
      print( 'waiting');
    }else{
      this._checkupdatedatas();
    }

  }


  showError(String errorMessage){
    showDialog(
        context: context,
        builder: (BuildContext context){
          return AlertDialog(
            title: Text('Error Message'),
            content: Text(errorMessage),
            actions: <Widget>[
              FlatButton(
                child: Text('Ok'),
                onPressed: (){
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        }
    );
  }



  _deleteuser(datacol,id)async{

    //print("no:$index,datacol:$datacol,id:$id");
//      setState(() {
//        snapshot.data.remove(index);
//      });

      await databaseReference.collection(datacol).document(id).delete();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(


      appBar: AppBar(
        title: Text('Send Happiness',style: TextStyle(color: Colors.white),),
      ),

      drawer: !isSignedIn?CircularProgressIndicator()
          : Drawer(
        elevation: 3.0,
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
//           DrawerHeader(
//             child: Text('Drawer Header'),
//             decoration: BoxDecoration(
//               color:Colors.green,
//             ),
//           ),
            UserAccountsDrawerHeader(
              accountName: Text(user.displayName),
              accountEmail: Text(user.email),
              currentAccountPicture: CircleAvatar(
                backgroundColor:
                Theme.of(context).accentColor,
                child: Text(
                  user.displayName[0].toUpperCase(),
                  style: TextStyle(fontSize: 40.0),
                ),
              ),
            ),
            Container(
              //color: Theme.of(context).primaryColor,
              padding: EdgeInsets.fromLTRB(30.0,20.0,30.0,20.0),
              child: RaisedButton.icon(
                  color: Theme.of(context).primaryColor,
                  onPressed: signOut, icon: Icon(Icons.account_circle), label: Text('Logout')),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        tooltip: 'ADD',
        elevation: 5.0,
        onPressed: (){
          //print('click floating');
          navigateToAddUser(user.email);
        },
        child: Icon(Icons.add_circle),
      ),
      body: !isSignedIn?
      Center(child: CircularProgressIndicator())
          : Container(

        child: FirestoreAnimatedList(
          query: databaseReference.collection(user.email).snapshots(),
          itemBuilder: (
              BuildContext context,
              DocumentSnapshot snapshot,
              Animation<double> animation,
              int index){
            return Dismissible(
               background: Container(color: Theme.of(context).primaryColor),
              key: Key(snapshot.documentID.toString()),
                    onDismissed:(direction){
                      _deleteuser(user.email,snapshot.documentID);
                      Scaffold.of(context)
                          .showSnackBar(SnackBar(content: Text("${snapshot.data['name']} Deleted")));
                      snapshot.data.remove(index);
                    } ,
              child: Card(
                color: Colors.white,
                elevation: 3.0,
                child: ListTile(
//                  leading: CircleAvatar(
//                    child: Text('${snapshot.data[''][0].toUpperCase()}'),
//                    backgroundColor: Theme.of(context).accentColor,
//                  ),
                leading: Icon(Icons.message,color: snapshot.data['status']=='false'? Theme.of(context).accentColor : Theme.of(context).primaryColor,),
                  title: Text('${snapshot.data['myActivity'].toUpperCase()}',
                    style: TextStyle(color: Theme.of(context).primaryColor,fontWeight:FontWeight.bold,fontSize: 20.0)),
                  subtitle: Text('${snapshot.data['name'].toUpperCase()}\nDate: ${snapshot.data['date']}'),
                  trailing:snapshot.data['status']=='false'? Text('Pending',style: TextStyle(color:Theme.of(context).accentColor),)
                      : Text('Sent',style: TextStyle(color:Theme.of(context).primaryColor)),
                   onTap: (){
                    navigateToViewUser(snapshot.documentID, user.email);
                   },
                ),
              ),
            );
          },
        ),

      ),

    );
  }
}
