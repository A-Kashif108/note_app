import 'package:flutter/material.dart';

import 'package:note_app/services/auth_service.dart';
import 'package:note_app/screens/home_page.dart';
import 'package:note_app/screens/login_page.dart';

class LoginViewPage extends StatefulWidget {
  const LoginViewPage({Key? key}) : super(key: key);

  @override
  State<LoginViewPage> createState() => _LoginViewPageState();
}

class _LoginViewPageState extends State<LoginViewPage> {
  TextEditingController nameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  final _authService = AuthService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
          padding: const EdgeInsets.all(10),
          child: ListView(
            children: <Widget>[
              Container(
                  alignment: Alignment.center,
                  padding: const EdgeInsets.fromLTRB(10, 20, 10, 40),
                  child: const Text(
                    'Notes App',
                    style: TextStyle(
                        color: Color.fromARGB(255, 120, 120, 120),
                        fontWeight: FontWeight.w500,
                        fontSize: 60),
                  )),
              Container(
                  alignment: Alignment.center,
                  padding: const EdgeInsets.all(10),
                  child: const Text(
                    'Sign in',
                    style: TextStyle(
                        fontSize: 32,
                        fontWeight: FontWeight.w500,
                        color: Colors.white),
                  )),
              const SizedBox(
                height: 10,
              ),
              Container(
                padding: const EdgeInsets.all(10),
                child: TextField(
                  controller: nameController,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(
                      Radius.circular(10),
                    )),
                    labelText: 'User Name',
                  ),
                ),
              ),
              Container(
                padding: const EdgeInsets.all(10),
                child: TextField(
                  obscureText: true,
                  controller: passwordController,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(
                      Radius.circular(10),
                    )),
                    labelText: 'Password',
                  ),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Container(
                  height: 72,
                  padding: const EdgeInsets.fromLTRB(40, 10, 40, 10),
                  child: ElevatedButton(
                      style: ButtonStyle(
                        backgroundColor:
                            MaterialStateProperty.all<Color>(Colors.grey),
                      ),
                      child: const Text(
                        'Login',
                        style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w500,
                            fontSize: 20),
                      ),
                      onPressed: () async {
                        if (nameController.text == "" ||
                            passwordController.text == "") {
                          ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                  content: Text("Please fill all the fields")));
                          return;
                        }
                        if (passwordController.text == "" ||
                            nameController.text == "")
                          await _authService
                              .signIn(
                                  nameController.text, passwordController.text)
                              .then((value) => {
                                    if (value == 200)
                                      {
                                        // TODO: localstorage.username
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  const HomePage()),
                                        )
                                      }
                                    else
                                      {
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(const SnackBar(
                                                content:
                                                    Text("User Login Failed")))
                                      }
                                  });
                      })),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  const Text('Does not have account?'),
                  TextButton(
                    child: const Text(
                      'Sign up',
                      style: TextStyle(
                        fontSize: 20,
                        color: Colors.grey,
                      ),
                    ),
                    onPressed: () {
                      // TODO: send to Signup page
                    },
                  )
                ],
              ),
            ],
          )),
    );
  }
}
