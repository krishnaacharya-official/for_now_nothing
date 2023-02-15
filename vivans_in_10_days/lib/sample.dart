// import 'dart:math';

// import 'package:flutter/material.dart';

// class MyWidget extends StatefulWidget {
//   const MyWidget({super.key});

//   @override
//   _MyWidgetState createState() => _MyWidgetState();
// }

// class _MyWidgetState extends State<MyWidget> {
//   final List<Product> _products = [
//     Product(name: "Apple car"),
//     Product(name: "Banana"),
//     Product(name: "car Carrot"),
//     Product(name: "Dog Food"),
//     Product(name: "Eggs what"),
//   ];

//   final List<Category> _categories = [
//     Category(name: "what Fruits"),
//     Category(name: "what Fruits"),
//     Category(name: "what Fruits"),
//     Category(name: "what Fruits"),
//     Category(name: "what Fruits"),
//     Category(name: "Vegetables bwhat"),
//     Category(name: "Pets"),
//     Category(name: "Food"),
//   ];

//   final TextEditingController _textController = TextEditingController();
//   List<Object> _suggestions = [];
//   var _showNoProductsFound = false;
//   @override
//   Widget build(BuildContext context) {
//     return SafeArea(
//       child: Scaffold(
//         body: Column(
//           children: [
//             Container(
//                 decoration: BoxDecoration(
//                     border: Border.all(
//                         color: Colors.transparent,
//                         width: 0.0,
//                         style: BorderStyle.none),
//                     borderRadius: const BorderRadius.all(Radius.circular(10))),
//                 child: TextField(
//                   controller: _textController,
//                   decoration: InputDecoration(
//                     prefixIcon: const Icon(Icons.search),
//                     suffixIcon: IconButton(
//                         icon: const Icon(Icons.cancel),
//                         onPressed: () {
//                           if (_textController.text.trim() != "") {
//                             setState(() {
//                               _suggestions = _getRandomSuggestions();
//                             });
//                           }
//                           _textController.clear();
//                         }),
//                     hintText: "Search for products or categories",
//                     border: InputBorder.none,
//                   ),
//                   onChanged: (text) {
//                     setState(() {
//                       _suggestions = _filterSuggestions(text);
//                       if (_suggestions.isEmpty) {
//                         _showNoProductsFound = true;
//                       } else {
//                         _showNoProductsFound = false;
//                       }
//                     });
//                   },
//                   onTap: () {
//                     if (_suggestions.isEmpty) {
//                       setState(() {
//                         _suggestions = _getRandomSuggestions();
//                       });
//                     }
//                   },
//                 )),
//             Expanded(
//               child: _showNoProductsFound
//                   ? const Text("No products found")
//                   : ListView.builder(
//                       itemCount: _suggestions.length,
//                       itemBuilder: (BuildContext context, int index) {
//                         final suggestion = _suggestions[index];
//                         if (suggestion is Product) {
//                           return ListTile(
//                             title: Text(suggestion.name),
//                             subtitle: const Text("element in product"),
//                           );
//                         } else if (suggestion is Category) {
//                           return ListTile(
//                             title: Text(suggestion.name),
//                             subtitle: const Text("element in category"),
//                           );
//                         }
//                         return null;
//                       },
//                     ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }

//   List<Object> _getRandomSuggestions() {
//     final List<Object> randomSuggestions = [];
//     final List<Object> allSuggestions =
//         _products.cast<Suggestion>() + _categories.cast<Suggestion>();
//     final Set<Object> usedSuggestions = {};
//     final Random random = Random();

//     while (randomSuggestions.length < 5) {
//       final int randomIndex = random.nextInt(allSuggestions.length);
//       final Object suggestion = allSuggestions[randomIndex];

//       if (!usedSuggestions.contains(suggestion)) {
//         usedSuggestions.add(suggestion);
//         randomSuggestions.add(suggestion);
//       }
//     }
//     return randomSuggestions;
//   }

//   // List<Object> _filterSuggestions(String text) {
//   //   final List<Object> suggestions = [];
//   //   for (final product in _products) {
//   //     if (product.name.toLowerCase().contains(text.toLowerCase())) {
//   //       suggestions.add(product);
//   //     }
//   //   }
//   //   for (final category in _categories) {
//   //     if (category.name.toLowerCase().contains(text.toLowerCase())) {
//   //       suggestions.add(category);
//   //     }
//   //   }
//   //   return suggestions.take(5).toList();
//   // }
//   List<Object> _filterSuggestions(String text) {
//     print("==============Start===============");
//     final List<Object> suggestions = [];
//     text = text.toLowerCase();

//     for (final product in _products) {
//       final productName = product.name.toLowerCase();
//       if (suggestions.length == 5) {
//         print("I am breaking out of product search loop");
//         break;
//       }
//       print("looping in products");
//       for (final subWord in productName.split(" ")) {
//         if (subWord.startsWith(text)) {
//           suggestions.add(product);
//           break;
//         }
//       }
//     }
//     for (final category in _categories) {
//       final categoryName = category.name.toLowerCase();
//       if (suggestions.length == 5) {
//         print("I am breaking out of category search loop");
//         break;
//       }
//       for (final subWord in categoryName.split(" ")) {
//         print("looping in category");
//         if (subWord.startsWith(text)) {
//           suggestions.add(category);
//           break;
//         }
//       }
//     }
//     return suggestions;
//   }
// }

// class Suggestion {
//   final String name;
//   Suggestion({
//     required this.name,
//   });
// }

// class Product extends Suggestion {
//   Product({
//     required String name,
//   }) : super(name: name);
// }

// class Category extends Suggestion {
//   Category({
//     required String name,
//   }) : super(name: name);
// }

//Set custom fade in and fade out animation to the flutter snackbar?

import 'package:flutter/material.dart';

class MyWidget extends StatefulWidget {
  const MyWidget({super.key});

  @override
  State<MyWidget> createState() => _MyWidgetState();
}

class _MyWidgetState extends State<MyWidget> {
  bool? isChecked = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
            child: Center(
                child: Container(
      padding: EdgeInsets.zero,
      decoration: BoxDecoration(
        color: Colors.grey[300],
        // borderRadius: BorderRadius.circular(10),
      ),
      child: Checkbox(
        value: isChecked,
        onChanged: (bool? value) {
          setState(() {
            isChecked = value;
          });
        },
        activeColor: Colors.blue,
        checkColor: Colors.white,
        tristate: false,
        materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
      ),
    ))));
  }
}
