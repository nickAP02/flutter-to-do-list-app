import 'dart:async';
// ignore: import_of_legacy_library_into_null_safe
import 'package:audioplayer/audioplayer.dart';
import 'package:flutter/material.dart';
import 'musique.dart';

enum ActionMusic{
    play,
    pause,
    rewind,
    forward
  }
  enum PlayerState{
    playing,
    stopped,
    paused
  }

class MyPage extends StatefulWidget {
  MyPage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  _MyPageState createState() => _MyPageState();
}

class _MyPageState extends State<MyPage> {
 List<Musique> myMusic = [
   new Musique('Mon coeur','Glorya Reliques','assets\/music\/cover3.jpg','https://firebasestorage.googleapis.com/v0/b/myfirstproject-2f813.appspot.com/o/(3)%20Glorya%20Reliques%20-%20Mon%20Coeur%20(Clip%20Officiel)%20-%20YouTube.mkv?alt=media&token=bc881a41-73a1-4e8d-8a44-fd4323b73054'),
   new Musique('Love de toi', 'Holocaust', 'assets\/music\/cover2.jpg', 'https://firebasestorage.googleapis.com/v0/b/myfirstproject-2f813.appspot.com/o/(3)%20LOVE%20DE%20TOI%20-%20HOLOCAUST%20MUSIC%20(Lyrics)%20_%20ALBUM%20HOLY%20VIBES%20-%20YouTube.mkv?alt=media&token=67d9ee29-0932-4a9e-9442-e3e572a8fe5d'),
   new Musique('Né dzo', 'Omar B', 'assets\/music\/cover1.jpg', 'https://firebasestorage.googleapis.com/v0/b/myfirstproject-2f813.appspot.com/o/(3)%20OMAR%20B%20-%20NEDJO.by%20FANGA%20MUSIC%20-%20YouTube.mkv?alt=media&token=e6827f7a-673f-4696-a7ca-8421dfcab5b5'),
   new Musique('Bako sala éloko té', 'Nadège Mbuma', 'assets\/music\/cover3.jpg', 'https://firebasestorage.googleapis.com/v0/b/myfirstproject-2f813.appspot.com/o/(3)%20Nad%C3%A8ge%20Mbuma%20-%20Bako%20Sala%20Eloko%20Te%20%5BOfficial%20Audio%5D%20-%20YouTube.mkv?alt=media&token=9d8bb167-f4cd-474e-a1cb-dc725d7ad646')
 ];

 Musique myActualMusic = new Musique('Love de toi', 'Holocaust', 'assets\/music\/cover2.jpg', 'https://open.spotify.com/track/51K71t2Sk90AVbjVsBcorb');
 Duration position = Duration();
 AudioPlayer audioPlayer = AudioPlayer();
 Duration duree = Duration();
 int index = 0;
 PlayerState statut = PlayerState.stopped;
 @override
 void initState(){
   super.initState();
   myActualMusic = myMusic[0];
   audioplayerConfig();
 }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        centerTitle: true,
      ),
      backgroundColor: Colors.grey,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
           new Card(
             elevation: 9.0,
              child: new Container(
                width: MediaQuery.of(context).size.width/2,
                child: new Image.asset(myActualMusic.coverImage,
                fit: BoxFit.cover,
                ),
             ),
           ),
           textAvecStyle(myActualMusic.titre, 1.5),
           textAvecStyle(myActualMusic.artist, 1.0),
            new Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                bouton(Icons.fast_rewind,30.0,ActionMusic.rewind),
                bouton((statut == PlayerState.playing) ?Icons.pause : Icons.play_arrow,45.0,(statut == PlayerState.playing) ?ActionMusic.pause : ActionMusic.play),
                bouton(Icons.fast_forward,30.0,ActionMusic.forward)
              ],
            ),
            new Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children:<Widget> [
                 textAvecStyle(fromDuration(position), 0.8),
                 textAvecStyle(fromDuration(duree), 0.8),
              ],
            ),
            new Slider(
              value: position.inSeconds.toDouble(),
              min: 0.0,
              max: audioPlayer.duration.inSeconds.toDouble(),
              inactiveColor: Colors.white,
              activeColor: Colors.green[100],
              onChanged:(double d){
                setState(() {
                  audioPlayer.seek(d);
                });
              },
            ),
          ],
        ),
      ),
    );
  }
  IconButton bouton(IconData icone,double taille, ActionMusic action){
  
    return new IconButton(
      iconSize: taille,
      color: Colors.white,
      icon: new Icon(icone),
      onPressed: (){
        switch(action) {
          case ActionMusic.play:
            play(); 
            break;
          case ActionMusic.pause:
            pause();
            break;
          case ActionMusic.forward:
            forward();
            break;
          case ActionMusic.rewind:
            rewind();
            break;
        }
      });
  }
  Text textAvecStyle(String data, double scale) {
    return new Text(
      data,
      textScaleFactor: scale,
      style: new TextStyle(
        color: Colors.white,
        fontSize: 20.0,
        fontStyle: FontStyle.italic,
      ),
    );
  }
   void audioplayerConfig(){
     //audioPlayer = new AudioPlayer();
    StreamSubscription subscription;
    StreamSubscription sub;
    subscription = audioPlayer.onAudioPositionChanged.listen(
      (state) => setState(() => position = state)
    );
    sub = audioPlayer.onPlayerStateChanged.listen((event) {
      if(event == AudioPlayerState.PLAYING){
        setState(() {
          duree = audioPlayer.duration;
        });
      }
      else if(event == AudioPlayerState.STOPPED){
        setState(() {
          statut = PlayerState.stopped;
        });
      }
    }
    , onError: (message){
       print('erreur: $message');
       setState(() {
         statut =PlayerState.stopped;
         duree = Duration(seconds: 0);
         position = Duration(seconds: 0);
       });
    }
    );
   }
   Future play() async{
     await audioPlayer.play(myActualMusic.urlSong);
     setState(() {
       statut = PlayerState.playing; 
     }); 
   }
    Future pause() async{
     await audioPlayer.pause();
     setState(() {
       statut = PlayerState.paused; 
     }); 
   }
   void forward(){
     if(index==myMusic.length - 1){
        index = 0;
     }
     else{
       index ++;
     }
     myActualMusic = myMusic[index];
     audioPlayer.stop();
     audioplayerConfig();
   }
   void rewind(){
     if(position > Duration(seconds: 3)){
       audioPlayer.seek(0);
     }
     else{
       if(index==0){
        index = myMusic.length - 1;
       }
       else{
         index --;
       }
     }
     myActualMusic = myMusic[index];
     audioPlayer.stop();
     audioplayerConfig();
     play();
   }
   String fromDuration(Duration duree){
     return duree.toString().split('.').first;
   }
}
