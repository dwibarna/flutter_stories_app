import 'package:flutter/material.dart';

class CustomTile extends StatelessWidget {
  final String title;
  final Function() onTap;
  final IconData customIcon;

  const CustomTile({
    super.key,
    required this.title,
    required this.onTap,
    required this.customIcon,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(
        title,
        style: Theme.of(context)
            .textTheme
            .bodyLarge!
            .copyWith(fontWeight: FontWeight.bold),
      ),
      leading: Icon(
        customIcon,
        color: Colors.black,
      ),
      trailing: const Icon(
        Icons.navigate_next,
        color: Colors.black,
      ),
      onTap: onTap,
    );
  }
}
