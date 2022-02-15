import 'package:flutter/material.dart';

class TacheEdit extends StatefulWidget {
  const TacheEdit({ Key? key }) : super(key: key);

  @override
  _TacheEditState createState() => _TacheEditState();
}

class _TacheEditState extends State<TacheEdit> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Modifier la tâche'),
      ),
      body: Container(
        padding: EdgeInsets.only(top: 50,left: 10.0,right:10.0 ),
        child: ListView(
         children: [
           //titre
           TextField(
              obscureText: false,
              decoration: new InputDecoration(
              border: OutlineInputBorder(),
              labelText: "Titre"
              ),
             keyboardType: TextInputType.text,
           ),
           Padding(padding:EdgeInsets.all(10.0) ),
           //description
           TextField(
              obscureText: false,
              decoration: new InputDecoration(
              border: OutlineInputBorder(),
              labelText: "Description"
              ),
             keyboardType: TextInputType.text,
           ),
           Padding(padding:EdgeInsets.all(10.0) ),
           //boutons enregistrer et supprimer
           Row(
             children: [
                ElevatedButton.icon(
                  onPressed: ()=>{
                    print('Boutton enregistrer')
                  }, 
                  icon: Icon(Icons.save), label: Text("Enregistrer")
                  ),
                Padding(padding:EdgeInsets.all(30.0) ),
                ElevatedButton.icon(
                  onPressed: ()=>{
                    print('Boutton annuler')
                  }, 
                  icon: Icon(Icons.redo), label: Text("Annuler")
                  ),
             ],
           )
         ],
        ),
      ),
    );
  }
}

