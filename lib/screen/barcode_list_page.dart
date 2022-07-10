import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:qrcode/generated/l10n.dart';
import 'package:qrcode/model/qrcode_data_type.dart';
import 'package:qrcode/screen/scanned/scanned_page.dart';
import 'package:qrcode/sql/history_db.dart';
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
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(S.of(context).result),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.separated(
              shrinkWrap: true,
              itemCount: widget.histories.length,
              itemBuilder: (context, index) {
                QRCodeDataType type = JudgeQrcodeDataType()
                    .judgeType(widget.histories[index].content);

                return Row(
                  children: [
                    Expanded(
                      child: Card(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15.0),
                        ),
                        color: const Color(0xffedf3ff),
                        elevation: 0,
                        child: InkWell(
                          onTap: () {
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (context) => ScannedPage(
                                  type: type,
                                  historyModel: widget.histories[index],
                                  onStateChange: () {
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
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                    CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        widget.histories[index].content + '\n123',
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
                                            widget.histories[index].qrcodeType,
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
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: [
                                    IconButton(
                                      onPressed: () async {
                                        if (widget.histories[index].favorite) {
                                          widget.histories[index].favorite = false;
                                        } else {
                                          widget.histories[index].favorite = true;
                                        }
                                        await HistoryDB.updateData(
                                            widget.histories[index]);
                                        setState(() {});
                                      },
                                      icon: Icon(
                                        widget.histories[index].favorite
                                            ? Icons.star
                                            : Icons.star_border_outlined,
                                        color: widget.histories[index].favorite
                                            ? Colors.amberAccent
                                            : Colors.grey,
                                      ),
                                    ),
                                    Text(
                                      DateFormat('yyyy/MM/dd \n HH:mm')
                                          .format(widget.histories[index].createDate),
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
