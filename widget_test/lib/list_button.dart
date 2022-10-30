import 'package:flutter/material.dart';
import 'package:widget_test/custom_button.dart';

class ButtonProperties {
  int page;
  Color color;

  ButtonProperties({required this.page, this.color = Colors.black});
}

class ListButtonProperties {
  int id;
  Color color;
  VoidCallback onPressed;

  ListButtonProperties({
    required this.id,
    required this.color,
    required this.onPressed,
  });
}

class ListButton extends StatefulWidget {
  ListButton({
    super.key,
    required this.itemCount,
    this.backgroundColor,
    this.selectedColor,
    this.maxHeight,
    required this.onPressed,
    required this.propertyList,
  });
  Color? backgroundColor;
  Color? selectedColor;
  VoidCallback onPressed;
  double? maxHeight;
  int itemCount;
  List<ListButtonProperties> propertyList;

  @override
  State<ListButton> createState() => _ListButtonState();
}

class _ListButtonState extends State<ListButton> {
  int selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: widget.propertyList
          .map((item) => CircleElevatedButton(
                color: item.id == selectedIndex
                    ? widget.selectedColor ?? Colors.cyan
                    : item.color,
                onPressed: () {
                  setState(() {
                    selectedIndex = item.id;
                  });
                  item.onPressed();
                },
                child: Text(item.id.toString()),
              ))
          .toList(),
    );
  }
}
