import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:icon/constants/asset_constants.dart';
import 'package:icon/constants/color_constants.dart';
import 'package:icon/repositories/auth_repository.dart';
import 'package:icon/screens/auth/auth_cubit.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:icon/screens/auth/components/keyboard_number.dart';
import 'package:icon/screens/auth/components/pin_number.dart';
import 'package:icon/screens/auth/create_pin/create_pin_bloc.dart';
import 'package:icon/screens/auth/create_pin/create_pin_event.dart';
import 'package:icon/screens/auth/create_pin/create_pin_state.dart';

class CreatePinView extends StatefulWidget {
  const CreatePinView({Key? key}) : super(key: key);

  @override
  _CreatePinViewState createState() => _CreatePinViewState();
}

class _CreatePinViewState extends State<CreatePinView> {
  List<String> currentPin = ['', '', '', ''];
  TextEditingController pinOneConntroller = TextEditingController();
  TextEditingController pinTwoConntroller = TextEditingController();
  TextEditingController pinThreeConntroller = TextEditingController();
  TextEditingController pinFourConntroller = TextEditingController();

  var outlineInputborder = OutlineInputBorder(
      borderRadius: BorderRadius.circular(10),
      borderSide: BorderSide(
        color: Colors.transparent,
      ));

  int pinIndex = 0;

  @override
  Widget build(BuildContext context) {
    final AuthCubit authCubit = context.read<AuthCubit>();
    return BlocProvider(
      create: (context) => CreatePinBloc(
          authRepo: context.read<AuthRepository>(), authCubit: authCubit),
      child: BlocBuilder<CreatePinBloc, CreatePinState>(
        builder: (context, state) {
          return Scaffold(
              appBar: AppBar(
                  elevation: 0.0,
                  backgroundColor: ColorConstants.kGreyBackground,
                  leading: IconButton(
                    icon: Icon(Icons.arrow_back, color: Colors.black),
                    onPressed: () {
                      authCubit.showSignUp();
                      Navigator.of(context).pop();
                    },
                  ),
                  title: Text('Create a PIN',
                      style: TextStyle(color: Colors.black))),
              backgroundColor: ColorConstants.kGreyBackground,
              body: SafeArea(
                child: Column(
                  children: [
                    Expanded(
                      child: Container(
                          alignment: Alignment(0, 0.5),
                          padding: EdgeInsets.symmetric(horizontal: 16.0),
                          child: Column(
                            children: [
                              SizedBox(height: 20.h),
                              _buildSecurityText(),
                              SizedBox(height: 120.0.h),
                              _buildPinRow()
                            ],
                          )),
                    ),
                    _buildNumberPad(context),
                  ],
                ),
              ));
        },
      ),
    );
  }

  Widget _buildNumberPad(BuildContext context) {
    return Expanded(
        child: Container(
            alignment: Alignment.bottomCenter,
            child: Padding(
                padding: EdgeInsets.only(bottom: 32.h),
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          KeyBoardNumber(
                              number: 1,
                              onPressed: () {
                                pinIndexSetup('1', context);
                              }),
                          KeyBoardNumber(
                              number: 2,
                              onPressed: () {
                                pinIndexSetup('2', context);
                              }),
                          KeyBoardNumber(
                              number: 3,
                              onPressed: () {
                                pinIndexSetup('3', context);
                              })
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          KeyBoardNumber(
                              number: 4,
                              onPressed: () {
                                pinIndexSetup('4', context);
                              }),
                          KeyBoardNumber(
                              number: 5,
                              onPressed: () {
                                pinIndexSetup('5', context);
                              }),
                          KeyBoardNumber(
                              number: 6,
                              onPressed: () {
                                pinIndexSetup('6', context);
                              })
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          KeyBoardNumber(
                              number: 7,
                              onPressed: () {
                                pinIndexSetup('7', context);
                              }),
                          KeyBoardNumber(
                              number: 8,
                              onPressed: () {
                                pinIndexSetup('8', context);
                              }),
                          KeyBoardNumber(
                              number: 9,
                              onPressed: () {
                                pinIndexSetup('9', context);
                              })
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Container(
                              width: 60.w,
                              child: MaterialButton(
                                  onPressed: null, child: SizedBox())),
                          KeyBoardNumber(
                              number: 0,
                              onPressed: () {
                                pinIndexSetup('0', context);
                              }),
                          Container(
                              width: 60.w,
                              child: MaterialButton(
                                  height: 60,
                                  shape: RoundedRectangleBorder(
                                      borderRadius:
                                          BorderRadius.circular(60.0)),
                                  onPressed: () {
                                    clearPin();
                                  },
                                  child: SvgPicture.asset(
                                      IconConstants.deleteIcon)))
                        ],
                      ),
                    ]))));
  }

  void pinIndexSetup(String text, BuildContext context) {
    if (pinIndex == 0) {
      pinIndex = 1;
    } else if (pinIndex < 4) {
      pinIndex++;
    }
    setPin(pinIndex, text);
    currentPin[pinIndex - 1] = text;
    String strPin = '';
    currentPin.forEach((element) {
      strPin += element;
    });
    if (pinIndex == 4) {
      context.read<CreatePinBloc>().add(CreatePinSubmitted(pin: strPin));
      context.read<AuthCubit>().showConfirmPin();
    }
  }

  void setPin(int number, String text) {
    switch (number) {
      case 1:
        pinOneConntroller.text = text;
        break;
      case 2:
        pinTwoConntroller.text = text;
        break;
      case 3:
        pinThreeConntroller.text = text;
        break;
      case 4:
        pinFourConntroller.text = text;
        break;
    }
  }

  void clearPin() {
    if (pinIndex == 0) {
      pinIndex = 0;
    } else if (pinIndex == 4) {
      setPin(pinIndex, '');
      currentPin[pinIndex - 1] = '';
      pinIndex--;
    } else {
      setPin(pinIndex, '');
      currentPin[pinIndex - 1] = '';
      pinIndex--;
    }
  }

  Widget _buildSecurityText() {
    return Text('Enhance the security of your account by creating a PIN code',
        textAlign: TextAlign.center,
        style: TextStyle(
            color: Color(0xFF485068),
            fontSize: 14.sp,
            fontWeight: FontWeight.bold));
  }

  Widget _buildPinRow() {
    return Row(mainAxisAlignment: MainAxisAlignment.center, children: [
      _pinNumber(
          outlineInputborder: outlineInputborder,
          textEditingController: pinOneConntroller),
      SizedBox(width: 20.w),
      _pinNumber(
          outlineInputborder: outlineInputborder,
          textEditingController: pinTwoConntroller),
      SizedBox(width: 20.w),
      _pinNumber(
          outlineInputborder: outlineInputborder,
          textEditingController: pinThreeConntroller),
      SizedBox(width: 20.w),
      _pinNumber(
          outlineInputborder: outlineInputborder,
          textEditingController: pinFourConntroller),
    ]);
  }

  Widget _pinNumber(
      {required OutlineInputBorder outlineInputborder,
      required TextEditingController textEditingController}) {
    return PinNumber(
        textEditingController: textEditingController,
        outlineInputBorder: outlineInputborder);
  }
}
