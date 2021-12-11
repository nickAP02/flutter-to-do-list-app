import 'package:flutter/material.dart';
//création de la classe taches
//manipules les données
//les méthodes de cette classe permettent de récuperer les données 
class Taches{
  int id=0;
  String titre='';
  String description='';
  String date='';
  IconData icone=Icons.dashboard;

  int get _id =>id;
  String get _titre =>titre;
  String get _description =>description;
  String get _date =>date;
  IconData get _icone => icone;
 
  void set _id(int _id){
    this._id = id;
  }
  void set _titre(String _titre){
    this._titre = titre;
  }
  void set _description(String _description){
    this._description = description;
  }
   void set _date(String _date){
    this._date = date;
  }
  void set _icone(IconData _icone){
    this._icone = Icons.run_circle_rounded;
  }
  Map<String,dynamic> toMap(){
    var map = Map<String,dynamic>();
    if(id !=0){
      map['id'] = id;
    }
    map['titre'] = titre;
    map['description'] = description;
    map['date'] = date;
    map['icone'] = icone;
    return map; 
  }
 Taches.fromMapObject(Map<String,dynamic> map){
   this.id =  map['id'];
   this.titre =  map['titre'];
   this.description = map['description'];
   this.date = map['date'];
    this.icone = map['icone'];
 }
 /*Tache(){
   this.id;
   this.titre;
   this.description;
   this.date;
   this.icone;
 }*/
  Taches(int _id,String _titre,String _description,String _date, IconData _icone)
  {
    this.id=_id;
    this.titre=_titre;
    this.description=_description;
    this.date=_date;
    this.icone = _icone;
  }
  
}