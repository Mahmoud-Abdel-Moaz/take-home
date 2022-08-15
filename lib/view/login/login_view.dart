import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import '../../model/user/User.dart';
import '../../services/authentication.dart';
import '../../services/database.dart';
import '../../widgets/components.dart';
import '../shipment/shipments_view.dart';


class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {

  final _nameController=TextEditingController();

  final _phoneController=TextEditingController();

  final _nameFocusedNode=FocusNode();

  final _phoneFocusedNode=FocusNode();

  bool _isLoading=false;

  String _nameError='';
  String _phoneError='';

  final _formKey=GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      backgroundColor: Colors.white,
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: Padding(
          padding:const EdgeInsets.all(24),
          child: Form(
            key: _formKey,
            child: Column(
                children:[
                  customTextField(controller: _nameController, focusNode: _nameFocusedNode, context: context, onSubmit: () {
                    FocusScope.of(context).requestFocus(_phoneFocusedNode);
                  }, hint: 'Name',validator: (value){
                    if(value!.isEmpty){
                      setState(() {
                        _nameError='Enter Name';
                      });
                    }else{
                      setState(() {
                        _nameError='';
                      });
                    }
                    return null;
                  }),
                  const SizedBox(height: 24,),
                  customTextField(controller: _phoneController, focusNode: _phoneFocusedNode, context: context, onSubmit: login, hint: 'Enter Phone number',validator: (value){
                    if(value!.isEmpty){
                      setState(() {
                        _phoneError='Enter Phone number';
                      });
                    }else{
                      setState(() {
                        _phoneError='';
                      });
                    }
                    return null;
                  },type: TextInputType.phone),
                  const Spacer(),
                  defaultButton(text: 'Sign in', onTap: login, context: context,isLoading:_isLoading),

                ]
            ),
          ),
        ),
      ),
    );
  }
  void login(){

    if(_formKey.currentState!.validate()&&_nameError.isEmpty&&_phoneError.isEmpty) {
      if(!_isLoading) {
        setState(() {
          _isLoading=true;
        });
        AuthenticationService.signIn().then((value){
          addUser();
        }).catchError((error){
          showToast(msg: 'Error', state: ToastStates.ERROR);
          setState(() {
            _isLoading=false;
          });

        });
      }
    }else{
      showToast(msg: 'Complete All info', state: ToastStates.ERROR);
    }

  }

  void addUser() {
    User user=User(fullName:_nameController.text ,phoneNumber: _phoneController.text,time: Timestamp.fromDate(DateTime.now()));
    DatabaseService.addUser(user)
        .then((value) {
      setState(() {
        _isLoading=false;
      });
      if (kDebugMode) {
        print('User added');
      }
      navigateToAndFinish(context,  ShipmentsScreen());
    }).catchError((e) {
      setState(() {
        _isLoading=false;
      });
      showToast(msg: 'Error', state: ToastStates.ERROR);
    });
  }

}
