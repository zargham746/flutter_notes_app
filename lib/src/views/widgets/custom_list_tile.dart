import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomListTile extends StatelessWidget {
  final VoidCallback onTap;
  final IconData icon;
  final String title;
  const CustomListTile({
    Key? key,
    required this.onTap,
    required this.icon,
    required this.title,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: onTap,
      leading: Icon(
        icon,
        color: Theme.of(context).colorScheme.onPrimary,
      ),
      title: Text(
        title,
        style:
            Theme.of(context).textTheme.titleSmall!.copyWith(fontSize: 20.sp),
      ),
    );
  }
}
