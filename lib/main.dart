import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_5/add_tache.dart';
import 'package:flutter_application_5/edit_tache.dart';
import 'package:flutter_application_5/liste_taches.dart';
import 'package:flutter_application_5/splash_screen.dart';
import 'page1.dart';
import 'page2.dart';
Future<void> main() async {
    WidgetsFlutterBinding.ensureInitialized();
    await Firebase.initializeApp();
    runApp(MyApp());
}

class MyApp extends StatelessWidget {
 final MaterialColor white = const MaterialColor(
  0xFFFFFFFF,
  const <int, Color>{
    50: const Color(0xFFFFFFFF),
    100: const Color(0xFFFFFFFF),
    200: const Color(0xFFFFFFFF),
    300: const Color(0xFFFFFFFF),
    400: const Color(0xFFFFFFFF),
    500: const Color(0xFFFFFFFF),
    600: const Color(0xFFFFFFFF),
    700: const Color(0xFFFFFFFF),
    800: const Color(0xFFFFFFFF),
    900: const Color(0xFFFFFFFF),
  },);
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Accueil',
      theme:new ThemeData( 
        primarySwatch: Colors.blueGrey,
      ),
      debugShowCheckedModeBanner: false,
      home: SplashScreen(),
      routes: <String, WidgetBuilder>{
        '/First' :(BuildContext context) => new FisrtPage(title: 'Calories calc'),
        '/Second' :(BuildContext context) => new MyPage(title: 'Music app'),

      },
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key? key, required this.title}) : super(key: key);
  
  int i=0;
  final String title;
  

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
final userEmail = FirebaseAuth.instance.currentUser!.email.toString();
final userName = FirebaseAuth.instance.currentUser!.displayName.toString();

  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
      appBar: AppBar(
        title: Text('Liste des tâches'),
      ),
      //barre de navigation 
      drawer: new Drawer(
        child:  new ListView(
          children: [
          new UserAccountsDrawerHeader(

                accountName: new Text(userName), 
                accountEmail: new Text(userEmail),
                currentAccountPicture: new CircleAvatar(backgroundImage: AssetImage("assets/\images/\profileImage.jpg"),
               ),
                 
            ),
        
              new ListTile(
                title: new Text('Calculateur de calories'),   
                trailing: new Icon(Icons.arrow_right_alt_outlined),
               onTap: ()=>Navigator.of(context).pushNamed('/First'),
              ),
              new ListTile(
                title: new Text('Lecteur de musique'), 
                trailing: new Icon(Icons.arrow_right_alt_outlined),
                onTap: ()=>Navigator.of(context).pushNamed('/Second'),
              ),
              new Divider(),
              new ListTile(
                title: new Text('Sortie'), 
                trailing: new Icon(Icons.logout),
                onTap: ()=>Navigator.of(context).pop(),
              ),
          ],
        ),
      ),
      body: Center(
        //liste des notes
        child: ListView.builder(
          itemCount: tachesList.length,
          itemBuilder: (context, int i){
            return Card(
              color: Colors.white,
              elevation: 2.0,
              child: ListTile(
                leading: Icon(tachesList[i].icone),
                title: Text(tachesList[i].titre,style: TextStyle(color: Colors.black12, fontSize: 25),),
                subtitle: Text(tachesList[i].date,style: TextStyle(color: Colors.black12,fontSize: 10)),
                /*onTap: ()=>SnackBar(
                  content: Text('L\'évènement a été supprimé'),
                  duration: Duration(milliseconds: 1200),
                  width: 200.0,
                  padding: EdgeInsets.symmetric(
                    horizontal: 10.0
                  ),
                  behavior: SnackBarBehavior.floating,
               */
              onTap: (){
                Navigator.push(context, MaterialPageRoute(builder: (context){
                  return TacheEdit();
                }));
              },),
              );
          },
        )
        ),
        //boutton d'ajout
        floatingActionButton: FloatingActionButton(
          child: Icon(Icons.add) ,
          onPressed: ()=>{
            Navigator.push(context, MaterialPageRoute(builder: (context){
               return NewTache();
            })),
          }
        ),
      );
  }
}