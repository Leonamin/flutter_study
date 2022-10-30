import 'package:flutter/material.dart';
import 'package:widget_test/custom_button.dart';
import 'package:widget_test/list_button.dart';

class CircleButton extends StatelessWidget {
  CircleButton({Key? key}) : super(key: key);

  int index = 1;

  Widget _circleTextButton() {
    return ClipRRect(
      borderRadius: BorderRadius.circular(30),
      child: TextButton(
          onPressed: () {},
          child: Text(
            (index + 1).toString(),
            style: const TextStyle(
                color: Colors.white, backgroundColor: Colors.blue),
          )),
    );
  }

  Widget _circleElevatedButton() {
    return ClipRRect(
        borderRadius: BorderRadius.circular(30),
        child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              minimumSize: const Size(50, 50),
            ),
            onPressed: () {},
            child: Text(
              (index + 1).toString(),
              style: const TextStyle(color: Colors.white),
            )));
  }

  @override
  Widget build(BuildContext context) {
    List<ListButtonProperties> buttonList = [];
    for (int i = 0; i < 5; i++) {
      buttonList.add(ListButtonProperties(
          id: i + 1,
          color: Colors.blue,
          onPressed: () {
            print("fuck you");
          }));
    }
    return Scaffold(
      body: Center(
        // child: Column(
        //   children: [
        //     MaterialButton(
        //       // onPressed: widget.onPressed,
        //       onPressed: () {
        //         // setState(() {
        //         //   selectedIndex = index;
        //         // });
        //       },
        //       // padding: EdgeInsets.all(50),
        //       shape: const StadiumBorder(),
        //       color: Colors.black,
        //       child: Text((index + 1).toString()),
        //     ),
        //     _circleTextButton(),
        //     _circleElevatedButton(),
        //     CircleElevatedButton(
        //         child: Text((index + 1).toString()),
        //         onPressed: () {
        //           print("fuck");
        //         }),
        //     ListButton(itemCount: 5),
        //   ],
        // ),
        child: ListButton(
          itemCount: 5,
          propertyList: buttonList,
          onPressed: () {
            print("fuck");
          },
        ),
      ),
    );
  }
}
