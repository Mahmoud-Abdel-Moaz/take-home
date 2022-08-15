import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import '../../services/database.dart';
import '../../widgets/components.dart';
import '../shipment/shipments_view.dart';



class UserDetailsScreen extends StatefulWidget {
   const UserDetailsScreen({Key? key}) : super(key: key);

  @override
  State<UserDetailsScreen> createState() => _UserDetailsScreenState();
}

class _UserDetailsScreenState extends State<UserDetailsScreen> {
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
    return Scaffold(
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
                customTextField(controller: _phoneController, focusNode: _phoneFocusedNode, context: context, onSubmit: register, hint: 'Enter Phone number',validator: (value){
                  if(value!.isEmpty){
                    setState(() {
                      _nameError='Enter Phone number';
                    });
                  }else{
                    setState(() {
                      _nameError='';
                    });
                  }
                  return null;
                },type: TextInputType.phone),
                const Spacer(),
                defaultButton(text: 'Register', onTap: register, context: context,isLoading:_isLoading),

              ]
            ),
          ),
        ),
      ),
    );
  }
  void register (){
    if(_formKey.currentState!.validate()&&_nameError.isEmpty&&_phoneError.isEmpty)
    {
      DatabaseService.addUser(
          _nameController.text, _phoneController.text)
          .then((value) {
        if (kDebugMode) {
          print('User added');
        }
        navigateToAndFinish(context,  ShipmentsScreen());
      }).catchError((e) {
        showToast(msg: 'Error', state: ToastStates.ERROR);
      });
    }
  }
}
