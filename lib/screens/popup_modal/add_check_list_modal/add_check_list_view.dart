import 'package:asking/constants/color_constants.dart';
import 'package:asking/constants/extension_function.dart';
import 'package:asking/constants/form_submission_status.dart';
import 'package:asking/models/ListItem.dart';
import 'package:asking/screens/popup_modal/add_check_list_modal/add_check_list_bloc.dart';
import 'package:asking/screens/popup_modal/add_check_list_modal/components/create_check_list_button.dart';
import 'package:asking/screens/popup_modal/add_check_list_modal/components/note_text_field.dart';
import 'package:asking/types/list_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class AddCheckListView extends StatefulWidget {
  const AddCheckListView({Key? key}) : super(key: key);

  @override
  _AddCheckListViewState createState() => _AddCheckListViewState();
}

class _AddCheckListViewState extends State<AddCheckListView> {
  final GlobalKey<AnimatedListState> _listKey = GlobalKey<AnimatedListState>();
  Color _colorPicked = Color(0xFF6074F9);
  late ListModel<ListItem> _listItem;

  @override
  void initState() {
    super.initState();
    _listItem = ListModel<ListItem>(
      listKey: _listKey,
      removedItemBuilder: _buildRemovedItem,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      insetAnimationDuration: Duration(milliseconds: 0),
      insetPadding: EdgeInsets.only(
          top: 60.h,
          bottom: _listItem.length > 2 ? 50.h : 150.h,
          left: 0.w,
          right: 0.w),
      child: Container(
        width: 350.w,
        padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h),
        child: BlocProvider(
          create: (context) => AddCheckListBloc(),
          child: BlocListener<AddCheckListBloc, AddCheckListState>(
            listener: (context, state) {
              _colorPicked = ExtensionFunction.hexToColor(state.color);
              final formStatus = state.formStatus;
              if (formStatus is SubmissionFailed) {
                ExtensionFunction.showSnackBar(
                    context, formStatus.exception.toString());
              }
            },
            child: BlocBuilder<AddCheckListBloc, AddCheckListState>(
              builder: (context, state) {
                return ListView(children: [
                  Text('Title',
                      style: GoogleFonts.poppins(
                          textStyle: TextStyle(
                              fontSize: 20.sp,
                              fontWeight: FontWeight.w700,
                              color: ColorConstants.kTextColor))),
                  SizedBox(height: 5.h),
                  _noteTextField(),
                  AnimatedContainer(
                    duration: Duration(milliseconds: 500),
                    height: _listItem.length > 2 ? 220.h : 100.h,
                    child: AnimatedList(
                      key: _listKey,
                      initialItemCount: _listItem.length,
                      itemBuilder: _buildItem,
                    ),
                  ),
                  SizedBox(height: 15.h),
                  GestureDetector(
                    onTap: () {
                      _insert(context);
                    },
                    child: Text(
                      '+ Add new item',
                      style: TextStyle(
                          fontSize: 18.sp, fontWeight: FontWeight.bold),
                    ),
                  ),
                  SizedBox(height: 20.h),
                  Text('Choose Color',
                      style: GoogleFonts.poppins(
                          textStyle: TextStyle(
                              fontSize: 30.sp,
                              fontWeight: FontWeight.w700,
                              color: _colorPicked))),
                  SizedBox(height: 10.h),
                  _colorsPicker(),
                  SizedBox(height: 30.h),
                  _createCheckListButton()
                ]);
              },
            ),
          ),
        ),
      ),
    );
  }

  Widget _noteTextField() {
    return NoteTextField();
  }

  Widget _createCheckListButton() {
    return CreateCheckListButton();
  }

  Widget _colorsPicker() {
    return BlocBuilder<AddCheckListBloc, AddCheckListState>(
      builder: (context, state) {
        return Row(mainAxisAlignment: MainAxisAlignment.start, children: [
          SizedBox(width: 10.w),
          GestureDetector(
            onTap: () {
              _colorPicked = Color(0xFF6074F9);
              context
                  .read<AddCheckListBloc>()
                  .add(CheckListColorOnChanged(color: '#6074F9'));
            },
            child: Container(
              width: 48.w,
              height: 48.w,
              decoration: BoxDecoration(
                  color: Color(0xFF6074F9),
                  borderRadius: BorderRadius.circular(5.0.r)),
            ),
          ),
          SizedBox(width: 12.w),
          GestureDetector(
            onTap: () {
              _colorPicked = Color(0xFFE42B6A);
              context
                  .read<AddCheckListBloc>()
                  .add(CheckListColorOnChanged(color: '#E42B6A'));
            },
            child: Container(
              width: 48.w,
              height: 48.w,
              decoration: BoxDecoration(
                  color: Color(0xFFE42B6A),
                  borderRadius: BorderRadius.circular(5.0.r)),
            ),
          ),
          SizedBox(width: 12.w),
          GestureDetector(
            onTap: () {
              // _colorPicked = Color(0xFF5ABB56);
              context
                  .read<AddCheckListBloc>()
                  .add(CheckListColorOnChanged(color: '#5ABB56'));
            },
            child: Container(
              width: 48.w,
              height: 48.w,
              decoration: BoxDecoration(
                  color: Color(0xFF5ABB56),
                  borderRadius: BorderRadius.circular(5.0.r)),
            ),
          ),
          SizedBox(width: 12.w),
          GestureDetector(
            onTap: () {
              // _colorPicked = Color(0xFF3D3A62);
              context
                  .read<AddCheckListBloc>()
                  .add(CheckListColorOnChanged(color: '#3D3A62'));
            },
            child: Container(
              width: 48.w,
              height: 48.w,
              decoration: BoxDecoration(
                  color: Color(0xFF3D3A62),
                  borderRadius: BorderRadius.circular(5.0.r)),
            ),
          ),
          SizedBox(width: 12.w),
          GestureDetector(
            onTap: () {
              setState(() {
                // _colorPicked = Color(0xFFF4CA8F);
                context
                    .read<AddCheckListBloc>()
                    .add(CheckListColorOnChanged(color: '#F4CA8F'));
              });
            },
            child: Container(
              width: 48.w,
              height: 48.w,
              decoration: BoxDecoration(
                  color: Color(0xFFF4CA8F),
                  borderRadius: BorderRadius.circular(5.0.r)),
            ),
          ),
        ]);
      },
    );
  }

  Widget _buildItem(
      BuildContext context, int index, Animation<double> animation) {
    return SizeTransition(
        key: UniqueKey(),
        axis: Axis.vertical,
        sizeFactor: animation,
        child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                width: 25.w,
                height: 25.h,
                decoration: BoxDecoration(
                  color: ColorConstants.kGreyBackground,
                  border: Border.all(color: Colors.black, width: 2.0.w),
                  borderRadius: BorderRadius.circular(5.r),
                ),
              ),
              SizedBox(width: 20.w),
              Expanded(
                  child: TextFormField(
                initialValue: _listItem[index].description,
                onChanged: (value) {
                  _listItem[index] =
                      _listItem[index].copyWith(description: value);
                },
                decoration: InputDecoration(
                  border: InputBorder.none,
                  hintText: 'Enter something',
                  contentPadding: const EdgeInsets.symmetric(vertical: 18.0),
                ),
              )),
              Expanded(
                  child: Align(
                alignment: Alignment.centerRight,
                child: GestureDetector(
                  onTap: () {
                    _remove(context, index);
                  },
                  child: Icon(
                    Icons.delete_outlined,
                  ),
                ),
              )),
            ]));
  }

  Widget _buildRemovedItem(
      ListItem item, BuildContext context, Animation<double> animation) {
    return SizeTransition(
        key: UniqueKey(),
        sizeFactor: animation,
        child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                width: 25.w,
                height: 25.h,
                decoration: BoxDecoration(
                  color: ColorConstants.kGreyBackground,
                  border: Border.all(color: Colors.black, width: 2.0.w),
                  borderRadius: BorderRadius.circular(5.r),
                ),
              ),
              SizedBox(width: 20.w),
              Expanded(
                  child: TextFormField(
                decoration: InputDecoration(
                  border: InputBorder.none,
                  hintText: 'Enter something',
                  contentPadding: const EdgeInsets.symmetric(vertical: 18.0),
                ),
              )),
              Expanded(
                  child: Align(
                alignment: Alignment.centerRight,
                child: Icon(
                  Icons.delete_outlined,
                ),
              )),
            ]));
  }

  void _insert(BuildContext context) {
    setState(() {
      _listItem.insert(
          _listItem.length, ListItem(description: '', isComplete: false));
    });
    context
        .read<AddCheckListBloc>()
        .add(CheckListItemsOnChanged(listItems: _listItem.getData()));
  }

  void _remove(BuildContext context, int index) {
    setState(() {
      _listItem.removeAt(index);
    });
    context
        .read<AddCheckListBloc>()
        .add(CheckListItemsOnChanged(listItems: _listItem.getData()));
  }
}
