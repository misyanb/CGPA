import 'dart:convert';

import 'package:cgpa_application/core/app_export.dart';
import 'package:cgpa_application/presentation/login_screen/login_screen.dart';
import 'package:cgpa_application/widgets/app_bar/appbar_leading_iconbutton.dart';
import 'package:cgpa_application/widgets/app_bar/appbar_title.dart';
import 'package:cgpa_application/widgets/app_bar/custom_app_bar.dart';
import 'package:cgpa_application/widgets/custom_elevated_button.dart';
import 'package:cgpa_application/widgets/custom_text_form_field.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;


// ignore_for_file: must_be_immutable
class SignupScreen extends StatelessWidget {
  SignupScreen({Key? key}) : super(key: key);

  TextEditingController firstNameController = TextEditingController();

  TextEditingController lastNameController = TextEditingController();

  TextEditingController emailController = TextEditingController();

  TextEditingController passwordController = TextEditingController();

  GlobalKey<FormState> _formKey = GlobalKey<FormState>();


  Future register() async {
    var url = Uri.http(" 192.168.0.12", '/cgpa/register.php');
    var response = await http.post(url, body: {
      "firstName": firstNameController.text.toString(),
      "lastName": lastNameController.text.toString(),
      "email": emailController.text.toString(),
      "password": passwordController.text.toString(),
    });
    var data = jsonDecode(response.body);

    if (response.statusCode == 200) {
      if (data == "Error") {
        Fluttertoast.showToast(
          backgroundColor: Colors.greenAccent,
          textColor: Colors.white,
          msg: 'User registered successfully!',
          toastLength: Toast.LENGTH_SHORT,
        );
      } else {
        Fluttertoast.showToast(
          backgroundColor: Colors.redAccent,
          textColor: Colors.white,
          msg: 'User already exist!',
          toastLength: Toast.LENGTH_SHORT,
        );
      }
    }
  }
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
            backgroundColor: appTheme.gray5001,
            resizeToAvoidBottomInset: false,
            appBar: _buildAppBar(context),
            body: Form(
                key: _formKey,
                child: SingleChildScrollView(
                    padding: EdgeInsets.only(top: 27.v),
                    child: Container(
                        margin: EdgeInsets.only(bottom: 5.v),
                        padding: EdgeInsets.symmetric(horizontal: 28.h),
                        child: Column(children: [
                          _buildPageHeader(context),
                          SizedBox(height: 24.v),
                          _buildFirstName(context),
                          SizedBox(height: 24.v),
                          _buildLastName(context),
                          SizedBox(height: 24.v),
                          _buildEmail(context),
                          SizedBox(height: 24.v),
                          _buildPassword(context),
                          SizedBox(height: 22.v),
                          Align(
                              alignment: Alignment.centerLeft,
                              child: Container(
                                width: 248.h,
                                margin: EdgeInsets.only(right: 69.h),
                              )),
                          SizedBox(height: 27.v),
                          _buildSubmit(context),
                          SizedBox(height: 29.v),
                          GestureDetector(
                              onTap: () {
                                navigateToLogin(context);
                              },
                              child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text("Already have an account?",
                                        style: theme.textTheme.labelLarge),
                                    Padding(
                                        padding: EdgeInsets.only(left: 8.h),
                                        child: Text("Login",
                                            style: CustomTextStyles
                                                .labelLargeSecondaryContainerSemiBold))
                                  ]))
                        ]))))));
  }

  /// Section Widget
  PreferredSizeWidget _buildAppBar(BuildContext context) {
    return CustomAppBar(
        leadingWidth: 52.h,
        leading: AppbarLeadingIconbutton(
            imagePath: ImageConstant.imgArrowLeft,
            margin: EdgeInsets.only(left: 28.h, top: 14.v, bottom: 17.v),
            onTap: () {
              onTapArrowLeft(context);
            }),
        actions: [
          AppbarTitle(
              text: "Sign Up",
              margin: EdgeInsets.symmetric(horizontal: 45.h, vertical: 14.v))
        ]);
  }

  /// Section Widget
  Widget _buildPageHeader(BuildContext context) {
    return Padding(
        padding: EdgeInsets.only(right: 4.h),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          SizedBox(
              width: 218.h,
              child: Text("Ready to create your account",
                  maxLines: 3,
                  overflow: TextOverflow.ellipsis,
                  style: theme.textTheme.displaySmall!.copyWith(height: 1.18))),
          Container(
            width: 245.h,
            margin: EdgeInsets.only(right: 69.h),
          )
        ]));
  }

  /// Section Widget
  Widget _buildFirstName(BuildContext context) {
    return Padding(
        padding: EdgeInsets.only(right: 8.h),
        child: CustomTextFormField(
            controller: firstNameController, hintText: "First name"));
  }

  /// Section Widget
  Widget _buildLastName(BuildContext context) {
    return Padding(
        padding: EdgeInsets.only(right: 8.h),
        child: CustomTextFormField(
            controller: lastNameController, hintText: "Last name"));
  }

  /// Section Widget
  Widget _buildEmail(BuildContext context) {
    return Padding(
        padding: EdgeInsets.only(right: 8.h),
        child: CustomTextFormField(
            controller: emailController,
            hintText: "E-mail",
            textInputType: TextInputType.emailAddress));
  }

  /// Section Widget
  Widget _buildPassword(BuildContext context) {
    return Padding(
        padding: EdgeInsets.only(right: 8.h),
        child: CustomTextFormField(
            controller: passwordController,
            hintText: "Password",
            textInputAction: TextInputAction.done,
            textInputType: TextInputType.visiblePassword,
            obscureText: true));
  }

  /// Section Widget
  Widget _buildSubmit(BuildContext context) {
    return CustomElevatedButton(
        text: "Register", margin: EdgeInsets.symmetric(horizontal: 4.h));
  }

  /// Navigates back to the previous screen.
  onTapArrowLeft(BuildContext context) {
    Navigator.pop(context);
  }

  /// Navigates to the loginScreen when the action is triggered.
  navigateToLogin(BuildContext context) {
    Navigator.push(context, MaterialPageRoute(builder: (context) => LoginScreen()));
  }
}
