import 'package:flutter/material.dart';
import 'package:swith/widgets/filter/filter_types_toggle_button_widget.dart';

class FilterDialog extends StatefulWidget {
  const FilterDialog({
    super.key,
  });

  @override
  State<FilterDialog> createState() => _FilterDialogState();
}

class _FilterDialogState extends State<FilterDialog> {
  List<bool> broadcastType = [true, false];
  List<bool> studyType = [false, false, false, false];
  List<bool> isPublic = [false, false];
  List<bool> chatType = [true, false];

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  void onSubmit() {
    if (mounted) {
      Navigator.pop(
        context,
        {
          "broadcastType": broadcastType,
          "studyType": studyType,
          "isPublic": isPublic,
          "chatType": chatType
        },
      );
    }
  }

  //bt 버튼 클릭 이벤트
  void setChatType(ct) {
    chatType = ct;
  }

  //bt 버튼 클릭 이벤트
  void setBroadcastType(bt) {
    broadcastType = bt;
  }

  //st 버튼 클릭 이벤트
  void setStudyType(st) {
    studyType = st;
  }

  //ip 버튼 클릭 이벤트
  void setIsPublic(ip) {
    isPublic = ip;
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
            typeName: "broadcastType",
            options: const [Icon(Icons.people), Icon(Icons.groups)],
            notifier: (idx) => setBroadcastType(idx),
          ),
          const SizedBox(
            height: 16,
          ),
          FilterTypesToggleButton(
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
          TextButton(onPressed: () {}, child: const Text("Submit")),
        ],
      ),
    );
  }
}
