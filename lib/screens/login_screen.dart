import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import '../helper/helper.dart';
import '../widgets/custom_button.dart';
import '../widgets/custom_text_field.dart';
import 'home_screen.dart';

class LoginScreen extends StatefulWidget {
    LoginScreen({super.key});
    String id = 'login';

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {

    final GlobalKey<FormState> _formKey = GlobalKey();
    String? email;
    String? password;
    bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    return ModalProgressHUD(
      inAsyncCall: isLoading,
      child: Scaffold(
        backgroundColor: Colors.grey[300],
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0.0,
        ),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Center(
            child: SingleChildScrollView(
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Center(child: Icon(Icons.lock, size: 120.0, color: Colors.grey[800])),
                    const SizedBox(
                      height: 100.0,
                    ),
                    Center(
                      child:  Text(
                        'Welcome Back you\'ve been missed!',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                            fontSize: 15.0,
                          color: Colors.grey[700]

                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 20.0,
                    ),
                     CustomTextField(

                       onChanged: (data){
                         email = data;
                       },
                      hintText: 'Email',
                      prefixIcon: Icon(Icons.email_outlined),
                      textInputType: TextInputType.emailAddress,
                    ),
                    const SizedBox(
                      height: 20.0,
                    ),
                     CustomTextField(

                       onChanged: (data){
                         password = data;
                       },
                      hintText: 'password',
                      prefixIcon: Icon(Icons.lock_outline_rounded),
                      suffixIcon: Icon(Icons.remove_red_eye),
                      textInputType: TextInputType.text,
                    ),
                    const SizedBox(
                      height: 20.0,
                    ),
                     CustomButton(
                      onTap: () async{
                        if (_formKey.currentState!.validate()) {
                          isLoading = true;
                          setState(() {});

                          try {
                            await signInUser();
                            showSnackBar(context, 'Successfully logged in');
                            Navigator.push(
                                context, MaterialPageRoute(
                                builder: (context) => HomeScreen(
                                  text: 'Successfully logged in',)));

                          } on FirebaseAuthException catch (e) {
                            if (e.code == 'user-not-found') {
                              showSnackBar(context, 'user not found');
                            } else if (e.code == 'wrong-password') {
                              showSnackBar(context, 'Please enter correct email and password');
                            }else{
                              showSnackBar(context,'there was an error');
                            }
                          }
                          isLoading = false;
                          setState(() {});
                        }
                      },
                        text: 'Sign In',
                    ),
                    const SizedBox(
                      height: 20.0,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                         Text(
                          'don\'t have an account?',
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 16.0,
                              color: Colors.grey[700]

                          ),
                        ),
                        TextButton(
                          onPressed: () {
                            Navigator.pushNamed(context, 'register');
                          },
                          child: const Text(
                              'Register now',
                            style: TextStyle(
                              color: Colors.blue,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        )
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Future<void> signInUser() async {
    UserCredential userCredential = await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email!,
        password: password!
    );
  }


}
