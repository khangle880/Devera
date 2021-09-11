import 'package:asking/constants/asset_constants.dart';
import 'package:asking/constants/color_constants.dart';
import 'package:asking/models/ModelProvider.dart';
import 'package:asking/screens/popup_modal/add_task_modal/add_task_bloc.dart';
import 'package:asking/screens/popup_modal/add_task_modal/add_task_event.dart';
import 'package:asking/screens/popup_modal/add_task_modal/add_task_state.dart';
import 'package:asking/widgets/custom_row_builder.dart';
import 'package:asking/widgets/custom_text_button.dart';
import 'package:asking/widgets/loading_view.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';
import 'package:asking/constants/extension_function.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AddTaskForm extends StatefulWidget {
  const AddTaskForm({Key? key}) : super(key: key);

  @override
  _AddTaskFormState createState() => _AddTaskFormState();
}

class _AddTaskFormState extends State<AddTaskForm> {
  DateTime _dateTime = DateTime.now();
  double _dateExpandContainerWidth = 80.w;
  FocusNode descriptionNode = FocusNode();

  late String _dateString;

  @override
  Widget build(BuildContext context) {
    return BlocListener<AddTaskBloc, AddTaskState>(
      listener: (context, state) {},
      child: BlocBuilder<AddTaskBloc, AddTaskState>(
        builder: (context, state) {
          if (state.dueDate!.isSameDate(DateTime.now())) {
            _dateExpandContainerWidth = 80.w;
            _dateString = 'Today';
          } else {
            final DateFormat format = DateFormat('dd - MMM');
            _dateExpandContainerWidth = 150.w;
            _dateString = format.format(state.dueDate!);
          }

          return Container(
            height: 568.h,
            decoration: BoxDecoration(
              color: Color(0xFFF4F4F4),
              borderRadius: BorderRadius.circular(12.r),
            ),
            child: ListView(children: [
              Padding(
                padding: EdgeInsets.only(left: 12.0.w, top: 12.0.h),
                child: Text('Title',
                    style: GoogleFonts.poppins(
                        textStyle: TextStyle(
                            fontSize: 20.sp,
                            fontWeight: FontWeight.w700,
                            color: ColorConstants.kTextColor))),
              ),
              SizedBox(height: 10.h),
              Container(
                  padding:
                      EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h),
                  width: double.maxFinite,
                  height: 220.h,
                  color: Colors.white,
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text('Description',
                            style:
                                TextStyle(color: Colors.grey.withOpacity(0.9))),
                        SizedBox(height: 10.h),
                        Container(
                            child: Column(children: <Widget>[
                          Container(
                            width: double.maxFinite,
                            height: 90.h,
                            decoration: BoxDecoration(
                                border: Border.all(color: Color(0xFFEAEAEA))),
                            child: TextFormField(
                              focusNode: descriptionNode,
                              initialValue: state.description,
                              keyboardType: TextInputType.multiline,
                              maxLines: 3,
                              decoration: InputDecoration(
                                border: InputBorder.none,
                                suffix: TextButton(
                                  onPressed: () {
                                    descriptionNode.unfocus();
                                  },
                                  child: Text("Done"),
                                ),
                                hintText: 'Enter something',
                                contentPadding: EdgeInsets.symmetric(
                                    vertical: 18.0.h, horizontal: 10.w),
                              ),
                              onChanged: (value) {
                                context.read<AddTaskBloc>().add(
                                    TaskDescriptionOnChanged(
                                        description: value));
                              },
                            ),
                          ),
                          Container(
                              width: double.maxFinite,
                              height: 50.h,
                              padding: EdgeInsets.only(left: 10.w),
                              alignment: Alignment.centerLeft,
                              decoration: BoxDecoration(
                                  color: Color(0xFFF8F8F8),
                                  border: Border.all(color: Color(0xFFEAEAEA))),
                              child: SvgPicture.asset(IconConstants.markIcon)),
                        ]))
                      ])),
              SizedBox(height: 5.h),
              SizedBox(
                height: 55.h,
                child: Row(children: [
                  SizedBox(width: 10.w),
                  Text('Due Date',
                      style: TextStyle(
                          fontSize: 18.sp, fontWeight: FontWeight.w400)),
                  SizedBox(width: 15.w),
                  AnimatedContainer(
                    duration: const Duration(seconds: 2),
                    curve: Curves.fastOutSlowIn,
                    height: 30.h,
                    width: _dateExpandContainerWidth,
                    child: CustomTextButton(
                        text: _dateString,
                        color: Color(0xFF6074F9),
                        textColor: Colors.white,
                        onPressed: () {
                          _showDatePicker(context);
                        }),
                  )
                ]),
              ),
              Container(
                  color: Color(0xFFFDFDFD),
                  height: 226.h,
                  padding: EdgeInsets.symmetric(horizontal: 20.w),
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        SizedBox(height: 10.h),
                        Text('Add Member',
                            style: TextStyle(
                                fontSize: 18.sp, fontWeight: FontWeight.w600)),
                        SizedBox(height: 10.h),
                        Container(
                          width: double.maxFinite,
                          height: 50.h,
                          child: ListView(
                            scrollDirection: Axis.horizontal,
                            children: [
                              CustomRowBuilder(
                                  itemCount: state.memberAvatarsUrl.length,
                                  itemBuilder: (context, index) {
                                    return Container(
                                      margin: EdgeInsets.only(right: 10.w),
                                      decoration: BoxDecoration(
                                          shape: BoxShape.circle,
                                          color: Colors.transparent),
                                      width: 50.w,
                                      height: 50.h,
                                      child: ClipRRect(
                                        borderRadius:
                                            BorderRadius.circular(40.r),
                                        child: CachedNetworkImage(
                                          imageUrl:
                                              state.memberAvatarsUrl[index],
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                    );
                                  }),
                              SizedBox(width: 5.w),
                              Container(
                                  width: 50.w,
                                  child: GestureDetector(
                                      onTap: () {
                                        _showUserPicker(context, state.users);
                                      },
                                      child:
                                          Icon(Icons.person_add_alt_outlined))),
                            ],
                          ),
                        ),
                        SizedBox(height: 20.h),
                        Container(
                          width: double.maxFinite,
                          child: CustomTextButton(
                              text: 'Add Task',
                              color: ColorConstants.kPrimaryDarkColor,
                              textColor: Colors.white,
                              onPressed: () {
                                context.read<AddTaskBloc>().add(CreateTask());
                                Navigator.of(context).pop();
                              }),
                        ),
                        SizedBox(height: 10.h),
                        Container(
                          width: double.maxFinite,
                          child: CustomTextButton(
                              text: 'Cancel',
                              color: Color(0xFFF4F4F4),
                              outLineButton: true,
                              textColor: Colors.black,
                              onPressed: () {
                                Navigator.of(context).pop();
                              }),
                        )
                      ])),
            ]),
          );
        },
      ),
    );
  }

  void _showUserPicker(BuildContext context, List<User>? users) {
    void _selectMemberAvatarUrl(memberAvatarUrl, memberID) {
      print('hello world');
      context.read<AddTaskBloc>()
        ..add(AddMemberAvartarUrl(memberAvatarUrl: memberAvatarUrl))
        ..add(AddMemberID(memberID: memberID));
    }

    showDialog(
      context: context,
      barrierColor: Colors.transparent,
      builder: (userPickerContext) {
        return Dialog(
            elevation: 0.0,
            insetPadding: EdgeInsets.only(
                top: 120.h, bottom: 220.h, left: 12.w, right: 12.w),
            child: Column(children: [
              Container(
                  width: double.maxFinite,
                  height: 30.h,
                  color: ColorConstants.kPrimaryDarkColor,
                  child: Center(
                      child: Text('Members',
                          style: TextStyle(
                              fontSize: 20.sp,
                              color: Colors.white,
                              fontWeight: FontWeight.bold)))),
              SizedBox(height: 10.h),
              FutureBuilder(
                  future: ExtensionFunction.getUsersAvatarUrl(users),
                  builder: (BuildContext context,
                      AsyncSnapshot<List<String>>? usersAvatarUrl) {
                    return Container(
                        height: 240.h,
                        child: GridView.builder(
                            gridDelegate:
                                SliverGridDelegateWithFixedCrossAxisCount(
                                    crossAxisCount: 3,
                                    crossAxisSpacing: 10.0,
                                    mainAxisSpacing: 5.0),
                            itemCount: users!.length,
                            itemBuilder: (context, index) {
                              if (!usersAvatarUrl!.hasData) {
                                return Container(
                                    width: 40,
                                    height: 40,
                                    child: LoadingView());
                              }
                              if (usersAvatarUrl.data!.length != 0) {
                                return GestureDetector(
                                  onTap: () => _selectMemberAvatarUrl(
                                      usersAvatarUrl.data![index],
                                      users[index].id),
                                  child: Container(
                                    decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        color: Colors.transparent),
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(30.r),
                                      child: CachedNetworkImage(
                                        imageUrl: usersAvatarUrl.data![index],
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                  ),
                                );
                              }

                              return Container(
                                  child: Center(child: Text('Empty')));
                            }));
                  }),
              SizedBox(height: 22.h),
              CustomTextButton(
                  text: 'Done',
                  color: ColorConstants.kPrimaryDarkColor,
                  textColor: Colors.white,
                  onPressed: () {
                    Navigator.of(context).pop();
                  })
            ]));
      },
    );
  }

  void _showDatePicker(BuildContext context) {
    Function(DateRangePickerSelectionChangedArgs) _onSelectionChanged =
        (dateTime) {
      setState(() {
        descriptionNode.unfocus();
        _dateTime = dateTime.value;
      });

      if (_dateTime.isSameDate(DateTime.now())) {
        setState(() {
          _dateExpandContainerWidth = 80.w;
        });
      } else {
        final DateFormat format = DateFormat('MMM - dd');

        _dateExpandContainerWidth = 150.w;
        _dateString = format.format(_dateTime);
      }

      context.read<AddTaskBloc>().add(TaskDueDateOnChanged(dueDate: _dateTime));
    };

    showDialog(
        context: context,
        builder: (context) {
          return Dialog(
              insetPadding: EdgeInsets.only(
                  top: 100.h, bottom: 180.h, left: 0.w, right: 0.w),
              child: Container(
                width: 350.w,
                child: Column(
                  children: [
                    SizedBox(height: 20.h),
                    SfDateRangePicker(
                      onSelectionChanged:
                          (DateRangePickerSelectionChangedArgs dateTime) {
                        _onSelectionChanged(dateTime);
                      },
                      initialSelectedDate: _dateTime,
                      selectionColor: Color(0xFF6074F9),
                      headerHeight: 50.h,
                      selectionMode: DateRangePickerSelectionMode.single,
                      headerStyle: DateRangePickerHeaderStyle(
                        textAlign: TextAlign.center,
                        textStyle: TextStyle(
                            color: Colors.black,
                            fontSize: 18,
                            fontWeight: FontWeight.w600),
                      ),
                      view: DateRangePickerView.month,
                      monthViewSettings: DateRangePickerMonthViewSettings(
                          viewHeaderStyle: DateRangePickerViewHeaderStyle(
                            textStyle: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.black),
                          ),
                          showTrailingAndLeadingDates: true),
                      monthCellStyle: DateRangePickerMonthCellStyle(
                        // textStyle: TextStyle(fontWeight: FontWeight.w300),
                        blackoutDateTextStyle: TextStyle(
                            color: Colors.white,
                            decoration: TextDecoration.lineThrough),
                        specialDatesTextStyle:
                            const TextStyle(color: Colors.white),
                      ),
                    ),
                    SizedBox(height: 30.h),
                    CustomTextButton(
                        margin: EdgeInsets.symmetric(horizontal: 60.w),
                        text: 'Done',
                        color: ColorConstants.kPrimaryDarkColor,
                        textColor: Colors.white,
                        onPressed: () {
                          Navigator.of(context).pop();
                        })
                  ],
                ),
              ));
        });
  }
}
