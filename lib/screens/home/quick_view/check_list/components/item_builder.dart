import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:asking/constants/asset_constants.dart';
import 'package:asking/models/ListItem.dart';
import 'package:asking/screens/home/quick_view/quick_cubit.dart';
import 'package:asking/screens/home/quick_view/quick_state.dart';

class ItemBuilder extends StatefulWidget {
  const ItemBuilder({
    Key? key,
    required this.listItem,
    required this.wantToEdit,
  }) : super(key: key);

  final ListItem listItem;
  final bool wantToEdit;

  @override
  _ItemBuilderState createState() => _ItemBuilderState();
}

class _ItemBuilderState extends State<ItemBuilder> {
  @override
  Widget build(BuildContext context) {
    ListItem _listItem = widget.listItem;

    return BlocBuilder<QuickCubit, QuickState>(
      builder: (context, state) {
        return Container(
          width: double.maxFinite,
          margin: EdgeInsets.symmetric(vertical: 5.h),
          child: Row(
            children: <Widget>[
              GestureDetector(
                onTap: () {
                  _listItem = _listItem.copyWith(
                      isComplete: _listItem.isComplete ? false : true);

                  context.read<QuickCubit>().updateListItem(_listItem);
                },
                child: SvgPicture.asset(
                  _listItem.isComplete
                      ? IconConstants.checkedRectangleIcon
                      : IconConstants.unCheckRectangleIcon,
                  width: 22.w,
                  height: 22.h,
                ),
              ),
              SizedBox(
                width: 20.w,
              ),
              Expanded(
                flex: 3,
                child: TextFormField(
                  key: Key(_listItem.description),
                  initialValue: _listItem.description,
                  style: TextStyle(
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w500,
                      color: Colors.black),
                  readOnly: widget.wantToEdit ? false : true,
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    hintText: 'Enter something',
                  ),
                  onFieldSubmitted: (description) {
                    final updatedListItem =
                        _listItem.copyWith(description: description);
                    context.read<QuickCubit>().updateListItem(updatedListItem);
                  },
                ),
              ),
              Expanded(
                child: Visibility(
                  visible: widget.wantToEdit,
                  child: Align(
                      alignment: Alignment.centerRight,
                      child: GestureDetector(
                          onTap: () {
                            context
                                .read<QuickCubit>()
                                .deleteListItem(_listItem);
                          },
                          child: Icon(Icons.delete_outlined, size: 22.sp))),
                ),
              )
            ],
          ),
        );
      },
    );
  }
}
