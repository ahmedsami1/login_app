import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import '../helper/helper.dart';
import '../widgets/custom_button.dart';
import '../widgets/custom_text_field.dart';
import 'home_screen.dart';

class RegisterScreen extends StatefulWidget {
  String id = 'register';
   RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
   String? email;

   String? password;



  final GlobalKey<FormState> _formKey = GlobalKey();

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
                    const Text(
                      'Register',
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 30.0

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
                      prefixIcon: const Icon(Icons.email_outlined),
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
                      prefixIcon: const Icon(Icons.lock_outline_rounded),
                      suffixIcon: const Icon(Icons.remove_red_eye),
                      textInputType: TextInputType.text,
                    ),
                    const SizedBox(
                      height: 20.0,
                    ),
                    CustomButton(
                      onTap: () async {
                        isLoading = true;
                        setState(() {});

                        if (_formKey.currentState!.validate()) {
                          try {
                            await registerUser();
                            showSnackBar(context, 'Successfully registered');
                            Navigator.push(
                                context, MaterialPageRoute(
                                builder: (context) => HomeScreen(
                                  text: 'Successfully Registered',)));

                          } on FirebaseAuthException catch (e) {
                            if (e.code == 'weak-password') {
                              showSnackBar(context, 'weak password');
                            } else if (e.code == 'email-already-in-use') {
                              showSnackBar(context, 'email already in use');
                            }
                          } catch (e) {
                            showSnackBar(context, e.toString());
                          }
                          isLoading = false;
                          setState(() {});

                        }
                      },
                      text: 'Sign Up',
                    ),
                    const SizedBox(
                      height: 20.0,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                         Text(
                          ' Have an account?',
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 16.0,
                              color: Colors.grey[700]

                          ),
                        ),
                        TextButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          child: const Text(
                            'Login',
                            style: TextStyle(
                                color: Colors.blue,
                                fontWeight: FontWeight.bold
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



  Future<void> registerUser() async {
    UserCredential userCredential = await FirebaseAuth.instance.
    createUserWithEmailAndPassword(
        email: email!,
        password: password!,
    );
  }
}
