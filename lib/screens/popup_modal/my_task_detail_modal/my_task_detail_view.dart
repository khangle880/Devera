import 'package:asking/constants/asset_constants.dart';
import 'package:asking/constants/extension_function.dart';
import 'package:asking/image_url_cache.dart';
import 'package:asking/screens/popup_modal/my_task_detail_modal/my_task_detail_bloc.dart';
import 'package:asking/screens/popup_modal/my_task_detail_modal/my_task_detail_event.dart';
import 'package:asking/screens/popup_modal/my_task_detail_modal/my_task_detail_state.dart';
import 'package:asking/widgets/custom_row_builder.dart';
import 'package:asking/widgets/custom_text_button.dart';
import 'package:asking/widgets/loading_view.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:asking/models/Task.dart';
import 'package:intl/intl.dart';

class MyTaskDetailModalView extends StatefulWidget {
  const MyTaskDetailModalView({
    Key? key,
    required this.task,
  }) : super(key: key);

  final Task task;

  @override
  _MyTaskDetailModalViewState createState() => _MyTaskDetailModalViewState();
}

class _MyTaskDetailModalViewState extends State<MyTaskDetailModalView> {
  bool _showComment = false;
  FocusNode descriptionNode = FocusNode();
  TextEditingController myTextController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    print(widget.task.userID);
    return BlocProvider(
      create: (context) => MyTaskDetailBloc(task: widget.task)
        ..add(GetAssigneeInfo(userID: widget.task.userID ?? ''))
        ..add(GetMembersAvatarPath(membersID: widget.task.members ?? []))
        ..add(GetComments())
        ..add(ObserveComments()),
      child: BlocListener<MyTaskDetailBloc, MyTaskDetailState>(
        listener: (context, state) {},
        child: BlocBuilder<MyTaskDetailBloc, MyTaskDetailState>(
          builder: (context, state) {
            final DateFormat format = DateFormat('MMM dd, yyyy');
            final String formatted =
                format.format(widget.task.dueDate!.getDateTime());

            return Dialog(
                insetAnimationDuration: Duration(milliseconds: 0),
                // contentPadding: EdgeInsets.zero,
                insetPadding: EdgeInsets.only(
                    top: 40.h, bottom: 10.h, left: 0.w, right: 0.w),
                child: Container(
                  width: 350.w,
                  padding:
                      EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h),
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 10.w),
                    child: ListView(children: [
                      Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            GestureDetector(
                              onTap: () {
                                Navigator.of(context).pop();
                              },
                              child: Icon(
                                Icons.close_outlined,
                              ),
                            ),
                            Icon(
                              Icons.settings_outlined,
                            ),
                          ]),
                      SizedBox(height: 10.h),
                      Text(widget.task.description,
                          style: GoogleFonts.poppins(
                              textStyle: TextStyle(
                            fontSize: 30.sp,
                            fontWeight: FontWeight.w700,
                          ))),
                      ListTile(
                        contentPadding: EdgeInsets.zero,
                        leading: Container(
                            decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: Colors.transparent),
                            width: 50.w,
                            height: 70.h,
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(64.r),
                              child: CachedNetworkImage(
                                imageUrl: state.assigneeAvatarPath ??
                                    ImageConstants.defaultAvatar,
                                fit: BoxFit.fill,
                              ),
                            )),
                        title: Text('Assigned to',
                            style: GoogleFonts.poppins(
                                textStyle: TextStyle(
                                    fontSize: 14.sp,
                                    fontWeight: FontWeight.w500,
                                    color: Colors.grey.withOpacity(0.7)))),
                        subtitle: Text(state.assignee?.username ?? 'N/A',
                            style: GoogleFonts.poppins(
                                textStyle: TextStyle(
                                    fontSize: 18.sp,
                                    fontWeight: FontWeight.w500,
                                    color: Colors.black))),
                      ),
                      Divider(
                        thickness: 2,
                      ),
                      ListTile(
                        contentPadding: EdgeInsets.zero,
                        leading: SvgPicture.asset(
                          IconConstants.calendarIcon,
                          color: Colors.black,
                        ),
                        title: Text('Due date',
                            style: GoogleFonts.poppins(
                                textStyle: TextStyle(
                                    fontSize: 14.sp,
                                    fontWeight: FontWeight.w500,
                                    color: Colors.grey.withOpacity(0.7)))),
                        subtitle: Text(formatted,
                            style: GoogleFonts.poppins(
                                textStyle: TextStyle(
                                    fontSize: 18.sp,
                                    fontWeight: FontWeight.w500,
                                    color: Colors.black))),
                      ),
                      Divider(
                        thickness: 2,
                      ),
                      ListTile(
                        contentPadding: EdgeInsets.zero,
                        leading: SvgPicture.asset(
                          IconConstants.descriptionIcon,
                          color: Colors.black,
                        ),
                        title: Text('Description',
                            style: GoogleFonts.poppins(
                                textStyle: TextStyle(
                                    fontSize: 14.sp,
                                    fontWeight: FontWeight.w500,
                                    color: Colors.grey.withOpacity(0.7)))),
                        subtitle: Text(widget.task.description,
                            style: GoogleFonts.poppins(
                                textStyle: TextStyle(
                                    fontSize: 18.sp,
                                    fontWeight: FontWeight.w500,
                                    color: Colors.black))),
                      ),
                      Divider(
                        thickness: 2,
                      ),
                      if (state.members != null) ...[
                        ListTile(
                          contentPadding: EdgeInsets.zero,
                          leading: SvgPicture.asset(
                            IconConstants.membersIcon,
                            color: Colors.black,
                          ),
                          title: Text('Members',
                              style: GoogleFonts.poppins(
                                  textStyle: TextStyle(
                                      fontSize: 14.sp,
                                      fontWeight: FontWeight.w500,
                                      color: Colors.grey.withOpacity(0.7)))),
                          subtitle: FutureBuilder(
                              future: ExtensionFunction.getUsersAvatarUrl(
                                  state.members),
                              builder: (BuildContext context,
                                  AsyncSnapshot<List<String>>? usersAvatarUrl) {
                                return Container(
                                    margin: EdgeInsets.only(top: 10.h),
                                    height: 40.h,
                                    child: CustomRowBuilder(
                                        itemCount: state.members!.length,
                                        itemBuilder: (context, index) {
                                          if (!usersAvatarUrl!.hasData) {
                                            return Container(
                                                width: 40,
                                                height: 40,
                                                child: LoadingView());
                                          }

                                          if (usersAvatarUrl.data!.length !=
                                              0) {
                                            return Container(
                                                margin: EdgeInsets.only(
                                                    right: 10.w),
                                                decoration: BoxDecoration(
                                                    shape: BoxShape.circle,
                                                    color: Colors.transparent),
                                                width: 40.w,
                                                height: 40.h,
                                                child: ClipRRect(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          40.r),
                                                  child: CachedNetworkImage(
                                                    imageUrl: usersAvatarUrl
                                                            .data?[index] ??
                                                        ImageConstants
                                                            .defaultAvatar,
                                                    fit: BoxFit.fill,
                                                  ),
                                                ));
                                          }

                                          return Container(
                                              child: Center(
                                                  child: Text(
                                                      'You are alone :<')));
                                        }));
                              }),
                        ),
                      ],
                      Divider(
                        thickness: 2,
                      ),
                      ListTile(
                        contentPadding: EdgeInsets.zero,
                        leading: SvgPicture.asset(
                          IconConstants.tagIcon,
                          color: Colors.black,
                        ),
                        title: Text('Tag',
                            style: GoogleFonts.poppins(
                                textStyle: TextStyle(
                                    fontSize: 14.sp,
                                    fontWeight: FontWeight.w500,
                                    color: Colors.grey.withOpacity(0.7)))),
                        subtitle: Padding(
                          padding: EdgeInsets.only(top: 10.h),
                          child: Row(
                            children: [
                              Container(
                                width: 100,
                                height: 40,
                                alignment: Alignment.center,
                                decoration: BoxDecoration(
                                    border: Border.all(
                                      color: Colors.grey.withOpacity(
                                          0.6), // red as border color
                                    ),
                                    borderRadius: BorderRadius.circular(5.r)),
                                child: Text('Personal',
                                    style: GoogleFonts.poppins(
                                        textStyle: TextStyle(
                                            fontSize: 18.sp,
                                            fontWeight: FontWeight.w500,
                                            color: Color(0xFF6074F9)))),
                              ),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(height: 15.h),
                      Container(
                          child: Column(children: <Widget>[
                        Container(
                          width: double.maxFinite,
                          height: 90.h,
                          decoration: BoxDecoration(
                              border: Border.all(color: Color(0xFFEAEAEA))),
                          child: TextFormField(
                            controller: myTextController,
                            focusNode: descriptionNode,
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
                              context
                                  .read<MyTaskDetailBloc>()
                                  .add(CommentOnChanged(comment: value));
                            },
                          ),
                        ),
                        Container(
                          width: double.maxFinite,
                          height: 40.h,
                          padding: EdgeInsets.symmetric(horizontal: 20.w),
                          decoration: BoxDecoration(
                              color: Color(0xFFF8F8F8),
                              border: Border.all(color: Color(0xFFEAEAEA))),
                          child: Row(
                            children: [
                              SvgPicture.asset(IconConstants.imageIcon),
                              SizedBox(width: 25.w),
                              SvgPicture.asset(IconConstants.markIcon),
                              Expanded(
                                child: Align(
                                    alignment: Alignment.centerRight,
                                    child: GestureDetector(
                                        onTap: () {
                                          context
                                              .read<MyTaskDetailBloc>()
                                              .add(CreateComment());
                                          myTextController.text = '';
                                          context.read<MyTaskDetailBloc>().add(
                                              CommentOnChanged(comment: ''));
                                        },
                                        child: Text('Send',
                                            style: TextStyle(
                                                color: Color(0xFF6074F9),
                                                fontSize: 16.sp)))),
                              )
                            ],
                          ),
                        ),
                      ])),
                      SizedBox(height: 20.h),
                      Visibility(
                        visible: _showComment,
                        child: Container(
                          height: 450.h,
                          child: ListView.builder(
                              itemCount: state.comments.length,
                              itemBuilder: (context, index) {
                                return FutureBuilder(
                                    future: ImageUrlCache.instance.getUrl(
                                        state.comments[index].avatarKey ?? ''),
                                    builder: (context,
                                        AsyncSnapshot<String?>? snapshot) {
                                      if (!snapshot!.hasData) {
                                        return Container(
                                            width: 40,
                                            height: 40,
                                            color: Colors.white);
                                      }
                                      if (state.comments[index].createdAt !=
                                          null) {
                                        return Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            ListTile(
                                              contentPadding: EdgeInsets.zero,
                                              leading: Container(
                                                  decoration: BoxDecoration(
                                                      shape: BoxShape.circle,
                                                      color:
                                                          Colors.transparent),
                                                  width: 40.w,
                                                  height: 40.h,
                                                  child: ClipRRect(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            40.r),
                                                    child: CachedNetworkImage(
                                                      imageUrl: snapshot.data ??
                                                          ImageConstants
                                                              .defaultAvatar,
                                                      fit: BoxFit.fill,
                                                    ),
                                                  )),
                                              title: Text(
                                                  state.comments[index]
                                                          .username ??
                                                      'N/A',
                                                  style: GoogleFonts.poppins(
                                                      textStyle: TextStyle(
                                                    fontSize: 14.sp,
                                                    fontWeight: FontWeight.w500,
                                                  ))),
                                              subtitle: Text(
                                                  ExtensionFunction
                                                      .displayTimeAgoFromDateTime(
                                                          state.comments[index]
                                                              .createdAt!
                                                              .getDateTimeInUtc()),
                                                  style: GoogleFonts.poppins(
                                                      textStyle: TextStyle(
                                                    fontSize: 12.sp,
                                                    fontWeight: FontWeight.w500,
                                                  ))),
                                            ),
                                            SizedBox(height: 10.h),
                                            Text(
                                                state.comments[index].comment ??
                                                    'N/A',
                                                style: TextStyle(
                                                  fontSize: 16.sp,
                                                )),
                                            SizedBox(height: 20.h),
                                          ],
                                        );
                                      }

                                      return Container(color: Colors.white);
                                    });
                              }),
                        ),
                      ),
                      SizedBox(height: 20.h),
                      CustomTextButton(
                          margin: EdgeInsets.symmetric(horizontal: 20.w),
                          text: 'Complete Text',
                          color: Color(0xFF6074F9),
                          textColor: Colors.white,
                          onPressed: () {
                            Navigator.of(context).pop();
                          }),
                      SizedBox(height: 15.h),
                      Visibility(
                        visible: !_showComment,
                        child: Container(
                          width: double.maxFinite,
                          child: Row(
                            children: [
                              Expanded(
                                child: CustomTextButton(
                                    margin:
                                        EdgeInsets.symmetric(horizontal: 20.w),
                                    text: 'Comment',
                                    color: Colors.transparent,
                                    textColor: Colors.black,
                                    onPressed: () {
                                      setState(() {
                                        _showComment = true;
                                      });
                                    }),
                              ),
                              SvgPicture.asset(IconConstants.downArrowIcon)
                            ],
                          ),
                        ),
                      ),
                    ]),
                  ),
                ));
          },
        ),
      ),
    );
  }
}
