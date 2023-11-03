import 'package:flutter/material.dart';

class KlontongTagWidget extends StatefulWidget {
  const KlontongTagWidget({
    this.items,
    required this.onChange,
    required this.value,
    super.key,
  });

  final List<String>? items;
  final String value;
  final Function(String value) onChange;

  @override
  State<KlontongTagWidget> createState() => _KlontongTagWidgetState();
}

class _KlontongTagWidgetState extends State<KlontongTagWidget> {
  List<String> list = <String>['One', 'Two', 'Three', 'Four'];

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 180,
      height: 40,
      decoration: BoxDecoration(
        border: Border.all(),
        color: Colors.white70,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.12),
            blurRadius: 2,
            offset: const Offset(0, 2),
          )
        ],
        borderRadius: BorderRadius.circular(10),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      child: DropdownButton(
        underline: const SizedBox(),
        focusColor: Colors.transparent,
        isExpanded: true,
        items: widget.items?.map<DropdownMenuItem<String>>((String value) {
              return DropdownMenuItem<String>(
                value: value,
                child: Text(
                  value,
                  style: const TextStyle(fontSize: 12),
                ),
              );
            }).toList() ??
            list.map<DropdownMenuItem<String>>((String value) {
              return DropdownMenuItem<String>(
                value: value,
                child: Text(value),
              );
            }).toList(),
        value: widget.value,
        onChanged: (value) {
          setState(() {
            widget.onChange(value.toString());
          });
        },
      ),
    );
  }
}
