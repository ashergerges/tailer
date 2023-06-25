// ignore_for_file: constant_identifier_names

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:tailer/shared/Style.dart';


void navigateTo(context, widget) {
  Navigator.push(
    context,
    MaterialPageRoute(
      builder: (context) => widget,
    ),
  );
}

void navigatePop(BuildContext context) {
  Navigator.pop(context);
}

void navigateAndFinish(context, widget) {
  Navigator.pushAndRemoveUntil(
    context,
    MaterialPageRoute(
      builder: (context) => widget,
    ),
        (route) {
      return false;
    },
  );
}

Widget divider(double start, double end, Color color) {
  return Padding(
    padding: EdgeInsetsDirectional.only(
      start: start,
      end: end,
    ),
    child: Container(
      width: double.infinity,
      height: 1.0,
      color: color,
    ),
  );
}

CircularProgressIndicator circularProgressIndicator(Color backgroundColor,
    Color colorWidget,) {
  return CircularProgressIndicator(
    backgroundColor: backgroundColor,
    color: colorWidget,
    strokeWidth: 5,
  );
}

Text textWidget(String text,
    TextDirection? textDirection,
    TextAlign? textAlign,
    Color textColor,
    double? fontSize,
    FontWeight? fontWeight,
    [int? line]
    ) {
  return Text(
    text,
    textDirection: textDirection,
    textAlign: textAlign,
    maxLines: line,
    style: TextStyle(
        decoration: TextDecoration.none,
        color: textColor,
        fontSize: fontSize,
        fontWeight: fontWeight),
  );
}

Text textWidgetChat(String text,
    TextDirection? textDirection,
    TextAlign? textAlign,
    Color textColor,
    double? fontSize,
    FontWeight? fontWeight,
    int line) {
  return Text(
    text,
    textDirection: textDirection,
    textAlign: textAlign,
    maxLines: line,
    overflow: TextOverflow.ellipsis,
    style: TextStyle(
        decoration: TextDecoration.none,
        color: textColor,
        fontSize: fontSize,
        fontWeight: fontWeight),
  );
}

void showToast({
  required String text,
  required ToastStates state,
}) =>
    Fluttertoast.showToast(
      msg: text,
      toastLength: Toast.LENGTH_LONG,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIosWeb: 5,
      backgroundColor: chooseToastColor(state),
      textColor: Colors.white,
      fontSize: 16.0,
    );

enum ToastStates { SUCCESS, ERROR, WARNING }

Color chooseToastColor(ToastStates state) {
  Color color;
  switch (state) {
    case ToastStates.SUCCESS:
      color = Colors.green;
      break;
    case ToastStates.ERROR:
      color = Colors.red;
      break;
    case ToastStates.WARNING:
      color = Colors.amber;
      break;
  }
  return color;
}

TextButton textButton(BuildContext context,
    String text,
    Color overlayColor,
    Color textColor,
    double fontSize,
    FontWeight fontWeight,
    VoidCallback onPressed) {
  return TextButton(
    onPressed: onPressed,
    style: ButtonStyle(
      overlayColor: MaterialStateProperty.all(overlayColor),
      backgroundColor: MaterialStateProperty.all(overlayColor),
    ),
    child: Text(
      text,
      style: TextStyle(
        color: textColor,
        fontSize: fontSize,
        fontWeight: fontWeight,
      ),
    ),
  );
}

FloatingActionButton floatTextButton(String hero,
    Widget? icon,
    Color colorButton,
    Color textColor,
    double fontSize,
    FontWeight fontWeight,
    String text,
    VoidCallback onTab) {
  return FloatingActionButton.extended(
    elevation: 0,
    icon: icon,
    backgroundColor: colorButton,
    hoverColor: colorButton,
    focusColor: colorButton,
    foregroundColor: colorButton,
    splashColor: colorButton,
    highlightElevation: 0,
    onPressed: onTab,
    label: Text(
      text,
      style: TextStyle(
        color: textColor,
        fontSize: fontSize,
        fontWeight: fontWeight,
      ),
    ),
    heroTag: hero,
  );
}

