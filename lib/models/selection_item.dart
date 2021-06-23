import 'package:flutter/material.dart';

class SelectionItem {
  final Key key;
  final int id;
  final String name;
  final String description;
  final IconData iconData;
  bool isSelected = false;

  SelectionItem(this.key, this.id, this.name, this.description, this.iconData,
      this.isSelected);

  bool operator ==(o) => o is SelectionItem && o.id == this.id;
  int get hashCode => 32 * this.id;
}
