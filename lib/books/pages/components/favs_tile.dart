import 'package:flutter/material.dart';

class CartTile extends StatelessWidget {
  final Widget? title;
  final Widget? subtitle;
  final void Function()? onPressed;

  const CartTile({
    super.key,
    required this.title,
    required this.subtitle,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
      child: Material(
        elevation: 1,
        borderRadius: BorderRadius.circular(10),
        child: ListTile(
          tileColor: Theme.of(context).colorScheme.primary,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          title: title,
          subtitle: subtitle,
          trailing: IconButton(
            icon: Icon(Icons.remove),
            onPressed: onPressed,
          ),
        ),
      ),
    );
  }
}
