import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

final firebase = FirebaseAuth.instance;

class ScreenLogin extends StatefulWidget {
  const ScreenLogin({super.key});

  @override
  State<ScreenLogin> createState() => _ScreenLoginState();
}

class _ScreenLoginState extends State<ScreenLogin> {
  final _formKey = GlobalKey<FormState>();
  bool _isLogin = true;
  var _email = '';
  var _password = '';
  var _isAuthenticating = false;
  void _submit() async {
    final validate = _formKey.currentState!.validate();
    if (!validate) {
      return;
    }
    _formKey.currentState!.save();
    try {
      setState(() {
        _isAuthenticating = true;
      });
      if (_isLogin) {
        final userCredential = await firebase.signInWithEmailAndPassword(
            email: _email, password: _password);
      } else {
        final userCredential = await firebase.createUserWithEmailAndPassword(
            email: _email, password: _password);
        print('sdsadfsd $userCredential');
      }
    } on FirebaseAuthException catch (error) {
      if (error.code == 'email-already-in-use') {
        ScaffoldMessenger.of(context).clearSnackBars();
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(error.message ?? 'Authentication faild'),
          ),
        );
      } else if (error.code == 'invalid-email') {
        ScaffoldMessenger.of(context).clearSnackBars();
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(error.message ?? 'Authentication faild'),
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Form(
        key: _formKey,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'PlantBazar',
              style: TextStyle(
                  color: Colors.green,
                  fontSize: 20,
                  fontWeight: FontWeight.bold),
            ),
            const Text('Please Log-in or Sign-up to continue'),
            Padding(
              padding: const EdgeInsets.only(left: 10.0, right: 10),
              child: TextFormField(
                decoration: const InputDecoration(labelText: 'Email'),
                textCapitalization: TextCapitalization.none,
                autocorrect: false,
                keyboardType: TextInputType.emailAddress,
                validator: (value) {
                  if (value == null ||
                      !value.contains('@') ||
                      value.trim().isEmpty) {
                    return 'Please enter valid email';
                  }
                  return null;
                },
                onSaved: (value) {
                  _email = value!;
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 10.0, right: 10),
              child: TextFormField(
                decoration: const InputDecoration(
                  labelText: 'password',
                ),
                textCapitalization: TextCapitalization.none,
                obscureText: true,
                autocorrect: false,
                validator: (value) {
                  if (value == null || value.trim().length < 6) {
                    return 'Password must be at least 6 characters long';
                  }
                  return null;
                },
                onSaved: (value) {
                  _password = value!;
                },
              ),
            ),
            const SizedBox(
              height: 25,
            ),
            ElevatedButton(
              onPressed: _submit,
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all<Color>(Colors.black),
              ),
              child: Text(_isLogin ? 'Log in' : 'Sign up'),
            ),
            if (!_isAuthenticating)
              TextButton(
                onPressed: () {
                  setState(() {
                    _isLogin = !_isLogin;
                  });
                },
                child: Text(
                  _isLogin ? 'Create Account' : 'I already have an account',
                  style: const TextStyle(color: Colors.black),
                ),
              )
          ],
        ),
      ),
    );
  }
}
