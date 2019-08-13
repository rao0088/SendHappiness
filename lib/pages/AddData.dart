import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';
import 'package:sendhappiness/Modal/UserData.dart';
import 'package:flutter/services.dart';
import 'package:dropdown_formfield/dropdown_formfield.dart';
import 'package:sendhappiness/Modal/quates.dart';
class AddData extends StatefulWidget {
  final String datacol;
  AddData(this.datacol);

  @override
  _AddDataState createState() => _AddDataState(datacol);
}

class _AddDataState extends State<AddData> {

   String datacol;
  _AddDataState(this.datacol);

   final format = DateFormat("HH:mm");

  //final FirebaseAuth _auth =FirebaseAuth.instance;
  final databaseReference = Firestore.instance;
  String name,phone,message,date,time,status="false";
  String _myActivity;



  saveDATAUser(BuildContext context) async{
    if(_myActivity!=null && name !=null && phone !=null && message!=null && date != null && time!=null && status!=null){

      UserData data = UserData(this._myActivity,this.name,this.phone,this.message,this.date,this.time,this.status);

      await databaseReference.collection(datacol).document()
          .setData(data.toJson());

      navigateToLastScreen(context);


    }else {
      showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text('Error Message'),
              content: Text("All Feild Are Required"),
              actions: <Widget>[
                FlatButton(
                  child: Text('Ok'),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
              ],
            );
          }
      );
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


   navigateToLastScreen(BuildContext context){

    Navigator.of(context).pop();

  }
   DateTime selectedDate = DateTime.now();
   TimeOfDay selectedTime =TimeOfDay.now();

   Future<Null> _selectDate(BuildContext context) async {
     final DateTime picked = await showDatePicker(
         context: context,
         initialDate: selectedDate,
         firstDate: DateTime(2019, 8),
         lastDate: DateTime(2030),
         builder: (context, child) {
           return SingleChildScrollView(
             child: Theme(

                 isMaterialAppTheme: true,
                 data: Theme.of(context).copyWith(primaryTextTheme: TextTheme(display1: TextStyle(fontSize: 25))),

                 child: child
             ),
           );
         }
     );
     if (picked != null && picked != selectedDate)
       setState(() {
         selectedDate = picked;
         date = DateFormat('d MMMM yyyy').format(selectedDate);

       });
   }

   Future<void> _selectTime(BuildContext context) async {
     final TimeOfDay picked =
     await showTimePicker(context: context, initialTime: selectedTime);
     if (picked != null && picked != selectedTime)
     setState(() {
       selectedTime = picked;
       time = selectedTime.format(context);
       //time=DateFormat('h:mm a').format(selectedTime);
       //time=picked.getTime();
     });
   }

   void _loadData() async {
     await QuatesViewModel.loadQuates();
   }

   @override
   void initState() {
     _loadData();
     super.initState();
   }


