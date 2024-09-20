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
    } catch (e) {
      // print('Error signing in with Google: $e');
      return false; // Return false if there's an error or login fails
    }
  }
}

class GoogleSignInProvider {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn();

  // Sign in with Google
  Future<User?> signInWithGoogle() async {
    try {
      // Start the Google Sign-In flow
      final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();

      if (googleUser == null) {
        // The user canceled the sign-in
        return null;
      }

      // Get the authentication details from the request
      final GoogleSignInAuthentication googleAuth =
          await googleUser.authentication;

      // Create a new credential
      final OAuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      // Sign in to Firebase with the Google credentials
      final UserCredential userCredential =
          await _auth.signInWithCredential(credential);
      return userCredential.user;
    } catch (e) {
      print("Error signing in with Google: $e");
      return null;
    }
  }

  // Sign out from Google
  Future<void> signOut() async {
    await _googleSignIn.signOut();
    await _auth.signOut();
  }
}
