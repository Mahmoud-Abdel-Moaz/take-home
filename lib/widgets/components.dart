import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';



customTextField({
  required TextEditingController controller,
  required BuildContext context,
  required String hint,
  required FocusNode focusNode,
  double? height,
  double? verticalPadding,
  TextInputType type = TextInputType.text,
  required void Function() onSubmit,
  String? Function(String?)? validator,
  void Function(String)? onChanged,
}) {
  return GestureDetector(
    onTap: () {
      FocusScope.of(context).requestFocus(focusNode);
    },
    child: Container(
      padding: EdgeInsets.symmetric(
          vertical: verticalPadding ?? 12, horizontal: 16),
      height: height,
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(width: 1, color:const Color(0xffE6E6E6)),
        borderRadius: BorderRadius.circular(8),
      ),
      child: TextFormField(
        style:const TextStyle(fontSize:14,color: Colors.black,fontWeight: FontWeight.w400),
        decoration: InputDecoration(
          isDense: true,
          border: InputBorder.none,
          focusedBorder: InputBorder.none,
          enabledBorder: InputBorder.none,
          errorBorder: InputBorder.none,
          contentPadding: EdgeInsets.zero,
          disabledBorder: InputBorder.none,
          hintText: hint,
          hintStyle:  TextStyle(fontSize:14,color: Colors.black.withOpacity(.8),fontWeight: FontWeight.w400),),
        controller: controller,
        keyboardType: type,
        onFieldSubmitted: (value) {
          onSubmit();
        },
        focusNode: focusNode,
        validator: validator,
        onChanged: onChanged,
      ),
    ),
  );
}


defaultButton({required String text,required void Function() onTap,required BuildContext context,bool isLoading=false}){
  return isLoading?
      const Center(child: CircularProgressIndicator(),)
    :GestureDetector(
    onTap: onTap,
    child: Container(
      padding: const EdgeInsets.all(16),
      width: double.infinity,
      decoration: BoxDecoration(
        color: Theme.of(context).primaryColor,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Center(
        child: Text(text,style:const TextStyle(color: Colors.white,fontSize: 16,fontWeight: FontWeight.bold,),),
      ),
    ),
  );
}

void navigateTo(context, widget) => Navigator.push(
  context,
  MaterialPageRoute(
    builder: (context) => widget,
  ),
);

Future<void> navigateToAndFinish(context, widget) =>
    Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(
          builder: (context) => widget,
        ), (Route<dynamic> route) {
      return false;
    });

void navigateToAndReplacement(context, widget) => Navigator.pushReplacement(
  context,
  MaterialPageRoute(
    builder: (context) => widget,
  ),
  /*      (Route<dynamic> route){
      return false;
    }*/
);

void showToast({
  required String msg,
  required ToastStates state,
}) =>
    Fluttertoast.showToast(
        msg: msg,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 5,
        backgroundColor: _chooseToastColor(state),
        textColor: Colors.white,
        fontSize: 16.0);

Color _chooseToastColor(ToastStates state) {
  switch (state) {
    case ToastStates.SUCCESS:
      return Colors.green;
    case ToastStates.WARNING:
      return Colors.yellow;
    case ToastStates.ERROR:
      return Colors.red;
  }
}

enum ToastStates { SUCCESS, ERROR, WARNING }