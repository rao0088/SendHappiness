import 'package:cloud_firestore/cloud_firestore.dart';
class UserData{
  String _id;
  String _name;
  String _phone;
  String _message;
  String _date;
  String _time;
  String _status;
  String _myActivity;

  // construster for  adding data

  UserData(this._myActivity,this._name,this._phone,this._message,this._date,this._time,this._status,);

  // construster for  Editing  data

  UserData.withId(this._id,this._myActivity,this._name,this._phone,this._message,this._date,this._time,this._status);

  //getter  for data getting

  String get id => this._id;
  String get myActivity=>this._myActivity;
  String get name => this._name;
  String get phone => this._phone;
  String get message => this._message;
  String get date => this._date;
  String get time => this._time;
  String get status => this._status;

  // setters

  set name(String name){
    this._name = name;
  }
  set myActivity(String myActivity){
    this._myActivity = myActivity;
  }

  set phone(String phone){
    this._phone = phone;
  }

  set message(String message){
    this._message = message;
  }

  set status(String status){
    this._status = status;
  }
  set date(String date){
    this._date = date;
  }

  set time(String time){
    this._time = time;
  }


  UserData.fromDocument(DocumentSnapshot doc){

    this._id = doc['id'];
    this._myActivity=doc['myActivity'];
    this._name=doc['name'];
    this._phone=doc['phone'];
    this._message= doc['message'];
    this._date= doc['date'];
    this._time= doc['time'];
    this._status= doc['status'];

  }

  Map<String, dynamic> toJson(){
    return{
      "name": _name,
      "myActivity":_myActivity,
      "phone":_phone,
      "message":_message,
      "date":_date,
      "time":_time,
      "status":_status

    };

  }


}