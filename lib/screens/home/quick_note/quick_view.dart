import 'package:asking/constants/color_constants.dart';
import 'package:asking/models/ModelProvider.dart';
import 'package:asking/repositories/data_repository.dart';
import 'package:asking/screens/home/quick_note/quick_cubit.dart';
import 'package:asking/screens/home/quick_note/quick_state.dart';
import 'package:asking/session/session_cubit.dart';
import 'package:asking/widgets/loading_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class QuickView extends StatefulWidget {
  const QuickView({Key? key}) : super(key: key);

  @override
  _QuickViewState createState() => _QuickViewState();
}

class _QuickViewState extends State<QuickView> {
  @override
  Widget build(BuildContext context) {
    final sessionCubit = context.read<SessionCubit>();
    return BlocProvider(
      create: (context) => QuickCubit(
          dataRepo: context.read<DataRepository>(),
          user: sessionCubit.selectedUser ??
              sessionCubit.currentUser ??
              User(username: 'N/A'))
        ..getQuickNotes()
        ..observeTodo(),
      child: BlocBuilder<QuickCubit, QuickState>(builder: (context, state) {
        if (state is GetQuickNoteSuccess) {
          return state.quickNotes.isEmpty
              ? _emptyQuickNoteView()
              : _quickNoteView(state.quickNotes);
        } else if (state is GetQuickNoteFailed) {}
        return LoadingView();
      }),
    );
  }

  Widget _emptyQuickNoteView() {
    return Center(child: Text('No Quick Note Yet'));
  }

  Widget _quickNoteView(List<QuickNote> quickNotes) {
    return Scaffold(
        backgroundColor: Color(0xFFFDFDFD),
        body: Padding(
          padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
          child: ListView.builder(
              itemCount: quickNotes.length,
              itemBuilder: (context, index) {
                final quickNote = quickNotes[index];
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
                            width: 100.w,
                            height: 30.h,
                            decoration: BoxDecoration(
                                border: Border(
                                    top: BorderSide(
                              color: ColorConstants.kButtonColor,
                              width: 2.0.w,
                            ))),
                          ),
                          Text(
                            quickNote.description,
                            style: TextStyle(
                                fontSize: 20.sp, fontWeight: FontWeight.w500),
                          ),
                          SizedBox(height: 30.h),
                        ]),
                  )),
                );
              }),
        ));
  }
}