MaterialButton materialButtonIcon(BuildContext context,
    IconData icon,
    double iconSize,
    Color iconColor,
    Color highlightColor,
    VoidCallback onPressed,) {
  return MaterialButton(
    onPressed: onPressed,
    highlightColor: highlightColor,
    child: Icon(
      icon,
      size: iconSize,
      color: iconColor,
    ),
  );
}

Material materialWidget(BuildContext context,
    double? childSizeHeight,
    double? childSizeWidth,
    double radius,
    ImageProvider? image,
    BoxFit fit,
    List<Widget> child,
    MainAxisAlignment mainAxisAlignment,
    bool boxExist,
    double? padding,
    Color? background,
    VoidCallback onPressed,
    [CrossAxisAlignment? crossAxisAlignment]) {
  return Material(
    borderRadius: BorderRadius.circular(radius),
    child: InkWell(
      onTap: onPressed,
      child: Container(
        padding: EdgeInsets.all(padding ?? 0),
        height: childSizeHeight,
        width: childSizeWidth,
        decoration: BoxDecoration(
          color: background,
          borderRadius: BorderRadius.all(Radius.circular(radius)),
          image: DecorationImage(
            image: image ?? const AssetImage('assets/images/white.png'),
            fit: fit,
          ),
          boxShadow: boxExist
              ? [
            BoxShadow(
                blurRadius: 3,
                spreadRadius: 2,
                offset: const Offset(0, 1),
                color: darkGrey),
          ]
              : null,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center ,
          children: child,
        ),
      ),
    ),
  );
}

Widget textFormField({
  TextEditingController? controller,
  required TextInputType type,
  required String? Function(String?)? validate,
  required String hint,
  bool isSecure = false,
  Function(String?)? onSave,
  Function(String?)? onChange,
  Function()? onTap,
  Widget? suffixIcon,
  bool isExpanded = false,
  bool fromLTR = false,
  int maxLines = 1,
}) {
  return Padding(
    padding: EdgeInsets.symmetric(vertical: 5, horizontal: isExpanded ? 0 : 20),
    child: Directionality(
      textDirection: fromLTR ? TextDirection.ltr : TextDirection.rtl,
      child: TextFormField(

        onTap: onTap,
        keyboardType: type,
        onChanged: onChange,
        onSaved: onSave,
        maxLines: maxLines,
        controller: controller,
        validator: validate,
        obscureText: isSecure,
        autocorrect: false,
        enableSuggestions: false,
        textCapitalization: TextCapitalization.none,
        textAlignVertical: TextAlignVertical.center,
        cursorColor: petroleum,
        decoration: InputDecoration(
          suffixIcon: suffixIcon,
          hintText: hint,
          hintStyle: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w500,
            color: petroleum,
          ),
          filled: true,
          fillColor: white,
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: black),
            borderRadius: BorderRadius.circular(30),
          ),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: ko),
            borderRadius: BorderRadius.circular(30),
          ),
        ),
      ),
    ),
  );
}

Widget buildListTile(BuildContext ctx, String title, IconData icon,
    VoidCallback tapHandler) {
  return Directionality(
    textDirection: TextDirection.rtl,
    child: ListTile(
      leading: Icon(
        icon,
        color: petroleum,
      ),
      title: Text(
        title,
        style: TextStyle(
          color: petroleum,
          fontSize: sizeFromWidth(ctx, 20),
          fontWeight: FontWeight.bold,
        ),
      ),
      onTap: tapHandler,
    ),
  );
}

CircleAvatar storyShape(BuildContext context,
    Color background,
    ImageProvider? backgroundImage,
    double radius1,
    double radius2,) {
  return CircleAvatar(
    radius: sizeFromHeight(context, radius1),
    backgroundColor: background,
    child: CircleAvatar(
      radius: sizeFromHeight(context, radius2),
      backgroundColor: white,
      backgroundImage: backgroundImage,

    ),
  );
}

CircularPercentIndicator percentIndicator(BuildContext context, double value,
    Color background) {
  return CircularPercentIndicator(
    circularStrokeCap: CircularStrokeCap.round,
    radius: sizeFromWidth(context, 13),
    percent: value,
    center: Text('${value * 100}%',
        style: TextStyle(color: teal, fontWeight: FontWeight.w500)),
    backgroundColor: background,
    progressColor: teal,
    curve: Curves.ease,
  );
}
