import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final FirebaseAuth _auth =FirebaseAuth.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn();

  checkAuthentication()async{

    _auth.onAuthStateChanged.listen((user) async{
      if(user!=null){

        Navigator.pushReplacementNamed(context, "/");

      }
    });
  }

  Future<FirebaseUser> _handleSignIn() async {
    final GoogleSignInAccount googleUser = await _googleSignIn.signIn();
    final GoogleSignInAuthentication googleAuth = await googleUser.authentication;

    final AuthCredential credential = GoogleAuthProvider.getCredential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );

    final FirebaseUser user = (await _auth.signInWithCredential(credential)).user;
    print("signed in " + user.displayName);

    // print(user);
    try{
      if(user !=null){

        //return user;
        print("signed in " + user.displayName);
      }
    }catch(e){

      showError(e.message);

    }
    return user;

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



  @override
  void initState(){
    super.initState();
    this.checkAuthentication();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Container(
        padding: EdgeInsets.fromLTRB(10,10,10,10),
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Container(
                child: Text('Send Happiness',style: TextStyle(
                  fontFamily:'Signatra',
                  fontSize: 55.0,
                  color: Theme.of(context).primaryColor,
                ),),
              ),
              Container(
                padding: EdgeInsets.all(16.0),
                child: Column(
                  children: <Widget>[
                    Container(
                      padding:EdgeInsets.fromLTRB(20,10,20,10),
                      child: ButtonTheme(
                        minWidth: 50.0,
                        height: 70.0,
                        child: RaisedButton.icon(
                          color: Theme.of(context).primaryColor,
                          elevation: 5.0,
                          onPressed:(){
                            _handleSignIn()
                                .then((FirebaseUser user) => print(user))
                                .catchError((e) => print(e));
                          },
                          icon: Icon(FontAwesomeIcons.google,color:Theme.of(context).accentColor,size: 40.0,),
                          label: Text('Sign In With Google',style: TextStyle(
                            color: Colors.white,
                            fontSize: 15.0,
                          ),),
                        ),
                      ),
                    ),
                    Container(
                      child: Text(
                        'App Created By Ajeet Singh',style: TextStyle(
                        fontSize: 9.0,
                        fontWeight: FontWeight.bold,
                      ),
                      ),
                    )
                  ],
                ),
              ),

            ],
          ),
        ),
      ),
    );
  }
}
