
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_5/main.dart';
import 'page1.dart';
//page d'authentification
class Login extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Login page',
      theme:new ThemeData(
        primarySwatch: Colors.blueGrey,
      ),
      debugShowCheckedModeBanner: false,
      home: LoginPage(),
      routes: <String, WidgetBuilder>{
        '/Home' :(BuildContext context) => new MyHomePage(title: 'Accueil'),
      },
    );
  }
}
class LoginPage extends StatefulWidget {
  const LoginPage({ Key? key }) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  final emailController = TextEditingController();
  final passwdController = TextEditingController();
  final FirebaseAuth _auth = FirebaseAuth.instance;
  bool showSignIn =true;

   @override
  void dispose(){
    emailController.dispose();
    passwdController.dispose();
    super.dispose();
  }
  @override
  void toogleView(){
    setState(() {
      emailController.text = '';
      passwdController.text = '';
      showSignIn = !showSignIn;
    });
  }
  Future<FirebaseApp> _initializeFirebase() async {
    FirebaseApp firebaseApp = await Firebase.initializeApp();
    return firebaseApp;
}
//appelles aux identifiants de la BD firebase
  Future loginCredentials(String email,String passwd) async{
    try{
      UserCredential result = await _auth.signInWithEmailAndPassword(email: email, password: passwd); 
      var user = result.user;   
      return user;
      }catch(exception){
      print(exception.toString());
      return null;
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blueGrey,
        title: Text(showSignIn ? 'Login Page' : 'Sign Up',style: TextStyle(fontSize: 20.0,color: Colors.white)),
        actions: <Widget>[
          TextButton.icon
          (onPressed: ()=>toogleView(),
          icon: Icon(Icons.person),
          label: Text(showSignIn ? 'Sign Up':'Login Page',style: TextStyle(fontSize: 20.0,color: Colors.white)),
           )
        ],
      ),
      body: FutureBuilder(
        future:_initializeFirebase() ,
        builder: (context,snapshot){
          if(snapshot.connectionState == ConnectionState.done){
            return Container(
          child: Form(
            key: _formKey,
            child: Column(
              children:<Widget>[ 
              padding(),
              TextFormField(
                
                controller: emailController,
                validator: (value)=>value!.isEmpty ? 'Entrer un email':null,
                //caractères non masqués
                obscureText: false,
                decoration: new InputDecoration(
                border: OutlineInputBorder(),
                labelText: "Email :"
                ),
                keyboardType: TextInputType.emailAddress,
              ),
              SizedBox(height: 10.0,),
              padding(),
              TextFormField(
                controller: passwdController,
                validator: (value)=>value!.length < 6 ? 'Le mot de passe doit contenir au moins 6 caractères ' :null,
                //caractères masqués
                obscureText: true,
                decoration: new InputDecoration(
                border: OutlineInputBorder(),
                labelText: "Password :"
                ),
                keyboardType: TextInputType.text,
              ),
              ElevatedButton(
                onPressed: () async{
                  if(_formKey.currentState!.validate()){
                    //var user = await FirebaseAuth.instance.signInWithEmailAndPassword(email: emailController.value.text, password: passwdController.value.text);
                    var user =loginCredentials(emailController.value.text,passwdController.value.text);
                    if(user !=null)
                      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>MyHomePage(title: 'Accueil')));
                  }else{
                  //  loginCredentials(emailController.value.text,passwdController.value.text);
                  }
                },
                child: Text(showSignIn ? 'Connect' : 'Sign Up',style: TextStyle(fontStyle: FontStyle.italic,
                  fontSize: 20.0,color: Colors.white)),
                /*child: new Text('Connect',
                style: new TextStyle(
                  fontStyle: FontStyle.italic,
                  fontSize: 20.0,
                ),),*/
              ),
              ],
            ),
          ),
        );
          }
           return Center(
            child: CircularProgressIndicator(),
          );
        }
      ),
    );
  }
}