import 'package:flutter/material.dart';

class MenuWidget extends StatefulWidget {
  final IconData iconData;
  final Color color;
  final String title;
  final VoidCallback? onTap;
  const MenuWidget({super.key, required this.iconData, required this.color, required this.title, this.onTap});

  @override
  State<MenuWidget> createState() => _MenuWidgetState();
}

class _MenuWidgetState extends State<MenuWidget> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        GestureDetector(
          onTap: widget.onTap,
          child: Container(
              decoration: BoxDecoration(
                  color: widget.color.withOpacity(.2),
                  borderRadius: BorderRadius.circular(45)),
              padding: EdgeInsets.all(8),
              child: Icon(
                widget.iconData,
                color: widget.color,
                size: 37,
              )),
        ),
        Text(widget.title)
      ],
    );
  }
}
