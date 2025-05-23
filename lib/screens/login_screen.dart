import 'package:ecommerce/bloc/auth/auth_bloc.dart';
import 'package:ecommerce/bloc/auth/auth_event.dart';
import 'package:ecommerce/bloc/auth/auth_state.dart';
import 'package:ecommerce/constants/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({super.key});

  final _usernameTextController = TextEditingController(text: 'amirahmad');
  final _passwordTextController = TextEditingController(text: '12345678');

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        backgroundColor: CustomColors.blue,
        body: Column(
          children: [
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Image.asset(
                    'assets/images/icon_application.png',
                    width: 100,
                    height: 100,
                  ),
                  SizedBox(height: 20),
                  Text(
                    'اپل شاپ',
                    style: TextStyle(
                        fontFamily: 'sb', fontSize: 24, color: Colors.white),
                  ),
                ],
              ),
            ),
            Expanded(
              child: Container(
                margin: EdgeInsets.all(20),
                padding: EdgeInsets.all(20),
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(15)),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    TextField(
                      controller: _usernameTextController,
                      decoration: InputDecoration(
                        contentPadding: EdgeInsets.all(10),
                        labelText: 'نام کاربری',
                        labelStyle: TextStyle(
                            fontFamily: 'sm',
                            fontSize: 18,
                            color: Colors.black),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20),
                          borderSide: BorderSide(color: Colors.grey, width: 2),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20),
                          borderSide:
                              BorderSide(color: CustomColors.blue, width: 3),
                        ),
                      ),
                    ),
                    SizedBox(height: 20),
                    TextField(
                      controller: _passwordTextController,
                      decoration: InputDecoration(
                        contentPadding: EdgeInsets.all(10),
                        labelText: 'رمز عبور',
                        labelStyle: TextStyle(
                          fontFamily: 'sm',
                          fontSize: 18,
                          color: Colors.black,
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.all(
                            Radius.circular(20),
                          ),
                          borderSide: BorderSide(color: Colors.grey, width: 2),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20),
                          borderSide:
                              BorderSide(color: CustomColors.blue, width: 3),
                        ),
                      ),
                    ),
                    SizedBox(height: 20),
                    BlocBuilder<AuthBloc, AuthState>(
                      builder: (context, state) {
                        if (state is AuthInitiateState) {
                          return ElevatedButton(
                            onPressed: () {
                              BlocProvider.of<AuthBloc>(context).add(
                                  AuthLoginRequest(_usernameTextController.text,
                                      _passwordTextController.text));
                            },
                            style: ElevatedButton.styleFrom(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20),
                              ),
                              textStyle: TextStyle(
                                fontFamily: 'sb',
                                fontSize: 20,
                              ),
                              foregroundColor: Colors.white,
                              backgroundColor: CustomColors.blue,
                              minimumSize: Size(200, 48),
                            ),
                            child: Text('ورود به حساب کاربری'),
                          );
                        } else if (state is AuthLoadingState) {
                          return CircularProgressIndicator(
                            color: CustomColors.blue,
                          );
                        } else if (state is AuthResponseState) {
                          Text widget = Text('');
                          state.response.fold(
                            (l) => widget = Text(l),
                            (r) => widget = Text(r),
                          );
                          return widget;
                        }

                        return Text('خطای نا مشخض !!!');
                      },
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
