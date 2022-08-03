import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:qrcode/generated/l10n.dart';
import 'package:qrcode/model/qrcode_data_type.dart';
import 'package:qrcode/screen/scanned/scanned_page.dart';
import 'package:qrcode/sql/history_db.dart';
import 'package:qrcode/sql/history_model.dart';
import 'package:qrcode/utils/judge_qrcode_data_type.dart';

class BarcodeHistoryPage extends StatefulWidget {
  const BarcodeHistoryPage({
    Key? key,
  }) : super(key: key);

  @override
  State<BarcodeHistoryPage> createState() => _BarcodeHistoryPageState();
}

class _BarcodeHistoryPageState extends State<BarcodeHistoryPage>
    with TickerProviderStateMixin {
  bool editMode = false;

  List<int> editList = [];

  List<HistoryModel> histories = [];

  int currentShow = 0;

  late AnimationController expandController;
  late Animation<double> animation;

  @override
  void initState() {
    super.initState();
    Future.microtask(() async {
      histories = await HistoryDB.displayAllData();
      histories.sort((a, b) => b.createDate.compareTo(a.createDate));
      setState(() {});
    });
    expandController = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 200));
    animation = CurvedAnimation(
      parent: expandController,
      curve: Curves.fastOutSlowIn,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(S.of(context).result),
        actions: [
          if (!editMode)
            PopupMenuButton(
              itemBuilder: (context) {
                return [
                  PopupMenuItem(
                    onTap: () {
                      Future.microtask(() async {
                        histories = await HistoryDB.displayAllData();
                        histories.sort(
                            (a, b) => b.createDate.compareTo(a.createDate));
                        setState(() {});
                      });
                      setState(() {
                        currentShow = 0;
                      });
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(S.of(context).all),
                        if (currentShow == 0)
                          const Icon(
                            Icons.check,
                            color: Colors.blue,
                          ),
                      ],
                    ),
                  ),
                  PopupMenuItem(
                    onTap: () {
                      Future.microtask(() async {
                        histories = await HistoryDB.queryData(
                          queryType: QueryType.collect,
                          query: ['true'],
                        );
                        histories.sort(
                            (a, b) => b.createDate.compareTo(a.createDate));
                        setState(() {});
                      });
                      setState(() {
                        currentShow = 1;
                      });
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(S.of(context).collect),
                        if (currentShow == 1)
                          const Icon(
                            Icons.check,
                            color: Colors.blue,
                          ),
                      ],
                    ),
                  )
                ];
              },
              icon: const Icon(Icons.tune),
            ),
          SizeTransition(
            axis: Axis.horizontal,
            axisAlignment: 0,
            sizeFactor: animation,
            child: Center(
              child: Row(
                children: [
                  IconButton(
                    onPressed: () async {
                      for (final element in editList) {
                        if (histories[element].id != null) {
                          await HistoryDB.deleteData(histories[element].id!);
                        }
                      }
                      if (currentShow == 0) {
                        histories = await HistoryDB.displayAllData();
                      } else {
                        histories = await HistoryDB.queryData(
                          queryType: QueryType.collect,
                          query: ['true'],
                        );
                      }

                      histories
                          .sort((a, b) => b.createDate.compareTo(a.createDate));
                      editList.clear();
                      setState(() {});
                    },
                    icon: const Icon(Icons.delete_outline),
                  ),
                ],
              ),
            ),
          ),
          IconButton(
            onPressed: () {
              if (editMode) {
                setState(() {
                  editMode = false;
                  editList.clear();
                  expandController.reverse();
                });
              } else {
                setState(() {
                  editMode = true;
                  expandController.forward();
                });
              }
            },
            icon: Icon(editMode ? Icons.clear : Icons.mode_edit_outlined),
          ),
        ],
      ),
      body: histories.isEmpty
          ? Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [Text(S.of(context).noData)],
              ),
            )
          : Column(
              children: [
                SizeTransition(
                  sizeFactor: animation,
                  child: Row(
                    children: [
                      Checkbox(
                        value: editList.length == histories.length,
                        onChanged: (value) {
                          setState(() {
                            if (editList.length != histories.length) {
                              editList.clear();
                              for (int i = 0; i < histories.length; i++) {
                                editList.add(i);
                              }
                            } else {
                              editList.clear();
                            }
                          });
                        },
                      ),
                      Text(S.of(context).chooseAll),
                      const Spacer(),
                    ],
                  ),
                ),
                Expanded(
                  child: ListView.separated(
                    shrinkWrap: true,
                    itemCount: histories.length,
                    itemBuilder: (context, index) {
                      QRCodeDataType type = JudgeQrcodeDataType()
                          .judgeType(histories[index].content);
                      print(histories[index]);
                      return Row(
                        children: [
                          SizeTransition(
                            axis: Axis.horizontal,
                            sizeFactor: animation,
                            child: Checkbox(
                              value: editList.contains(index),
                              onChanged: (value) {
                                setState(() {
                                  if (editList.contains(index)) {
                                    editList.removeWhere(
                                        (element) => element == index);
                                  } else {
                                    editList.add(index);
                                  }
                                });
                              },
                            ),
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
                                            editList.removeWhere(
                                                (element) => element == index);
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
                                              historyModel: histories[index],
                                              onStateChange: () async {
                                                histories = await HistoryDB
                                                    .displayAllData();
                                                histories.sort((a, b) => b
                                                    .createDate
                                                    .compareTo(a.createDate));
                                                setState(() {});
                                              },
                                            ),
                                          ),
                                        );
                                      },
                                child: Container(
                                  height: 110,
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
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              histories[index].content,
                                              overflow: TextOverflow.ellipsis,
                                              maxLines: 3,
                                              style: const TextStyle(
                                                fontSize: 16,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                            Text(
                                              type.name +
                                                  ' · ' +
                                                  histories[index].qrcodeType,
                                              style: const TextStyle(
                                                color: Colors.grey,
                                                fontSize: 12,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.end,
                                        children: [
                                          IconButton(
                                            onPressed: () async {
                                              if (histories[index].favorite) {
                                                histories[index].favorite =
                                                    false;
                                              } else {
                                                histories[index].favorite =
                                                    true;
                                              }
                                              await HistoryDB.updateData(
                                                  histories[index]);
                                              histories = await HistoryDB
                                                  .displayAllData();
                                              histories.sort((a, b) => b
                                                  .createDate
                                                  .compareTo(a.createDate));
                                              setState(() {});
                                            },
                                            icon: Icon(
                                              histories[index].favorite
                                                  ? Icons.star
                                                  : Icons.star_border_outlined,
                                              color: histories[index].favorite
                                                  ? Colors.amberAccent
                                                  : Colors.grey,
                                            ),
                                          ),
                                          Text(
                                            DateFormat('yyyy/MM/dd \n HH:mm')
                                                .format(histories[index]
                                                    .createDate),
                                            textAlign: TextAlign.end,
                                            style: const TextStyle(
                                              fontSize: 12,
                                              color: Colors.grey,
                                            ),
                                          )
                                        ],
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
