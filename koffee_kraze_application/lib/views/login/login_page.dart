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
                        padding: EdgeInsets.all(8.0),
                        child: Image.asset('images/halo.png', width: 80, height: 80),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(12),
                      child:  BlocProvider(
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
                                  color: Colors.blue[900],
                                  fontStyle: FontStyle.italic)),
                        )
                      ],
                    ),
                    RaisedButton(
                      color: Colors.blue,
                      splashColor: Colors.yellow[700],
                      onPressed: () {
                        Navigator.pushNamed(context, '/userSelection');
                      },
                      child: Text(
                        "Register",
                        style: TextStyle(
                          color: Colors.white,
                        ),
                      ),
                    ),
                    //TODO: Functions after this point to next TODO need to be
                    // removed for release


                    RaisedButton(
                      color: Colors.blue,
                      splashColor: Colors.yellow[700],
                      onPressed: () {
                        Navigator.pushNamed(context, '/patientHomePage');
                      },
                      child: Text(
                        "Patient Side",
                        style: TextStyle(
                          color: Colors.white,
                        ),
                      ),
                    ),
                    RaisedButton(
                      color: Colors.blue,
                      splashColor: Colors.yellow[700],
                      onPressed: () {
                        Navigator.pushNamed(context, '/adminHomePage');
                      },
                      child: Text(
                        "Physician Side",
                        style: TextStyle(
                          color: Colors.white,
                        ),
                      ),
                    ),

                    RaisedButton(
                      color: Colors.blue,
                      splashColor: Colors.yellow[700],
                      onPressed: () {
                        Navigator.pushNamed(context, '/optional');
                      },
                      child: Text(
                        "optional test",
                        style: TextStyle(
                          color: Colors.white,
                        ),
                      ),
                    ),


                    //TODO: Ends functions to be removed for release
                    Row(mainAxisAlignment: MainAxisAlignment.center, children: <Widget>[
                      Icon(Icons.copyright),
                      Text('GDC Enterprises, 2020')
                    ])
                  ]
              )
          )
      ),
    );
  }
}