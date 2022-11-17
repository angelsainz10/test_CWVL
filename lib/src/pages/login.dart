import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:test/src/pages/home.dart';
import 'package:test/src/pages/recover_pass.dart';
import 'package:test/src/services/login_service.dart';
import 'package:test/src/utils/shared_preferences.dart';

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  State<Login> createState() => _Login();
}

class _Login extends State<Login> {
  final TextEditingController _username = TextEditingController();
  final TextEditingController _password = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool _obscureText = true;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _initAdmin();
  }

  _initAdmin() async {
    SharedPreferencesGlobal.prefs = await SharedPreferences.getInstance();
    await SharedPreferencesGlobal.prefs.setString('TestUser', 'Test1234\$');
  }

  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        return false;
      },
      child: Scaffold(
        backgroundColor: Colors.white,
        body: SafeArea(
          child: SizedBox(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            child: Center(
              child: SingleChildScrollView(
                child: Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SizedBox(
                        child: Column(
                          children: const [
                            Text(
                              'Bienvenido',
                              style: TextStyle(fontSize: 18),
                            ),
                            SizedBox(height: 10),
                            Text(
                              'Inicia Sesión',
                              style: TextStyle(fontSize: 14),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.height / 25,
                      ),
                      SizedBox(
                        width: MediaQuery.of(context).size.width / 1.5,
                        child: TextFormField(
                          controller: _username,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Este campo no debe estar vacío';
                            }
                            return null;
                          },
                          decoration: InputDecoration(
                            labelText: 'Usuario',
                            labelStyle: const TextStyle(fontSize: 14),
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10)),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.height / 25,
                      ),
                      SizedBox(
                        width: MediaQuery.of(context).size.width / 1.5,
                        child: TextFormField(
                          controller: _password,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Este campo no debe estar vacío';
                            }
                            return null;
                          },
                          obscureText: _obscureText,
                          decoration: InputDecoration(
                            labelText: 'Contraseña',
                            labelStyle: const TextStyle(fontSize: 14),
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10)),
                            suffixIcon: IconButton(
                              icon: Icon(
                                // Based on passwordVisible state choose the icon
                                _obscureText
                                    ? Icons.visibility_off
                                    : Icons.visibility,
                                color: _obscureText ? Colors.grey : Colors.blue,
                              ),
                              onPressed: () {
                                // Update the state i.e. toogle the state of passwordVisible variable
                                setState(() {
                                  _obscureText = !_obscureText;
                                });
                              },
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.height / 25,
                      ),
                      SizedBox(
                        width: MediaQuery.of(context).size.width / 2,
                        height: MediaQuery.of(context).size.height / 20,
                        child: ElevatedButton(
                          style: ButtonStyle(
                            backgroundColor:
                                MaterialStateProperty.all<Color>(Colors.blue),
                            shape: MaterialStateProperty.all<OutlinedBorder?>(
                              RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10.0),
                              ),
                            ),
                          ),
                          child: const Text(
                            'Iniciar Sesión',
                            style: TextStyle(fontSize: 16),
                          ),
                          onPressed: () {
                            if (_formKey.currentState!.validate()) {
                              LoginService.login(
                                      context, _username.text, _password.text)
                                  .then((result) {
                                if (result) {
                                  Navigator.of(context).push(MaterialPageRoute(
                                      builder: (context) => const Home()));
                                }
                              });
                            }
                          },
                        ),
                      ),
                      SizedBox(
                        child: TextButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const RecoverPassword(),
                              ),
                            );
                          },
                          child: const Text(
                            "Recuperar contraseña",
                            style: TextStyle(
                              decoration: TextDecoration.underline,
                              fontSize: 14,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
