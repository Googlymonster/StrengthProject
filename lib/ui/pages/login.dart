import 'package:flutter/material.dart';
import 'package:gradient_app_bar/gradient_app_bar.dart';
import 'package:strength_project/core/services/auth.dart';
import 'package:provider/provider.dart';

class LoginPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  AuthService _auth;
  TextEditingController _password;
  TextEditingController _email;
  String _errorMessage;
  bool _isLoading;
  bool _isLoginForm;

  // Check if form is valid before perform login
  bool validateAndSave() {
    final form = _formKey.currentState;
    if (form.validate()) {
      form.save();
      return true;
    }
    return false;
  }

  // Perform login
  void validateAndSubmit() async {
    if (this.mounted) {
      setState(() {
        _errorMessage = "";
        _isLoading = true;
      });
    }

    if (validateAndSave()) {
      _auth = Provider.of<AuthService>(context);
      String userId = "";
      try {
        if (_isLoginForm) {
          userId = await _auth.signIn(_email.text, _password.text);

          print('Signed in: $userId');
          _isLoading = false;
        } else {
          userId = await _auth.signUp(_email.text, _password.text);
          // _auth.sendEmailVerification();
          // _showVerifyEmailSentDialog();
          print('Signed up user: $userId');
          if (this.mounted) {
            setState(() {
              _isLoginForm = true;
            });
          }
        }
        if (userId.isNotEmpty) {
          if (this.mounted) {
            setState(() {
              _isLoading = false;
            });
          }
        }

        print(userId);

      } catch (e) {
        print('Error: $e');
        if (this.mounted) {
          setState(() {
            _isLoading = false;
            _errorMessage = e.toString();
            _formKey.currentState.reset();
          });
        }
      }
    }
  }

  @override
  void initState() {
    _email = TextEditingController(text: "");
    _password = TextEditingController(text: "");
    _errorMessage = "";
    _isLoading = false;
    _isLoginForm = true;
    _auth = AuthService();
    super.initState();
  }

  void resetForm() {
    _formKey.currentState.reset();
    _errorMessage = "";
  }

  void toggleFormMode() {
    resetForm();
    setState(() {
      _isLoginForm = !_isLoginForm;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: GradientAppBar(
          automaticallyImplyLeading: false,
          title: Text(_isLoginForm ? 'Login' : 'Register'),
          backgroundColorStart: Colors.cyan,
          backgroundColorEnd: Colors.indigo,
        ),
        body: Stack(
          children: <Widget>[_showForm(), _showCircularProgress()],
        ));
  }

  Widget _showCircularProgress() {
    if (_isLoading) {
      return Center(child: CircularProgressIndicator());
    }
    return Container(
      height: 0.0,
      width: 0.0,
    );
  }

  Widget _showForm() {
    return Container(
      padding: EdgeInsets.all(16.0),
      child: Form(
        key: _formKey,
        child: ListView(
          shrinkWrap: true,
          children: <Widget>[
            showEmailInput(),
            showPasswordInput(),
            showLoginButton(),
            SizedBox(
              height: 100,
            ),
            showSecondaryButton(),
            showErrorMessage(),
          ],
        ),
      ),
    );
  }

  Widget showErrorMessage() {
    if (_errorMessage.length > 0 && _errorMessage != null) {
      return Text(
        _errorMessage,
        style: TextStyle(
            fontSize: 13.0,
            color: Colors.red,
            height: 1.0,
            fontWeight: FontWeight.w300),
      );
    } else {
      return Container(
        height: 0.0,
      );
    }
  }

  Widget showEmailInput() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(0.0, 100.0, 0.0, 0.0),
      child: TextFormField(
        controller: _email,
        maxLines: 1,
        keyboardType: TextInputType.emailAddress,
        autofocus: false,
        decoration: InputDecoration(
            hintText: 'Email',
            icon: Icon(
              Icons.mail,
              color: Colors.grey,
            )),
        validator: (value) => value.isEmpty ? 'Email can\'t be empty' : null,
        onSaved: (value) => _email.text = value.trim(),
      ),
    );
  }

  Widget showPasswordInput() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(0.0, 15.0, 0.0, 0.0),
      child: TextFormField(
        controller: _password,
        maxLines: 1,
        obscureText: true,
        autofocus: false,
        decoration: InputDecoration(
            hintText: 'Password',
            icon: Icon(
              Icons.lock,
              color: Colors.grey,
            )),
        validator: (value) => value.isEmpty ? 'Password can\'t be empty' : null,
        onSaved: (value) => _password.text = value.trim(),
      ),
    );
  }

  Widget showSecondaryButton() {
    return Align(
      alignment: Alignment.bottomCenter,
      child: FlatButton(
          child: Text(
              _isLoginForm ? 'Create an account' : 'Have an account? Sign in',
              style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.w300)),
          onPressed: toggleFormMode),
    );
  }

  Widget showLoginButton() {
    return Padding(
        padding: EdgeInsets.fromLTRB(0.0, 45.0, 0.0, 0.0),
        child: SizedBox(
          height: 40.0,
          child: RaisedButton(
            elevation: 5.0,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30.0)),
            color: Colors.blue,
            child: Text(_isLoginForm ? 'Login' : 'Create account',
                style: TextStyle(fontSize: 20.0, color: Colors.white)),
            onPressed: validateAndSubmit,
          ),
        ));
  }

  @override
  void dispose() {
    _email.dispose();
    _password.dispose();
    super.dispose();
  }
}
