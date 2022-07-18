import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CustomDropDownMenu extends StatefulWidget {
  final int value;
  final List<String> items;
  final Function(int?) onChange;
  final bool expand;

  const CustomDropDownMenu({
    Key? key,
    required this.items,
    required this.onChange,
    required this.value, this.expand = true,
  }) : super(key: key);

  @override
  State<CustomDropDownMenu> createState() => _CustomDropDownMenuState();
}

class _CustomDropDownMenuState extends State<CustomDropDownMenu> {
  int value = 0;

  late List<DropdownMenuItem<int>> items;

  @override
  void initState() {
    items = [
      for (int i = 0; i < widget.items.length; i++)
        DropdownMenuItem<int>(
          value: i,
          child: Row(
            children: [Text(widget.items[i])],
          ),
        ),
    ];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 8,
        vertical: 4,
      ),
      // decoration: BoxDecoration(
      //   border: Border.all(color: Colors.grey),
      //   borderRadius: BorderRadius.circular(10),
      // ),
      child: DropdownButton<int>(
        // underline: const SizedBox(),
        value: value,
        items: items,
        isExpanded: widget.expand,
        onChanged: (v){
          setState(() {
            value = v!;
            widget.onChange(v);
          });
        },
      ),
    );
  }
}
