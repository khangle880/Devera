import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:laptop/constants.dart';
import 'package:laptop/widgets/laptop_option.dart';

class SelectLaptopOption extends StatefulWidget {
  const SelectLaptopOption({
    Key? key,
    required this.snapshotData,
  }) : super(key: key);

  final AsyncSnapshot<QuerySnapshot<Object?>> snapshotData;
  @override
  _SelectLaptopOptionState createState() => _SelectLaptopOptionState();
}

class _SelectLaptopOptionState extends State<SelectLaptopOption>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  int tabIndex = 0;

  @override
  void initState() {
    _tabController = TabController(
        length: widget.snapshotData.data!.docs.length, vsync: this);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          TabBar(
              onTap: (int pageIndex) {
                setState(() {
                  tabIndex = pageIndex;
                });
              },
              controller: _tabController,
              indicatorColor: Colors.transparent,
              labelColor: hexToColor('#C88D67'),
              isScrollable: true,
              labelPadding: const EdgeInsets.only(left: 2.0),
              unselectedLabelColor: Colors.black,
              tabs: widget.snapshotData.data!.docs
                  .map((QueryDocumentSnapshot<Object?> document) {
                // print(document.data());
                return Tab(
                  child: Container(
                      width: 100.0,
                      height: 40.0,
                      decoration: BoxDecoration(
                          color: hexToColor('#B6C9F0'),
                          borderRadius: BorderRadius.circular(8.0)),
                      alignment: Alignment.center,
                      margin: const EdgeInsets.symmetric(horizontal: 8.0),
                      child: Text("\$ ${document.get('price')}",
                          style: const TextStyle(
                              fontWeight: FontWeight.w600, fontSize: 18.0))),
                );
              }).toList()),
          Padding(
            padding: const EdgeInsets.only(left: 10.0, top: 15.0),
            child: SizedBox(
              height: 200,
              child: IndexedStack(
                index: tabIndex,
                children: widget.snapshotData.data!.docs
                    .map((QueryDocumentSnapshot<Object?> document) {
                  return LaptopOption(laptopDocument: document);
                }).toList(),
              ),
            ),
          )
        ]);
  }
}
