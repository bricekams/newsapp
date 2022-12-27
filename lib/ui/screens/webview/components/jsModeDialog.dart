import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:newsapp/utils/localization.dart';

class EnableJsDialog extends StatelessWidget {
  final String lang;

  const EnableJsDialog({Key? key, required this.lang}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(
        dictionary["@enableJs"][lang],
        style: const TextStyle(
          fontWeight: FontWeight.bold,
        ),
      ),
      contentPadding:
          const EdgeInsets.only(left: 20, right: 20, top: 20, bottom: 0),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            dictionary["@enableJsProposal"][lang],
            style: const TextStyle(
              fontWeight: FontWeight.w500,
            ),
          ),
          Row(
            children: [
              ValueListenableBuilder<Box>(
                valueListenable: Hive.box('settings').listenable(),
                builder: (context, box, child) {
                  return Checkbox(
                    value: box.get("doNotShowJsWarning") as bool,
                    onChanged: (value) {
                      box.put("doNotShowJsWarning", value);
                    },
                  );
                },
              ),
              Text(
                dictionary["@doNotShow"][lang],
                style: const TextStyle(
                  fontWeight: FontWeight.w500,
                ),
              )
            ],
          )
        ],
      ),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.pop(context);
          },
          child: Text(
            dictionary["@cancel"][lang],
            style: TextStyle(
                fontWeight: FontWeight.w500,
                color: Theme.of(context).primaryColor),
          ),
        ),
        TextButton(
          onPressed: () {
            Navigator.pop(context);
            Hive.box('settings').put("jsMode", true);
            Hive.box('settings').put("doNotShowJsWarning", true);
          },
          child: Text(
            dictionary["@yes"][lang],
            style: TextStyle(color: Theme.of(context).primaryColor),
          ),
        )
      ],
    );
  }
}
