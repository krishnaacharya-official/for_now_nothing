import 'package:flutter/material.dart';

class MyWidget extends StatelessWidget {
  const MyWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(),
        body: Center(
          child: ElevatedButton(
            onPressed: null,
            style:
                ElevatedButton.styleFrom(minimumSize: const Size.fromHeight(50))
                    .merge(ButtonStyle(
              backgroundColor: MaterialStateProperty.resolveWith<Color>(
                  (Set<MaterialState> states) {
                if (states.contains(MaterialState.disabled)) {
                  return Colors.green;
                } else {
                  return Colors.blue;
                }
              }),
            )),
            child: const Text("Hello"),
          ),
        ));
  }
}
