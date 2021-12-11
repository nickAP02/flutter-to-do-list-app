import 'package:firebase_auth/firebase_auth.dart';
//cette classe permet d'authentifier un utilisateur
class Authenticate{
  final FirebaseAuth _auth = FirebaseAuth.instance;
 /* UserById getUserByid(User user){
    return user !=null ? UserById(user.uid) : null;
  }
  Stream<UserById> get user {
    return _auth.authStateChanges().map(getUserByid);
  }*/
  //connexion de l'utilisateur
  Future loginCredentials(String email,String passwd) async{
    try{
      await _auth.signInWithEmailAndPassword(email: email, password: passwd); 
      return "user signed in";
      }catch(exception){
      print(exception.toString());
      return null;
    }
  }
  // création d'un compte utilisateur
  /*Future registerCredentials(String email,String passwd) async{
    try{
      UserCredential result = await _auth.createUserWithEmailAndPassword(email: email, password: passwd); 
      var user = result.user;   
      return user;
      }catch(exception){
      print(exception.toString());
      return null;
    }
  }*/
  //déconnexion de l'utilisateur
  Future signOut(String email,String passwd) async{
    try{
      return await _auth.signOut(); 
    }catch(exception){
      print(exception.toString());
      return null;
    }
  }
}
