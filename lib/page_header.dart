import 'package:flutter/material.dart';

class PageHeader extends StatelessWidget {
  final Widget? child;
  const PageHeader({
    Key? key, this.child,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
          color: Theme.of(context).primaryColor,
          borderRadius:
          const BorderRadius.vertical(bottom: Radius.circular(10))),
      child: child,
    );
  }
}
