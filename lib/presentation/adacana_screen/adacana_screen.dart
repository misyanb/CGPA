import 'package:cgpa_application/core/app_export.dart';
import 'package:flutter/material.dart';

class AdacanaScreen extends StatelessWidget {
  const AdacanaScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
            body: SizedBox(
                width: double.maxFinite,
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(height: 1.v),
                      CustomImageView(
                          imagePath: ImageConstant.imgLogo,
                          height: 325.v,
                          width: 238.h,
                          onTap: () {
                            onTapImgCGPA(context);
                          })
                    ]))));
  }

  /// Navigates to the loginOrSignupScreen when the action is triggered.
  onTapImgCGPA(BuildContext context) {
    Navigator.pushNamed(context, AppRoutes.loginOrSignupScreen);
  }
}
