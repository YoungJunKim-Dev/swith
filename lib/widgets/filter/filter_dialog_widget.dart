import 'package:flutter/material.dart';
import 'package:swith/screens/room_list_screen.dart';
import 'package:swith/widgets/filter/filter_types_toggle_button_widget.dart';

class FilterDialog extends StatefulWidget {
  final FilterOptions filterOptions;
  const FilterDialog({super.key, required this.filterOptions});

  @override
  State<FilterDialog> createState() => _FilterDialogState();
}

class _FilterDialogState extends State<FilterDialog> {
  FilterOptions filterOptions = {
    "broadcastType": [true, false],
    "studyType": [false, false, false, false],
    "isPublic": [false, false],
    "chatType": [true, false]
  };

  @override
  void initState() {
    filterOptions = widget.filterOptions;
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  void onSubmit(context) {
    if (mounted) {
      Navigator.pop(
        context,
        filterOptions,
      );
    }
  }

  //bt 버튼 클릭 이벤트
  void setChatType(ct) {
    filterOptions["chatType"] = ct;
  }

  //bt 버튼 클릭 이벤트
  void setBroadcastType(bt) {
    filterOptions["broadcastType"] = bt;
  }

  //st 버튼 클릭 이벤트
  void setStudyType(st) {
    filterOptions["studyType"] = st;
  }

  //ip 버튼 클릭 이벤트
  void setIsPublic(ip) {
    filterOptions["isPublic"] = ip;
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Center(child: Text("Select filter options")),
      content: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          FilterTypesToggleButton(
            selections: filterOptions["chatType"]!,
            typeName: "chatType",
            options: const [
              Text("Message"),
              Text("Video"),
            ],
            notifier: (idx) => setChatType(idx),
          ),
          const SizedBox(
            height: 16,
          ),
          FilterTypesToggleButton(
            selections: filterOptions["broadcastType"]!,
            typeName: "broadcastType",
            options: const [Icon(Icons.people), Icon(Icons.groups)],
            notifier: (idx) => setBroadcastType(idx),
          ),
          const SizedBox(
            height: 16,
          ),
          FilterTypesToggleButton(
            selections: filterOptions["studyType"]!,
            typeName: "studyType",
            options: const [
              Text("수능"),
              Text("공무원"),
              Text("취준"),
              Text("개발"),
            ],
            notifier: (idx) => setStudyType(idx),
          ),
          const SizedBox(
            height: 16,
          ),
          FilterTypesToggleButton(
            selections: filterOptions["isPublic"]!,
            typeName: "isPublic",
            options: const [
              Text("Public"),
              Text("Private"),
            ],
            notifier: (idx) => setIsPublic(idx),
          ),
          const SizedBox(
            height: 10,
          ),
          TextButton(
              onPressed: () {
                onSubmit(context);
              },
              child: const Text("Submit")),
        ],
      ),
    );
  }
}
