import 'package:ap/layout/Shop/Cubit/cubit.dart';
import 'package:ap/shared/styles/colors.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../models/home/ShopHomeModel.dart';

void navigateAndFinish(context, widget) {
  Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (context) => widget),
          (Route<dynamic> route) => false);
}
void navigateTo(context,widget){
  Navigator.push(context,  MaterialPageRoute(builder: (context) => widget),
          );
}

Widget titleContainer({@required String? text}) => Container(
    height: 115,
    width: 345,
    color: primaryLightColor,
    child: Center(
      child: defaultText(
          text: "$text",
          googleFont: true,
          fontWeight: FontWeight.bold,
          color: primaryColor,
          fontSize: 38),
    ));
Widget defaultText(
        {required String text,
        bool? googleFont = false,
        double? fontSize = 16,
        Color? color = titleTextColor,
        FontWeight? fontWeight = FontWeight.normal}) =>
    Text(
      text,
      textAlign: TextAlign.center,
      maxLines: 2,
      style: googleFont == false
          ? TextStyle(fontSize: fontSize, color: color, fontWeight: fontWeight)
          : GoogleFonts.signika(
              fontSize: fontSize, color: color, fontWeight: fontWeight),
    );

Widget defaultMaterialButton({
  required final Function function,
  @required String? textButton,
  double buttonHeightSize = 50,
  double buttonWidthSize = double.infinity,
  required bool isEnabled
}) =>
    RawMaterialButton(
      fillColor: isEnabled?primaryColor:fifthLightColor,
        shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(20.0))),
        onPressed: () => isEnabled?function():null,

        child: Container(
          width: buttonWidthSize,
          height: buttonHeightSize,

          child: Center(
              child: defaultText(
                  text: " ${textButton?.toUpperCase()}",
                  googleFont: true,
                  fontWeight: FontWeight.w700,
                  fontSize: 24,
                  color: buttomTextColor)),
        ));
Widget defaultTextButton(
        {@required Widget? widget,
        @required String? textButton,
        context,
        double padding = 0.1,
        bool googleFont = false,
        double fontSize = 18,
        Color color = thirdTextColor,
        FontWeight fontWeight = FontWeight.w700}) =>
    TextButton(
        onPressed: () => navigateAndFinish(context, widget),
        child: Padding(
          padding: EdgeInsets.only(right: padding),
          child: defaultText(
              text: "$textButton",
              googleFont: googleFont,
              fontSize: fontSize,
              color: color,
              fontWeight: fontWeight),
        ));

Widget defaultTextField({
  required TextEditingController controller,
  bool isPassword = false,
  required TextInputType type,
  Function? onSubmit,
  Function? onChanged,
  Function? onTap,
  required String text,
  String? initialValue,
   IconData? prefix,
  IconData? suffix,
  Function? suffixFunction,
  String textForUnValid = 'this element is required',
  //required Function validate,
}) =>
    Container(color: Colors.white,
      child: TextFormField(cursorColor: Colors.white,
        initialValue: initialValue,
        autocorrect: true,
        controller: controller,
        onTap: () {
         // onTap!();
        },
        validator: (value) {
          if (value!.isEmpty) {
            return textForUnValid;
          }
          return null;
        },
        onChanged: (value) {onChanged!();},
        onFieldSubmitted: (value) {

          onSubmit!(value);
        },
        obscureText: isPassword ? true : false,
        keyboardType: type,
        decoration: InputDecoration(
          label: defaultText(
              text: " $text",
              fontWeight: FontWeight.w700,
              fontSize: 18,
              color: titleTextColor),
          prefixIcon: Icon(prefix),
          suffixIcon: IconButton(
            onPressed: () {
              suffixFunction!();
            },
            icon: Icon(suffix),
          ),
          border: const OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(10)),
              borderSide: BorderSide(),
              gapPadding: 4),

        ),
      ),
    );
ScaffoldFeatureController<SnackBar, SnackBarClosedReason> defaultSnackBarMaterial(context,Color color,String message)=> ScaffoldMessenger.of(context).showSnackBar(SnackBar(backgroundColor: color,
  duration:const Duration(seconds: 2) ,
  content: defaultText(text:message,googleFont: true,fontSize: 18,color: primaryLightColor,fontWeight: FontWeight.w600 ),

)
);
void textFieldClear(TextEditingController controller){
  controller.clear();
}
