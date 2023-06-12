import 'package:flutter/material.dart';
import 'package:moodin/pages/home_page.dart';
import 'package:moodin/pages/signup_page.dart';
import 'package:moodin/firebase_options.dart';

class SignInPage extends StatefulWidget {
  const SignInPage({Key? key}) : super(key: key);

  @override
  State<SignInPage> createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  late TextEditingController _controllerEmail;
  late TextEditingController _controllerPassword;

  @override
  void initState(){
    initFirebase();
    _controllerEmail = TextEditingController();
    _controllerPassword = TextEditingController();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        decoration: const BoxDecoration(
            gradient: LinearGradient(
                begin: Alignment.topCenter,
                // end: Alignment.bottomCenter,
                colors: [
                  Color(0xFF0694f0),
                  Color(0xFF0694f0),
                ]
            )
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            const SizedBox(
              height: 50,
            ),
            Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const <Widget>[
                  Center(
                    child: Text(
                      "Welcome",
                      style: TextStyle(color: Colors.white, fontSize: 40, fontWeight: FontWeight.bold),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Expanded(
                child: Container(
                  decoration: const BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(60),
                          topRight: Radius.circular(60)
                      )
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(30),
                    child: Column(
                      children: <Widget>[
                        const SizedBox(
                          height: 40,
                        ),
                        Container(
                          padding: const EdgeInsets.all(20),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(24),
                            color: Colors.white,
                            border: Border.all(color: const Color(0xFFdbdcdf), width: 1),
                          ),
                          child: Column(
                            children: <Widget>[
                              TextField(
                                controller: _controllerEmail,
                                keyboardType: TextInputType.emailAddress,
                                decoration: InputDecoration(
                                  prefixIcon: const Icon(Icons.email),
                                  labelText: 'Email',
                                  hintText: "Type Email",
                                  hintStyle: TextStyle(color: Colors.grey),
                                ),
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              TextField(
                                controller: _controllerPassword,
                                keyboardType: TextInputType.visiblePassword,
                                decoration: InputDecoration(
                                  prefixIcon: const Icon(Icons.key),
                                  hintText: "Type Password",
                                  hintStyle: TextStyle(color: Colors.grey),
                                  labelText: 'Password',
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(
                          height: 30,
                        ),
                        ElevatedButton(
                          child: Text("Login"),
                          onPressed: () async{
                            await db.collection('users').where('email', isEqualTo: _controllerEmail.text).where('password', isEqualTo: _controllerPassword.text).get().then((value) {
                              Navigator.push(context, MaterialPageRoute(builder: (context){
                                return Navigation();
                              }));
                            } );
                          },
                          style: ElevatedButton.styleFrom(
                            // padding: EdgeInsets.all(20), backgroundColor: Color.fromARGB(255, 186, 71, 0),
                            fixedSize: Size(300, 50),
                            elevation: 15,
                            // shadowColor: Color.fromARGB(255, 29, 161, 242),
                            textStyle: TextStyle(
                              fontWeight: FontWeight.w600,
                              fontSize: 18,
                              letterSpacing: 0.0,
                              color: Colors.white,),
                          ),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        TextButton(
                          onPressed: () {
                            Navigator.push(context, MaterialPageRoute(builder: (context){
                              return SignUpPage();
                            }));
                          },
                          child: const Text(
                            "Don't have account? Sign Up",
                            style: TextStyle(color: Colors.grey),
                          ),
                        ),
                      ],
                    ),
                  ),
                ))
          ],
        ),
      ),
    );
  }
}