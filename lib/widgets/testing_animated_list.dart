// import 'package:flutter/foundation.dart';
// import 'package:flutter/material.dart';

// void main() {
//   runApp(const AnimatedListSample());
// }

// class AnimatedListSample extends StatefulWidget {
//   const AnimatedListSample({Key? key}) : super(key: key);

//   @override
//   State<AnimatedListSample> createState() => _AnimatedListSampleState();
// }

// class _AnimatedListSampleState extends State<AnimatedListSample> {
//   final GlobalKey<AnimatedListState> _listKey = GlobalKey<AnimatedListState>();
//   late ListModel<int> _list;
//   int? _selectedItem;
//   late int
//       _nextItem; // The next item inserted when the user presses the '+' button.

//   @override
//   void initState() {
//     super.initState();
//     _list = ListModel<int>(
//       listKey: _listKey,
//       initialItems: <int>[0, 1, 2],
//       removedItemBuilder: _buildRemovedItem,
//     );
//     _nextItem = 3;
//   }

//   // Used to build list items that haven't been removed.
//   Widget _buildItem(
//       BuildContext context, int index, Animation<double> animation) {
//     return CardItem(
//       animation: animation,
//       item: _list[index],
//       selected: _selectedItem == _list[index],
//       onTap: () {
//         setState(() {
//           _selectedItem = _selectedItem == _list[index] ? null : _list[index];
//         });
//       },
//     );
//   }

//   // Used to build an item after it has been removed from the list. This
//   // method is needed because a removed item remains visible until its
//   // animation has completed (even though it's gone as far this ListModel is
//   // concerned). The widget will be used by the
//   // [AnimatedListState.removeItem] method's
//   // [AnimatedListRemovedItemBuilder] parameter.
//   Widget _buildRemovedItem(
//       int item, BuildContext context, Animation<double> animation) {
//     return CardItem(
//       animation: animation,
//       item: item,
//       selected: false,
//       // No gesture detector here: we don't want removed items to be interactive.
//     );
//   }

//   // Insert the "next item" into the list model.
//   void _insert() {
//     final int index =
//         _selectedItem == null ? _list.length : _list.indexOf(_selectedItem!);
//     _list.insert(index, _nextItem++);
//   }

//   // Remove the selected item from the list model.
//   void _remove() {
//     if (_selectedItem != null) {
//       _list.removeAt(_list.indexOf(_selectedItem!));
//       setState(() {
//         _selectedItem = null;
//       });
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       home: Scaffold(
//         appBar: AppBar(
//           title: const Text('AnimatedList'),
//           actions: <Widget>[
//             IconButton(
//               icon: const Icon(Icons.add_circle),
//               onPressed: _insert,
//               tooltip: 'insert a new item',
//             ),
//             IconButton(
//               icon: const Icon(Icons.remove_circle),
//               onPressed: _remove,
//               tooltip: 'remove the selected item',
//             ),
//           ],
//         ),
//         body: Padding(
//           padding: const EdgeInsets.all(16.0),
//           child: AnimatedList(
//             key: _listKey,
//             initialItemCount: _list.length,
//             itemBuilder: _buildItem,
//           ),
//         ),
//       ),
//     );
//   }
// }

// /// Displays its integer item as 'item N' on a Card whose color is based on
// /// the item's value.
// ///
// /// The text is displayed in bright green if [selected] is
// /// true. This widget's height is based on the [animation] parameter, it
// /// varies from 0 to 128 as the animation varies from 0.0 to 1.0.
// class CardItem extends StatelessWidget {
//   const CardItem({
//     Key? key,
//     this.onTap,
//     this.selected = false,
//     required this.animation,
//     required this.item,
//   })  : assert(item >= 0),
//         super(key: key);

//   final Animation<double> animation;
//   final VoidCallback? onTap;
//   final int item;
//   final bool selected;

//   @override
//   Widget build(BuildContext context) {
//     TextStyle textStyle = Theme.of(context).textTheme.headline4!;
//     if (selected) {
//       textStyle = textStyle.copyWith(color: Colors.lightGreenAccent[400]);
//     }
//     return Padding(
//       padding: const EdgeInsets.all(2.0),
//       child: SizeTransition(
//         axis: Axis.vertical,
//         sizeFactor: animation,
//         child: GestureDetector(
//           behavior: HitTestBehavior.opaque,
//           onTap: onTap,
//           child: SizedBox(
//             height: 80.0,
//             child: Card(
//               color: Colors.primaries[item % Colors.primaries.length],
//               child: Center(
//                 child: Text('Item $item', style: textStyle),
//               ),
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }

// //********************************************************************
