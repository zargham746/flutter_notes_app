// ignore_for_file: public_member_api_docs, sort_constructors_first, use_build_context_synchronously
import 'package:flutter/material.dart';
import 'package:flutter_inkflow_app/src/res/strings.dart';
import 'package:flutter_inkflow_app/src/services/auth_services.dart';
import 'package:flutter_inkflow_app/src/views/create_note.dart';
import 'package:flutter_inkflow_app/src/views/login_screen.dart';
import 'package:flutter_inkflow_app/src/views/widgets/custom_list_tile.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class MainDrawer extends StatefulWidget {
  const MainDrawer({
    super.key,
  });

  @override
  State<MainDrawer> createState() => _MainDrawerState();
}

class _MainDrawerState extends State<MainDrawer> {
  final brightness =
      WidgetsBinding.instance.platformDispatcher.platformBrightness;
  AuthService authService = AuthService();
  @override
  Widget build(BuildContext context) {
    return Drawer(
      width: MediaQuery.of(context).size.width / 1.5,
      child: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              height: 40.h,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                brightness == Brightness.dark
                    ? Image.asset(
                        'assets/icons/logo-dark-mode.png',
                        height: 35.h,
                        width: 35.w,
                      )
                    : Image.asset(
                        'assets/icons/logo-light-mode.png',
                        height: 35.h,
                        width: 35.w,
                      ),
                SizedBox(
                  width: 10.w,
                ),
                Text(
                  AppStrings.appName,
                  style: Theme.of(context).textTheme.titleSmall!.copyWith(
                        fontSize: 30.sp,
                      ),
                ),
              ],
            ),
            SizedBox(
              height: 100.h,
            ),
            CustomListTile(
              onTap: () {
                Navigator.pop(context);
                Navigator.pushNamed(
                  context,
                  CreateNoteView.routeName,
                );
              },
              icon: Icons.add,
              title: 'New Note',
            ),
            CustomListTile(
              onTap: () {},
              icon: Icons.info_outlined,
              title: 'About us',
            ),
            CustomListTile(
              onTap: () async {
                await authService.signOut();
                Navigator.of(context).pushAndRemoveUntil(
                    MaterialPageRoute(
                      builder: (context) => const LoginScreen(),
                    ),
                    (route) => false);
              },
              icon: Icons.logout,
              title: 'Logout',
            ),
            const Spacer(),
            Text(
              'Copyrights @ FastCode Developers',
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.bodyMedium,
            )
          ],
        ),
      ),
    );
  }
}
