import 'package:authentication_repository/authentication_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';
import 'package:koffee_kraze_application/views/login/login_bloc/login_bloc.dart';
import 'package:koffee_kraze_application/appBar/noDrawerAppBar.dart';
import 'package:authentication_repository/authentication_repository.dart';
import 'login_widgets/login_form.dart';

class LoginPage extends StatelessWidget {
  static Route route() {
    return MaterialPageRoute<void>(builder: (_) => LoginPage());
  }

  @override
  Widget build(BuildContext context) {
    return new WillPopScope (
      onWillPop: () async => false,
      child: Scaffold(
          appBar: NoDrawerTopBar(),
          body: SingleChildScrollView(
              child: Column (
                  children: <Widget> [
                    SizedBox(height: 10.0),
                    Material(
                      borderRadius: BorderRadius.all(Radius.circular(50.0)),
                      child: Padding(
                        padding: EdgeInsets.fromLTRB(8, 50, 8, 8),
                        child: Image.asset('images/coffee_cup_graphic.png', width: 80, height: 80),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(12),
                      child: BlocProvider(
                        create: (context) {
                          return LoginBloc(
                            authenticationRepository:
                            RepositoryProvider.of<AuthenticationRepository>(context),
                          );
                        },
                        child: LoginForm(),
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: <Widget>[
                        FlatButton(
                          onPressed: () {},
                          child: Text("Forgot password",
                              style: TextStyle(
                                  fontSize: 15,
                                  color: Colors.brown[900],
                                  fontStyle: FontStyle.italic)),
                        )
                      ],
                    ),
                    RaisedButton(
                      color: Colors.brown[400],
                      splashColor: Colors.brown[900],
                      onPressed: () {
                      },
                      child: Text(
                        "Register",
                        style: TextStyle(
                          color: Colors.white,
                        ),
                      ),
                    ),
                    Row(mainAxisAlignment: MainAxisAlignment.center, children: <Widget>[
                      Icon(Icons.copyright),
                      Text('Ravenpyre, 2021')
                    ])
                  ]
              )
          )
      ),
    );
  }
}