import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:firebase_auth/firebase_auth.dart';

// ------------- my packages -----------------
import '../models/userIdStatus.dart';
import '../widgets/userIdSetUpWidget.dart';
import '../widgets/courseSetUpWidget.dart';
import '../widgets/acceptUserIdWidget.dart';
import '../widgets/mainProduct.dart';
import '../widgets/welcomeWidget.dart';
import '../widgets/verificationWidget.dart';

class HomePageWidget extends StatefulWidget {
  @override
  _HomePageWidgetState createState() => _HomePageWidgetState();
}

class _HomePageWidgetState extends State<HomePageWidget> {
  Widget build(BuildContext context) {
    final user = Provider.of<User>(context);
    final userIdStatus = context.watch<UserIdStatus>();
    final _iniAssent = userIdStatus.getIniAssent();
    final _haveUserIdStatus = userIdStatus.getUserIdStatus();
    final _isUserIdAvailable = userIdStatus.getUserIdAvailableStatus();
    final _isCourseSetUpDone = userIdStatus.getCourseSetUpStatus();
    return Scaffold(
      body: (user.emailVerified)
          ? (_iniAssent
              ? (_haveUserIdStatus
                  ? (_isUserIdAvailable
                      ? AcceptUserIdWidget()
                      : (_isCourseSetUpDone
                          ? MainProductWidget()
                          : CourseSetUpWidget()))
                  : UserIdSetUpWidget())
              : WelcomeWidget())
          : VerificationWidget(),
    );
  }
}
