

import 'package:connectivity/connectivity.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:shutz_ui/Models/user.dart';
import 'package:shutz_ui/services/dbserv.dart';

class AuthServ{

final FirebaseAuth _auth = FirebaseAuth.instance;
final GoogleSignIn googleSignIn = GoogleSignIn();


  //GOOGLE SIGN IN //
  Future<User> signInWithGoogle() async {

  final GoogleSignInAccount googleSignInAccount = await googleSignIn.signIn();
  final GoogleSignInAuthentication googleSignInAuthentication =
      await googleSignInAccount.authentication;

  final AuthCredential credential = GoogleAuthProvider.getCredential(
    accessToken: googleSignInAuthentication.accessToken,
    idToken: googleSignInAuthentication.idToken,
  );

  final AuthResult authResult = await _auth.signInWithCredential(credential);
  final FirebaseUser user = authResult.user;

  assert(!user.isAnonymous);
  assert(await user.getIdToken() != null);

  final FirebaseUser currentUser = await _auth.currentUser();
  assert(user.uid == currentUser.uid);

  return _userfromfirebase(user);
  }


  // SIGNOUT //
  void signOutGoogle() async{
      
    try {
      await googleSignIn.signOut();
      return await _auth.signOut();
    } catch (error) {
      print(error.toString());
      return null;
    
  }
  }

  //CUSTOM USER MODEL // TERNARY OPERATOR //
  User _userfromfirebase(FirebaseUser user){return user !=null?User(
  uid: user.uid,
  phone:user.phoneNumber,
  pic: user.photoUrl,
  name: user.displayName,
  status: 'Signed In',
  email: user.email):null;}

  //STREAM FOR LISTENING AUTH CHANGES
  Stream<User> get user{return _auth.onAuthStateChanged.map(_userfromfirebase);} 

  Stream<ConnectivityResult> get network{return Connectivity().onConnectivityChanged;} 

}