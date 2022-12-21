import 'package:flutter/material.dart';
import 'package:newsapp/ui/screens/settings/components/setting_tile.dart';

class SettingSection extends StatelessWidget {
  final String title;
  final List<SettingTile> tiles;

  const SettingSection({Key? key, required this.title, required this.tiles})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 16,top: 10,bottom: 10),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: Theme.of(context)
                .textTheme
                .titleLarge
                ?.copyWith(color: Theme.of(context).primaryColor),
          ),
          Divider(
            color: Theme.of(context).primaryColor,
            thickness: 2,
          ),
          ...tiles
        ],
      ),
    );
  }
}
