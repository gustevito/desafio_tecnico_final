import 'package:flutter/material.dart';

class MyListTile extends StatelessWidget {
  final String text;
  final IconData icon;
  final void Function()? onTap;
  final Widget? trailing;

  const MyListTile({
    super.key,
    required this.text,
    required this.icon,
    required this.onTap,
    required this.trailing,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
      child: InkWell(
        borderRadius: BorderRadius.circular(10),
        onTap: onTap,
        child: ListTile(
          leading: Icon(
            icon,
            color: Theme.of(context).colorScheme.inversePrimary,
          ),
          title: Text(text),
          trailing: trailing,
        ),
      ),
    );
  }
}
