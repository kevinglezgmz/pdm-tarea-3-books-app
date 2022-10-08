import 'package:flutter/material.dart';

class ToggableText extends StatefulWidget {
  const ToggableText({
    Key? key,
    required this.text,
    required this.maxLines,
    this.style,
    this.textAlign,
  }) : super(key: key);

  final int maxLines;
  final String text;
  final TextStyle? style;
  final TextAlign? textAlign;

  @override
  State<ToggableText> createState() => _ToggableTextState();
}

class _ToggableTextState extends State<ToggableText> {
  bool isExpanded = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        setState(() {
          isExpanded = !isExpanded;
        });
      },
      child: Text(
        widget.text,
        style: widget.style,
        overflow: isExpanded ? TextOverflow.visible : TextOverflow.ellipsis,
        textAlign: widget.textAlign,
        softWrap: true,
        maxLines: isExpanded ? null : widget.maxLines,
      ),
    );
  }
}
