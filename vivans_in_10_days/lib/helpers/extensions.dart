import 'package:flutter/material.dart';
import 'package:vivans_in_10_days/design_system/colors.dart';

extension Hello on Widget {
  Widget centerWidget() {
    return Center(
      child: this,
    );
  }

  Widget paddingAll(int x) {
    return Padding(padding: EdgeInsets.all(x.toDouble()), child: this);
  }

  Widget paddingBottom(int x) {
    return Padding(
      padding: EdgeInsets.only(bottom: x.toDouble()),
    );
  }

  Widget paddingHorizontal([int? x]) {
    return Padding(
      padding:
          EdgeInsets.symmetric(vertical: 0, horizontal: x?.toDouble() ?? 8),
      child: this,
    );
  }

  Widget paddingVertical([int? x]) {
    return Padding(
      padding:
          EdgeInsets.symmetric(vertical: x?.toDouble() ?? 8, horizontal: 0),
      child: this,
    );
  }

  Widget VisibleWidget(bool visible) {
    return Visibility(visible: visible, child: this);
  }

  Widget marginTop([int? x]) {
    return Container(
        margin: EdgeInsets.only(top: x?.toDouble() ?? 16), child: this);
  }

  Widget marginDown([int? x]) {
    return Container(
        margin: EdgeInsets.only(bottom: x?.toDouble() ?? 16), child: this);
  }

  Widget marginLeft([int? x]) {
    return Container(
        margin: EdgeInsets.only(left: x?.toDouble() ?? 16), child: this);
  }

  Widget marginRight([int? x]) {
    return Container(
        margin: EdgeInsets.only(right: x?.toDouble() ?? 16), child: this);
  }

  Widget marginLeftRight([int? x]) {
    return Container(
      margin: EdgeInsets.only(
          left: x?.toDouble() ?? 16, right: x?.toDouble() ?? 16),
      // const EdgeInsets.only(left: 8, right: 8),
      child: this,
    );
  }

  Widget roundedCorner([int? x]) {
    return ClipRRect(
        borderRadius: BorderRadius.circular(x?.toDouble() ?? 20), child: this);
  }

  Widget addWidgetColor(Color color) {
    return Container(
      color: color,
      child: this,
    );
  }

  Widget addGradient(
      Alignment begin, Alignment end, Color colorStart, Color colorEnd) {
    return Container(
      decoration: BoxDecoration(
          gradient: LinearGradient(
              begin: begin, end: end, colors: [colorStart, colorEnd])),
      child: this,
    );
  }
}

extension Other on FilledButton {
  addButtonStyle() {
    return FilledButton(
      onPressed: () {},
      style: FilledButton.styleFrom(foregroundColor: DesignColor.red),
      child: const Text("Hello"),
    );
  }
}

class TextStyleTitleLarge extends StatelessWidget {
  final String text;
  const TextStyleTitleLarge(this.text, {super.key});

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: Theme.of(context).textTheme.titleLarge,
    );
  }
}

class TextStyleTitleMedium extends StatelessWidget {
  final String text;
  final Color? color;
  const TextStyleTitleMedium(this.text, {super.key, this.color});

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: Theme.of(context).textTheme.titleMedium?.copyWith(color: color),
    );
  }
}

class TextStyleTitleSmall extends StatelessWidget {
  final String text;
  const TextStyleTitleSmall(this.text, {super.key});

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: Theme.of(context).textTheme.titleSmall,
    );
  }
}

class TextStyleBodyLarge extends StatelessWidget {
  final String text;
  const TextStyleBodyLarge(this.text, {super.key});

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: Theme.of(context).textTheme.bodyLarge,
    );
  }
}

class TextStyleBodyMedium extends StatelessWidget {
  final String text;
  const TextStyleBodyMedium(this.text, {super.key});

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: Theme.of(context).textTheme.bodyMedium,
    );
  }
}

class TextStyleBodySmall extends StatelessWidget {
  final String text;
  const TextStyleBodySmall(this.text, {super.key});

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: Theme.of(context).textTheme.bodySmall,
    );
  }
}

class TextStyleLabelLarge extends StatelessWidget {
  final String text;
  const TextStyleLabelLarge(this.text, {super.key});

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: Theme.of(context).textTheme.labelLarge,
    );
  }
}

class TextStyleLabelMedium extends StatelessWidget {
  final String text;
  const TextStyleLabelMedium(this.text, {super.key});

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: Theme.of(context).textTheme.labelMedium,
    );
  }
}

class TextStyleLabelSmall extends StatelessWidget {
  final String text;
  const TextStyleLabelSmall(this.text, {super.key});

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: Theme.of(context).textTheme.labelSmall,
    );
  }
}



// extension sample on Container {
//   Container roundedCorner([Color? color, int? x]) {
//     return Container(
//         decoration: BoxDecoration(
//             border: Border.all(),
//             borderRadius: BorderRadius.circular(x?.toDouble() ?? 20)),
//         child: this);
//   }

//   Container addGradient(Color colorStart, Color colorEnd) {
//     return Container(
//       // decoration: BoxDecoration(
//       //     border: Border.all(),
//       //     borderRadius: BorderRadius.circular(20),
//       //     gradient: LinearGradient(colors: [colorStart, colorEnd])),
//       decoration: this.decoration.lerpFrom(a, t),
//       child: this,
//     );
//   }
// }

// extension sample on Widget {
//   Widget roundedCorner([Color? color, int? x]) {
    // return ClipRRect(
    //   borderRadius: BorderRadius.circular(x?.toDouble() ?? 20),
    //   child: Container(
    //     decoration: BoxDecoration(
    //       border: Border.all(),
    //     ),
    //     child: this,
    //   ),
    // );
//   }

//   Widget addGradient(Color colorStart, Color colorEnd) {
//     return Container(
//       decoration: BoxDecoration(
//         gradient: LinearGradient(colors: [colorStart, colorEnd]),
//       ),
//       child: this,
//     );
//   }
// }
