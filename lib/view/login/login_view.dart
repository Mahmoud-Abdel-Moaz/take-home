import 'package:flutter/material.dart';

import '../../services/authentication.dart';
import '../../widgets/components.dart';
import 'details_view.dart';


class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {

  bool _isLoading=false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            defaultButton(text: 'Sign in',context: context,isLoading: _isLoading,onTap:login ),
          ],
        ),
      ),
    );
  }
  void login(){
    setState(() {
      _isLoading=true;
    });
    AuthenticationService.signIn().then((value){
      setState(() {
        _isLoading=false;
      });
      navigateToAndFinish(context, UserDetailsScreen());
    }).catchError((error){
      showToast(msg: 'Error', state: ToastStates.ERROR);
      setState(() {
        _isLoading=false;
      });

    });
  }
}
