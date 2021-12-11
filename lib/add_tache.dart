import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class NewTache extends StatefulWidget {
  const NewTache({ Key? key }) : super(key: key);

  @override
  _NewTacheState createState() => _NewTacheState();
}

class _NewTacheState extends State<NewTache> {
  var hr =DateTime.now().hour;
  int sc = DateTime.now().minute;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Tâche'),
      ),
      body: Column(
        children: [
          Container(
            padding: EdgeInsets.fromLTRB(0.0, 10.0, 10.0, 5.0),
            //child: Text('$hr '":"'$sc'),
            child: Text('$hr'":"' $sc', textAlign: TextAlign.left,),
          ),
          Container(
            child: TextField(
              obscureText: false,
              decoration: new InputDecoration(
              labelText: "Titre"
              ),
             keyboardType: TextInputType.text,
             //controller: ,
            ),
          ),
          Container(
            child: TextField(
              obscureText: false,
              decoration: new InputDecoration(
              hintMaxLines: 20,
              labelText: "Prendre une note"
              ),
             keyboardType: TextInputType.text,
             // controller: ,
          ),
          ),
          //bouton enregistrer
          /*Container(
            child: ElevatedButton.icon(
              onPressed: onPressed, icon: icon, label: label),
          )*/
        ],
      ),
    );
  }
}