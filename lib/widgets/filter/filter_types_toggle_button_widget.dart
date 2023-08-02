import 'package:flutter/material.dart';

class FilterTypesToggleButton extends StatefulWidget {
  final String typeName;
  final List<Widget> options;
  final Function notifier;
  final List<bool> selections;
  const FilterTypesToggleButton(
      {super.key,
      required this.typeName,
      required this.options,
      required this.notifier,
      required this.selections});

  @override
  State<FilterTypesToggleButton> createState() =>
      _FilterTypesToggleButtonState();
}

class _FilterTypesToggleButtonState extends State<FilterTypesToggleButton> {
  late final List<bool> _selections = widget.selections;

  @override
  void initState() {
    // _selections[0] = true;
    super.initState();
  }

  void onPressed(int index) {
    if (widget.typeName == "broadcastType" || widget.typeName == "chatType") {
      null;
    } else {
      setState(() {
        _selections.asMap().forEach((key, value) {
          if (key == index) {
            var count = 0;
            for (var element in _selections) {
              if (element == true) count++;
            }
            if (_selections[index] == true) {
              if (count > 1) {
                _selections[index] = !_selections[index];
              }
            } else {
              _selections[index] = !_selections[index];
            }
          }
        });
        widget.notifier(_selections);
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
          padding: EdgeInsets.only(left: width * 0.02),
          child: Text(widget.typeName),
        ),
        const SizedBox(
          height: 8,
        ),
        Center(
          child: ToggleButtons(
            isSelected: _selections,
            color: widget.typeName == "broadcastType"
                ? Theme.of(context).colorScheme.onSecondary
                : Theme.of(context).colorScheme.primaryContainer,
            selectedColor: Theme.of(context).colorScheme.onPrimaryContainer,
            fillColor: Theme.of(context).colorScheme.onPrimary,
            splashColor: Theme.of(context).colorScheme.onPrimary,
            highlightColor: Theme.of(context).colorScheme.onPrimary,
            borderRadius: const BorderRadius.all(Radius.circular(8)),
            constraints: BoxConstraints(
              minHeight: 40.0,
              minWidth: width * 0.6 / _selections.length,
            ),
            onPressed: onPressed,
            children: widget.options,
          ),
        ),
      ],
    );
  }
}
