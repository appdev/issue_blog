import 'package:flutter/material.dart';
import 'package:issue_blog/dto/label.dart';
import 'package:issue_blog/utils/hex_color.dart';

class LabelItem extends StatelessWidget {
  const LabelItem({Key key, this.label, this.selected, this.onSelected, this.miniSize})
      : super(key: key);

  final Label label;
  final bool selected;
  final ValueChanged<bool> onSelected;
  final bool miniSize;

  @override
  Widget build(BuildContext context) {
    return Transform.scale(
      scale: miniSize ? 0.8 : 1,
      child: FilterChip(
        labelStyle: TextStyle(
          color: Colors.white,
          fontSize: selected ? 16 : 14,
          fontWeight: selected ? FontWeight.bold : FontWeight.normal,
//        fontStyle: selected ? FontStyle.italic : FontStyle.normal,
        ),
        materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        label: Text(label.name),
        backgroundColor:
            label.color.toUpperCase().contains("FFFFFF") ? Colors.blueGrey : HexColor(label.color),
        selected: selected,
        onSelected: onSelected,
      ),
    );
  }
}
