import 'package:flutter/material.dart';
import 'package:chatbotstudy/features/authentication/services/auth_service.dart';
import 'package:chatbotstudy/utils/constants/pages.dart';
import 'package:get/get.dart';

class AuthMiddleware extends GetMiddleware {
  @override
  RouteSettings? redirect(String? route) {
    if (AuthService.authenticated && route != mainScreen) {
      return RouteSettings(name: mainScreen);
    }
    if (!AuthService.authenticated && route != onBoardingScreen) {
      return RouteSettings(name: onBoardingScreen);
    }
    return null;
  }
}