   @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Add Data"),
      ),
      body: Container(
        child: Padding(
          padding: EdgeInsets.all(20.0),
          child: ListView(
            children: <Widget>[
              //image view

              Container(
                margin: EdgeInsets.only(top: 20.0),
                child:DropDownFormField(
                  titleText: 'Happiness Purpose',
                  hintText: 'Please choose one',
                  value: _myActivity,
                  onSaved: (value) {
                    setState(() {
                      _myActivity = value;
                    });
                  },
                  onChanged: (value) {
                    setState(() {
                      _myActivity = value;
                    });
                  },
                  dataSource: [
                    {
                      "display": "BirthDay",
                      "value": "BirthDay",
                    },
                    {
                      "display": "Marriage Anniversary",
                      "value": "Marriage Anniversary",
                    },
                    {
                      "display": "Others",
                      "value": "Others",
                    },
                  ],
                  textField: 'display',
                  valueField: 'value',
                ),
              ),

              Container(
                margin: EdgeInsets.only(top: 20.0),
                child: TextField(
                  maxLength:20,
                  onChanged: (value) {
                    setState(() {
                      name=value;
                    });
                  },
                  decoration: InputDecoration(
                    labelText: 'Name',
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5.0)),
                  ),
                ),
              ),
              //
//              searchTextField = AutoCompleteTextField<Quates>(
//                  //textAlign: TextAlign.left,
//                //minLength: 30,
//                 keyboardType: TextInputType.multiline,
//                  style: new TextStyle(color: Colors.black, fontSize: 16.0,),
//                  decoration: new InputDecoration(
//                    contentPadding: EdgeInsets.fromLTRB(10.0, 30.0, 10.0, 20.0),
//                    //errorMaxLines: 5,
//                    //filled: true,
//                    labelText:'Message',
//                    //hintStyle: TextStyle(color: Colors.
//                    // black)
//                    border: OutlineInputBorder(
//                        borderRadius: BorderRadius.circular(5.0)),
//                  ),
//                  itemSubmitted: (item) {
//                    setState(() => searchTextField.textField.controller.text =
//                        item.quata);
//                    if(item.quata!=null){
//                      message=item.quata;
//                    }else {
//                      message = searchTextField.textField.controller.text;
//                    }
//                  },
//                  clearOnSubmit: false,
//                  controller: controller,
//                  key: key,
//                  suggestions: QuatesViewModel.quates,
//                  itemBuilder: (context, item) {
//                    return SingleChildScrollView(
//                      //mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                      child:
//                      Text(item.quata,textAlign:TextAlign.left ,
//                        style: TextStyle(
//                          fontSize: 16.0,wordSpacing: 2.0,
//                          fontWeight: FontWeight.bold,
//                          inherit: true,
//                          //height: 20.0
//                        ),),
//                    );
//                  },
//                  itemSorter: (a, b) {
//                    return a.quata.compareTo(b.quata);
//                  },
//                  itemFilter: (item, query) {
//                    return item.quata
//                        .toLowerCase()
//                        .startsWith(query.toLowerCase());
//                  }),
//

              Container(
                margin: EdgeInsets.only(top: 20.0),
                child: TextField(
                  maxLength:10,
                  onChanged: (value) {
                    setState(() {
                      phone =value;
                    });
                  },
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    labelText: 'Sender Phone Number',
                    prefix: Text('+91'),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5.0)),
                  ),
                ),
              ),

              Container(
                margin: EdgeInsets.only(top: 20.0),
                height: 70,
                child:Card(
                  elevation: 1.0,
                  shape: RoundedRectangleBorder(side: BorderSide(width: .5),borderRadius: BorderRadius.circular(5)),
                  child:GestureDetector(
                  onTap: (){
                    _selectDate(context);
                  },
                  child: date == null
                      ? Text('Date: Choose Date Here',strutStyle: StrutStyle(height: 3.0),style: TextStyle(
                    fontSize: 18.0,
                    fontWeight: FontWeight.bold,
                  ),)
                      : Text('Date: $date',style: TextStyle(
                    fontSize: 18.0,
                    fontWeight: FontWeight.bold,
                  ),)
                ),
                ),
              ),
              //time

              Container(
                margin: EdgeInsets.only(top: 30.0),
                height: 70,
                //padding: EdgeInsets.only(top: 20.0),
                child: Card(
                  elevation: 1.0,
                  shape: RoundedRectangleBorder(side: BorderSide(width: .5),borderRadius: BorderRadius.circular(5)),
                  child: GestureDetector(
                    onTap: (){
                      _selectTime(context);
                    },
                    child: time == null
                        ? Text('Time: Choose Send Happiness Time',strutStyle: StrutStyle(height: 3.0),
                      style: TextStyle(

                      fontSize: 16.0,
                      fontWeight: FontWeight.bold,
                      //letterSpacing: 10.0,
                    ),)
                        : Text('Time: $time',style: TextStyle(
                      fontSize: 18.0,
                      fontWeight: FontWeight.bold,
                    ),)
                  ),
                ),

              ),


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
// start here

// end message box here
              Container(
                margin: EdgeInsets.only(top: 20.0),
                child: TextField(
                  onChanged: (value) {
                    setState(() {
                      message =value;
                    });
                  },
                  keyboardType: TextInputType.multiline,
                  maxLines: null,
                  maxLength:140,
                  decoration: InputDecoration(
                    labelText: 'Message',
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5.0)),

                  ),
                ),
              ),
              // update button
              Container(
                padding: EdgeInsets.only(top: 20.0),
                child: RaisedButton(
                  padding: EdgeInsets.fromLTRB(100.0, 20.0, 100.0, 20.0),
                  onPressed: () {
                    saveDATAUser(context);
                  },
                  color: Colors.red,
                  child: Text(
                    "Submit",
                    style: TextStyle(
                      fontSize: 20.0,
                      color: Colors.white,
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
