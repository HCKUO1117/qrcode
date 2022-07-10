import 'package:flutter/material.dart';
import 'package:qrcode/generated/l10n.dart';
import 'package:qrcode/model/qrcode_data_type.dart';
import 'package:qrcode/screen/scanned/scanned_page.dart';
import 'package:qrcode/sql/history_model.dart';
import 'package:qrcode/utils/judge_qrcode_data_type.dart';

class BarcodeListPage extends StatefulWidget {
  final List<HistoryModel> histories;

  const BarcodeListPage({
    Key? key,
     required this.histories,
  }) : super(key: key);

  @override
  State<BarcodeListPage> createState() => _BarcodeListPageState();
}

class _BarcodeListPageState extends State<BarcodeListPage> {
  bool editMode = false;

  List<int> editList = [];

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(S.of(context).result),
        actions: [
          if (editMode)
            IconButton(
              onPressed: () {},
              icon: const Icon(Icons.delete_outline),
            ),
          IconButton(
            onPressed: () {
              if (editMode) {
                setState(() {
                  editMode = false;
                  editList.clear();
                });
              } else {
                setState(() {
                  editMode = true;
                });
              }
            },
            icon: Icon(editMode ? Icons.done : Icons.mode_edit_outlined),
          )
        ],
      ),
      body: Column(
        children: [
          if (editMode)
            Row(
              children: [
                Checkbox(
                  value: editList.length == widget.histories.length,
                  onChanged: (value) {
                    setState(() {
                      if (editList.length != widget.histories.length) {
                        editList.clear();
                        for (int i = 0; i < widget.histories.length; i++) {
                          editList.add(i);
                        }
                      } else {
                        editList.clear();
                      }
                    });
                  },
                ),
              ],
            ),
          Expanded(
            child: ListView.separated(
              shrinkWrap: true,
              itemCount: widget.histories.length,
              itemBuilder: (context, index) {
                QRCodeDataType type =
                    JudgeQrcodeDataType().judgeType(widget.histories[index].content);

                return Row(
                  children: [
                    if (editMode)
                      Checkbox(
                        value: editList.contains(index),
                        onChanged: (value) {
                          setState(() {
                            if (editList.contains(index)) {
                              editList.removeWhere((element) => element == index);
                            } else {
                              editList.add(index);
                            }
                          });
                        },
                      ),
                    Expanded(
                      child: Card(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15.0),
                        ),
                        color: const Color(0xffedf3ff),
                        elevation: editMode ? 2 : 0,
                        child: InkWell(
                          onTap: editMode
                              ? () {
                                  setState(() {
                                    if (editList.contains(index)) {
                                      editList.removeWhere((element) => element == index);
                                    } else {
                                      editList.add(index);
                                    }
                                  });
                                }
                              : () {
                                  Navigator.of(context).push(
                                    MaterialPageRoute(
                                      builder: (context) => ScannedPage(
                                        type: type,
                                        historyModel: widget.histories[index],
                                      ),
                                    ),
                                  );
                                },
                          child: Padding(
                            padding: const EdgeInsets.all(8),
                            child: Row(
                              children: [
                                Icon(
                                  type.icon,
                                  size: 30,
                                ),
                                const SizedBox(width: 8),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        widget.histories[index].content,
                                        overflow: TextOverflow.ellipsis,
                                        maxLines: 3,
                                        style: const TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      Text(
                                        type.name + ' · ' + widget.histories[index].qrcodeType,
                                        style: const TextStyle(color: Colors.grey),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                );
              },
              separatorBuilder: (context, index) {
                return const SizedBox(height: 4);
              },
            ),
          ),
        ],
      ),
    );
  }
}
