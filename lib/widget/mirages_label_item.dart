import 'package:flutter/material.dart';
import 'package:issue_blog/dto/label.dart';

class MiragesLabelItem extends StatelessWidget {
  const MiragesLabelItem({Key key, this.label, this.selected, this.onSelected}) : super(key: key);

  final Label label;
  final bool selected;
  final ValueChanged<bool> onSelected;

  @override
  Widget build(BuildContext context) {
    return FilterChip(
      labelStyle: TextStyle(
        color: Colors.black.withAlpha(229),
        fontSize: selected ? 16 : 14,
        fontWeight: selected ? FontWeight.bold : FontWeight.normal,
//        fontStyle: selected ? FontStyle.italic : FontStyle.normal,
      ),
      materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(0)),
      label: Padding(
        padding: const EdgeInsets.symmetric(vertical: 2),
        child: Text(label.name),
      ),
      backgroundColor: Colors.white,
      selected: selected,
      onSelected: onSelected,
    );
  }
}
