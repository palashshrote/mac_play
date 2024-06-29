import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthService {

  // Google Sign In
  // signInWithGoogle() async {
  Future<bool> signInWithGoogle() async {
    try {
              // begin interaction sign in process
              final GoogleSignInAccount? gUser = await GoogleSignIn().signIn();
              
            // obtain auth details from request
            final GoogleSignInAuthentication gAuth = await gUser!.authentication;

            //create a new credential for the user
            final credential = GoogleAuthProvider.credential(
              accessToken: gAuth.accessToken,
              idToken: gAuth.idToken,

            );

            //finally lets sign in
            await FirebaseAuth.instance.signInWithCredential(credential);
           return true;
          
    }
      catch (e) {
              print('Error signing in with Google: $e');
              return false; // Return false if there's an error or login fails
    }
  }
 }