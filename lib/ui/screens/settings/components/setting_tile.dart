import 'package:flutter/material.dart';

class SettingTile extends StatelessWidget {
  final String title;
  final Widget trailing;
  final Widget? leading;
  const SettingTile({Key? key, required this.title, required this.trailing, this.leading})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: leading,
      title: Text(
        title,
        style: Theme.of(context).textTheme.titleSmall,
      ),
      trailing: trailing,
    );
  }
}
