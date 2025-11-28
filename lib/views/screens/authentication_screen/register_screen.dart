import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shop_app/controllers/auth_controller.dart';
import 'package:shop_app/views/screens/authentication_screen/login_screen.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final AuthController _authController = AuthController();
  late String email;
  late String fullName;
  late String password;
  bool _isLoading =  false;
  registerUser() async{
    setState(() {
      _isLoading = true;
    });
    await _authController.signUpUsers(context: context, fullName: fullName, email: email, password: password).whenComplete((){
      setState(() {
        _isLoading = false;
      }) ;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade200,
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Center(
          child: SingleChildScrollView(
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("Create Your Account",
                    style: GoogleFonts.getFont(
                        'Lato',
                        color: Color(0xFF0d120E),
                        fontWeight: FontWeight.bold,
                        letterSpacing: 0.2,
                        fontSize: 23
                    ),),
                  Text(
                    'To Explore the world exclusive',
                    style: GoogleFonts.getFont(
                      'Lato',
                      color: Color(0xFF0d120E),
                      fontSize: 14,
                      letterSpacing: 0.2,
                    ),
                  ),
                  Image.asset('assets/images/Illustration.png',
                    width: 200,
                    height: 200,),
                  Align(
                    alignment: Alignment.topLeft,
                    child: Text('Username',
                      style: GoogleFonts.getFont(
                        'Nunito Sans',
                        fontWeight: FontWeight.bold,
                        letterSpacing:  0.2,
                      ),),
                  ),TextFormField(
                    onChanged: (value){
                      fullName = value;
                    },
                    validator: (value) {
                      if(value!.isEmpty){
                        return " Enter your full name";
                      } else{
                        return null;
                      }
                    },
                    decoration: InputDecoration(
                        fillColor: Colors.white,
                        filled: true,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(9),
                        ),
                        focusedBorder: InputBorder.none,
                        enabledBorder: InputBorder.none,
                        labelText: 'enter your full name',
                        labelStyle: GoogleFonts.getFont(
                          'Nunito Sans',
                          fontSize: 14,
                          letterSpacing: 0.1,
                        ),
                        prefixIcon: Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Image.asset('assets/icons/user.jpeg',
                            width: 20,
                            height: 20 ,
                          ),
                        )
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Align(
                    alignment: Alignment.topLeft,
                    child: Text('Email',
                      style: GoogleFonts.getFont(
                        'Nunito Sans',
                        fontWeight: FontWeight.bold,
                        letterSpacing:  0.2,
                      ),),
                  ),TextFormField(
                    onChanged: (value){
                      email = value;
                    },
                    validator: (value){
                      if(value!.isEmpty){
                        return 'enter your email';
                      } else{
                        return null;
                      }
                    },
                    decoration: InputDecoration(
                        fillColor: Colors.white,
                        filled: true,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(9),
                        ),
                        focusedBorder: InputBorder.none,
                        enabledBorder: InputBorder.none,
                        labelText: 'enter your email',
                        labelStyle: GoogleFonts.getFont(
                          'Nunito Sans',
                          fontSize: 14,
                          letterSpacing: 0.1,
                        ),
                        prefixIcon: Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Image.asset('assets/icons/email.png',
                            width: 20,
                            height: 20 ,
                          ),
                        )
                    ),
                  ),
                  SizedBox(height: 30,),
                  TextFormField(
                    onChanged: (value){
                      password = value;
                    },
                    validator: (value){
                      if(value!.isEmpty){
                        return 'enter your password';
                      } else{
                        return null;
                      }
                    },
                    obscureText: true,
                    decoration: InputDecoration(
                      fillColor: Colors.white,
                      filled: true,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(9),
                      ),
                      focusedBorder: InputBorder.none,
                      enabledBorder: InputBorder.none,
                      labelText: 'enter your password',
                      labelStyle: GoogleFonts.getFont(
                        'Nunito Sans',
                        fontSize: 14,
                        letterSpacing: 0.1,
                      ),
                      prefixIcon: Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Image.asset('assets/icons/password.png',
                          width: 20,
                          height: 20 ,
                        ),
                      ),
                      suffixIcon: Icon(Icons.visibility),
                    ),
                  ),

                  SizedBox(
                    height: 30,
                  ),
                  InkWell(
                    onTap: () async {
                      if(_formKey.currentState!.validate()){
                        registerUser();
                      }
                    },
                    child: Container(
                      width: 319,
                      height: 50,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                        gradient: LinearGradient(
                          colors: [
                            Color(0xFF192DE1),
                            Color(0xCC0D6EFF)
                          ],
                        ),
                      ),
                      child: Center(
                        child: _isLoading
                            ? const CircularProgressIndicator(color: Colors.white,): Text(
                          'Sign Up',
                          style: GoogleFonts.getFont(
                              'Lato',
                              fontSize: 17,
                              color: Colors.white
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 20,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Need an Account',
                        style: GoogleFonts.roboto(
                          fontWeight: FontWeight.bold,
                          letterSpacing: 1,
                        ),
                      ),
                      InkWell(
                        onTap: (){
                          Navigator.push(context, MaterialPageRoute(builder: (context){
                            return LoginScreen();
                          }));
                        },
                        child: Text(
                          'Sign In',
                          style: GoogleFonts.roboto(color: Color(0xFF192DE1),
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
