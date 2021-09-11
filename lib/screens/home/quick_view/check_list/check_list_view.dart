import 'package:asking/constants/color_constants.dart';
import 'package:asking/constants/extension_function.dart';
import 'package:asking/models/ModelProvider.dart';
import 'package:asking/screens/home/quick_view/check_list/components/list_item_builder.dart';
import 'package:asking/screens/home/quick_view/quick_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CheckListView extends StatefulWidget {
  const CheckListView({Key? key}) : super(key: key);

  @override
  _CheckListViewState createState() => _CheckListViewState();
}

class _CheckListViewState extends State<CheckListView> {
  bool _wantToEdit = false;

  @override
  Widget build(BuildContext context) {
    final QuickCubit quickCubit = context.read<QuickCubit>();
    final Map<CheckList, List<ListItem>> checkLists = quickCubit.mapCheckLists;

    return Scaffold(
      floatingActionButton: GestureDetector(
          onTap: () {
            setState(() {
              _wantToEdit = _wantToEdit ? false : true;
            });
          },
          child: Container(
              width: 50.w,
              height: 50.h,
              margin: EdgeInsets.only(bottom: 40.h),
              alignment: Alignment.center,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20.r),
                  gradient: ColorConstants.kPrimaryGradientColor),
              child: Icon(Icons.edit, color: Colors.white))),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      body: ListView.builder(
          itemCount: checkLists.length,
          itemBuilder: (context, index) {
            // print(quickCubit.mapCheckLists.values);
            final CheckList checkList = checkLists.keys.elementAt(index);
            final List<ListItem> listItems = checkLists.values.elementAt(index);
            return Container(
              margin: EdgeInsets.only(bottom: 20.h),
              child: Card(
                  child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Container(
                        width: 140.w,
                        height: 30.h,
                        decoration: BoxDecoration(
                            border: Border(
                                top: BorderSide(
                          color: ExtensionFunction.hexToColor(checkList.color),
                          width: 2.0.w,
                        ))),
                      ),
                      Row(
                        children: [
                          Container(
                            width: 200,
                            child: TextFormField(
                              initialValue: checkList.description ?? '',
                              style: TextStyle(
                                  fontSize: 20.sp, fontWeight: FontWeight.bold),
                              readOnly: _wantToEdit ? false : true,
                              decoration: InputDecoration(
                                border: InputBorder.none,
                                hintText: 'Enter something',
                              ),
                              onFieldSubmitted: (description) {
                                final updatedCheckList = checkList.copyWith(
                                    description: description);
                                quickCubit.updateCheckList(updatedCheckList);
                              },
                            ),
                          ),
                          Expanded(
                            child: Visibility(
                              visible: _wantToEdit,
                              child: Align(
                                  alignment: Alignment.centerRight,
                                  child: GestureDetector(
                                      onTap: () {
                                        // print(checkList);
                                        context
                                            .read<QuickCubit>()
                                            .deleteCheckList(checkList);
                                      },
                                      child: Icon(Icons.delete_outlined,
                                          size: 22.sp))),
                            ),
                          )
                        ],
                      ),
                      SizedBox(height: 10.h),
                      listItemBuilder(listItems),
                      SizedBox(height: 30.h),
                    ]),
              )),
            );
          }),
    );
  }

  Widget listItemBuilder(List<ListItem> listItems) {
    return ListItemBuilder(listItems: listItems, wantToEdit: _wantToEdit);
  }
}
