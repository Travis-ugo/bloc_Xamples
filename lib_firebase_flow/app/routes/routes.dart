import 'package:flutter/material.dart';

import '../../home/view/home_page.dart';
import '../../login/view/view.dart';
import '../../signup/view/view.dart';
import '../bloc/app_bloc.dart';

List<Page<dynamic>> onGenerateAppViewPages(
  AppStatus status,
  List<Page<dynamic>> pages,
) {
  switch (status) {
    case AppStatus.authenticated:
      return [HomePage.page()];

    case AppStatus.unauthenticated:
      return [SignupPage.page()];
  }
}
