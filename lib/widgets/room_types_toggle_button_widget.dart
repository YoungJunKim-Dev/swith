import 'package:flutter/material.dart';

class RoomTypesToggleButton extends StatefulWidget {
  final String typeName;
  final List<Widget> options;
  final Function notifier;
  const RoomTypesToggleButton(
      {super.key,
      required this.typeName,
      required this.options,
      required this.notifier});

  @override
  State<RoomTypesToggleButton> createState() => _RoomTypesToggleButtonState();
}

class _RoomTypesToggleButtonState extends State<RoomTypesToggleButton> {
  late final List<bool> _selections =
      List.generate(widget.options.length, (_) => false);

  @override
  void initState() {
    _selections[0] = true;
    super.initState();
  }

  void onPressed(int index) {
    if (widget.typeName == "broadcastType") {
      null;
    } else {
      setState(() {
        _selections.asMap().forEach((key, value) {
          if (key == index) {
            _selections[index] = true;
          } else {
            _selections[key] = false;
          }
        });
        widget.notifier(index);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [Text(widget.typeName)],
        ),
        ToggleButtons(
          isSelected: _selections,
          color:
              widget.typeName == "broadcastType" ? Colors.grey : Colors.black,
          selectedColor: Colors.white,
          fillColor: Colors.blue,
          splashColor:
              widget.typeName == "broadcastType" ? Colors.amber : Colors.blue,
          highlightColor: Colors.blue,
          onPressed: onPressed,
          children: widget.options,
        ),
      ],
    );
  }
}
