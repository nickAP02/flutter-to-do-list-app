import 'package:flutter/foundation.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:async';




class FisrtPage extends StatefulWidget {
  FisrtPage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  _PageState createState() => _PageState();
}

class _PageState extends State<FisrtPage> {
  int radioSelectionne = 0;
  int lowCal=0;
  int hiCal = 0;
  double poids=0.0;
  TextEditingController e=new TextEditingController();
  bool genre = false;
  double age = 0.0;
  Map napActivite = {
    0 : "Faible", 
    1 : "Modéré" ,
    2 : "Forte"  
  };
  double taille = 170.0;
  Color setColor(){
  if(genre==true){
    return Colors.blue;
  }
  if(genre==false){
    return Colors.pink;
  }
  else{
    return Colors.amber;
  }
}
Widget platformSwitcher(){
  if(defaultTargetPlatform == TargetPlatform.iOS){
    return CupertinoSwitch(
    value:genre, 
    activeColor:  Colors.blue,
    onChanged:(bool b){
      setState(() {
        genre = b;
      
      });
    }
    );
  }else{
    return  new Switch(
      value:genre, 
      inactiveTrackColor:  Colors.pink,
      onChanged:(bool b){
        setState(() {
          genre = b;
        
        });
      });
  }
}
void calcCalories(){
  if(age !=0 && poids != 0 && radioSelectionne != null){
    //calculer
    if(genre){
      lowCal = (66.4738 + (13.7516 * poids) + (5.0033 * taille) - (6.7558 * age)).toInt();
    }
    else{
      lowCal = (655.8955 + (9.5634 * poids) + (1.8496 * taille) - (4.6756 * age)).toInt();
    }
    switch(radioSelectionne){
      case 0 :
        hiCal = (lowCal * 1.2).toInt();
        break;
      case 1 :
        hiCal = (lowCal * 1.2).toInt();
        break;
      case 2 :
      hiCal = (lowCal * 1.2).toInt();
      break;
      default :
      hiCal = lowCal;
      break;
    }
    setState(() {
      dialogue();
    });
  }
  else{
    //alerte tous les champs ne sont pas présents
    alerte();
  }
}
Widget body(){
  return  new SingleChildScrollView(
          padding: EdgeInsets.all(15.0),
          child: Column(
             mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              padding(),
              texteAvecStyle("Remplissez tous les champs pour obtenir votre besoin journalier en calories"),
              padding(),
              new Card(
                elevation: 10.0,
                child: new Column(
                  children:<Widget> [
                     new Row(
                       mainAxisAlignment : MainAxisAlignment.spaceEvenly,
                       children : <Widget>[
                         padding(),
                          texteAvecStyle("Femme",color : Colors.pink),
                         platformSwitcher(),
                           texteAvecStyle("Homme",color : Colors.blue),
                       ]
                     ),
                      padding(),
                      ageButton(),
                      padding(),
                      texteAvecStyle("Vous mesurez : ${taille.toInt()} cm",color: setColor()),  
                   new Slider(
                    value: taille,
                    activeColor: setColor(),
                    onChanged: (double d){
                      setState(() {
                        taille = d;
                      });
                    },
                    max: 215.0,
                    min:100.0
                    ),
                    padding(),
                    new TextField(
                      keyboardType: TextInputType.number,
                      onChanged: (dynamic str){
                      setState(() {
                        poids = double.tryParse(e.text)!.toDouble();
                      });
                    },
                    onSubmitted: (dynamic str){
                      setState(() {
                        poids = double.tryParse(e.text)!.toDouble();
                      });
                    },
                    
                    decoration: new InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: "Entrez votre poids en kilos. :"
                    ),
                    controller: e,
                    ),
                    new Text("Votre poids est de : "+e.text.toString()+" kg"),
                    padding(),
                    texteAvecStyle("Niveau d'activté physique :",color: setColor()),
                    padding(),
                    rowRadio(),
                    padding(),
                
                  ],
                ),
              ),
              padding(),
              calcButton()
            ],
          ),
        );
}
Future<Null> dialogue() async{
  return showDialog(
    context: context, 
    builder: (BuildContext buildContext){
      return SimpleDialog(
        title: texteAvecStyle("Votre besoin en calories",color: setColor()),
        contentPadding:EdgeInsets.all(15.0),
        children:<Widget> [
          padding(),
          texteAvecStyle("Votre besoin de base est de : $lowCal kCal"),
          padding(),
          texteAvecStyle("Votre besoin énergétique est de : $hiCal kCal"),
          new TextButton(
            onPressed: (){
              Navigator.pop(buildContext);
            }, 
            child: texteAvecStyle("OK",color: setColor()),
            
            )
        ],
      );
    }
    );
}
Future<Null> alerte() async{
  return showDialog(
    barrierDismissible: false,
    context: context,
    builder: (BuildContext buildcontext){
      return new AlertDialog(
        title: texteAvecStyle("Erreur",color: setColor()),
        content: texteAvecStyle("Veuillez renseignez tous les champs", color: Colors.black87),
        actions:<Widget> [
          new TextButton(
            onPressed: (){
              Navigator.pop(buildcontext);
            },
          child: texteAvecStyle("OK",color: Colors.red[400])
          ),
        ],
       );
    }
  );
}
Future<Null> montrerPicker() async{
  var choix = await  showDatePicker(
      context: context,
      initialDatePickerMode: DatePickerMode.year,
      initialDate: new DateTime.now(),
      firstDate: new DateTime(1900),
      lastDate: new DateTime.now(),
      );
      if(choix != null){
        var diff = new DateTime.now().difference(choix);
        var jours = diff.inDays;
        var ans = (jours/365);
        setState(() {
          age = ans; 
        });
      }
}
Widget calcButton(){
  if(defaultTargetPlatform == TargetPlatform.iOS){
    return new CupertinoButton(
      child: texteAvecStyle("Calculer",color: Colors.white), 
      onPressed:(){
        calcCalories();
      }
    );
  }else{
    return new ElevatedButton(
      style: ElevatedButton.styleFrom(
        primary:  setColor()
      ), 
        child: texteAvecStyle("Calculer",color: Colors.white),
        onPressed: (){
          calcCalories();
        },
    );
  }
}
Widget ageButton(){
  if(defaultTargetPlatform == TargetPlatform.iOS){
    return new CupertinoButton(
      child: texteAvecStyle(
        (age == 0)?"Appuyez pour entrer votre âge" : "Vous avez : ${age.toInt()} ans",
      color: Colors.white
      ),
     color: setColor(),
      onPressed: (()=>montrerPicker()),
    );
  }else{
    return  new ElevatedButton(
      child: texteAvecStyle(
        (age == 0)?"Appuyez pour entrer votre âge" : "Vous avez : ${age.toInt()} ans",
      color: Colors.white
      ),style: ElevatedButton.styleFrom(
        primary:  setColor()
      ),
      onPressed: (()=>montrerPicker()),
    );
  }
}
Row rowRadio(){
  List<Widget> l = [];
  napActivite.forEach(
    (key,value) {
    Column colonne = new Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children:<Widget> [
        new Radio(
          activeColor: setColor(),
          value: key,
           groupValue: radioSelectionne,
            onChanged: (dynamic i){
              setState(() {
                 radioSelectionne =  i;
              });
            }), 
          texteAvecStyle(value, color: setColor())
      ],
    );
    l.add(colonne);
  }
  );
  return new Row(
    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
    children:l);
}
  @override
  Widget build(BuildContext context) {
   
    return GestureDetector(
      onTap: (()=>FocusScope.of(context).requestFocus(new FocusNode())),
      child: (defaultTargetPlatform == TargetPlatform.iOS) ?
      new CupertinoPageScaffold(
        navigationBar: new CupertinoNavigationBar(
          backgroundColor: setColor(),
          middle: texteAvecStyle(widget.title),
        ),
        child: body()):
        Scaffold(
        appBar: AppBar(
          title: Text(widget.title),
          backgroundColor:  setColor(),
        ),
        body:body(),
      ),
    );
  }
} 

Padding padding(){
  return new Padding(padding: EdgeInsets.only(top: 20.0));
}

Text texteAvecStyle(String data, {color : Colors.black,fontSize : 15.0}){
  return new Text(
    data,
    textAlign: TextAlign.center,
    style: new TextStyle(
      color: color,
      fontSize: fontSize
    ),
  );
}