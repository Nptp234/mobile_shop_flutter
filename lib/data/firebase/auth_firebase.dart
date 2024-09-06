import 'package:firebase_auth/firebase_auth.dart';

class AuthFirebase {
  
  Future<bool> signInWithEmailPassword(String email, String password) async{
    try{
      UserCredential userCredential = await FirebaseAuth.instance.signInWithEmailAndPassword(email: email, password: password);
      return userCredential.user!=null;
    }
    catch(e){
      return false;
    }
  }

  Future<bool> createUserWithEmailPassword(String email, String password) async{
    try{
      UserCredential userCredential = await FirebaseAuth.instance.createUserWithEmailAndPassword(email: email, password: password);
      return userCredential.user!=null;
    }catch(e){
      return false;
    }
  }

  Future<bool> checkAuth(String email, String password) async{
    try{
      bool isAuth = await createUserWithEmailPassword(email, password);
      if(!isAuth){
        isAuth = await signInWithEmailPassword(email, password);
        return isAuth;
      }else{return true;}
    }
    catch(e){
      return false;
    }
  }
}