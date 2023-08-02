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
  String typeInKorean = "";

  @override
  void initState() {
    _selections[0] = true;
    switch (widget.typeName) {
      case 'broadcastType':
        typeInKorean = "인원";
        break;

      case 'chatType':
        typeInKorean = "채팅";

        break;

      case 'studyType':
        typeInKorean = "공부";

        break;

      case 'isPublic':
        typeInKorean = "공개";

        break;
    }
    super.initState();
  }

  void onPressed(int index) {
    if (widget.typeName == "broadcastType" || widget.typeName == "chatType") {
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
    var width = MediaQuery.of(context).size.width;

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.only(left: width * 0.08),
          child: Text(typeInKorean),
        ),
        const SizedBox(
          height: 8,
        ),
        Center(
          child: ToggleButtons(
            isSelected: _selections,
            color: widget.typeName == "broadcastType" ||
                    widget.typeName == "chatType"
                ? Theme.of(context).colorScheme.onSecondary
                : Theme.of(context).colorScheme.primaryContainer,
            selectedColor: Theme.of(context).colorScheme.onPrimaryContainer,
            fillColor: Theme.of(context).colorScheme.onPrimary,
            splashColor: Theme.of(context).colorScheme.onPrimary,
            highlightColor: Theme.of(context).colorScheme.onPrimary,
            borderRadius: const BorderRadius.all(Radius.circular(8)),
            constraints: BoxConstraints(
              minHeight: 40.0,
              minWidth: width * 0.74 / _selections.length,
            ),
            onPressed: onPressed,
            children: widget.options,
          ),
        ),
      ],
    );
  }
}
