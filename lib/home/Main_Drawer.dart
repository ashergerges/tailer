// ignore_for_file: use_key_in_widget_constructors

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tailer/home/game_cubit/exam_cubit.dart';
import 'package:tailer/home/game_state/exam_state.dart';
import 'package:tailer/home/tab_screen.dart';
import 'package:tailer/shared/Components.dart';

import '../../../shared/Style.dart';

class MainDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => GameCubit()..getTotal(),
      child: BlocConsumer<GameCubit, GameStates>(
          listener: (context, state) {},
          builder: (context, state) {
            return Drawer(
              backgroundColor: ko,
              elevation: 0,
              child: Column(
                children: <Widget>[
                  Expanded(
                    child: ListView(
                      physics: const BouncingScrollPhysics(),
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(top: 58.0),
                          child: storyShape(
                            context,
                            white,
                            const AssetImage('assets/images/logo.png'),
                            10,
                            10,
                          ),
                        ),
                        Padding(
                          padding:
                          const EdgeInsets.only(left: 10, right: 10, top: 30),
                          child: Column(
                            children: [

                              materialWidget(
                                  context,
                                  null,
                                  sizeFromWidth(context, 1),
                                  20,
                                  null,
                                  BoxFit.cover,
                                  [
                                    Column(

                                      children: [
                                        textWidget(
                                          'اجمالي الحساب ',
                                          TextDirection.rtl,
                                          null,
                                          Colors.black,
                                          sizeFromWidth(context, 20),
                                          FontWeight.bold,
                                        ),
                                        textWidget(
                                          '${GameCubit.get(context).total} جنيه ',
                                          TextDirection.rtl,
                                          null,
                                          white,
                                          sizeFromWidth(context, 25),
                                          FontWeight.bold,
                                        ),
                                      ],
                                    ),

                                  ],
                                  MainAxisAlignment.start,
                                  false,
                                  10,
                                  Colors.amber,
                                      () {},
                                  CrossAxisAlignment.end),
                            ],
                          ),
                        ),
                        Padding(
                          padding:
                          const EdgeInsets.only(left: 10, right: 10, top: 30),
                          child: Column(
                            children: [

                              materialWidget(
                                  context,
                                  null,
                                  sizeFromWidth(context, 1),
                                  20,
                                  null,
                                  BoxFit.cover,
                                  [
                                    Column(

                                      children: [
                                        textWidget(
                                          'تغيير الباسورد',
                                          TextDirection.rtl,
                                          null,
                                          Colors.black,
                                          sizeFromWidth(context, 20),
                                          FontWeight.bold,
                                        ),
                                        TextFormField(

                                          controller:GameCubit.get(context).changePassword ,
                                          cursorColor: black,
                                          textAlign: TextAlign.center,
                                          style:TextStyle(color: black) ,
                                          keyboardType: TextInputType.number,
                                          decoration: InputDecoration(
                                            hintText: 'XXXXXX',
                                            hintStyle: TextStyle(
                                              fontSize: 20,
                                              fontWeight: FontWeight.w500,
                                              color: petroleum,
                                            ),
                                            filled: true,
                                            fillColor: white,
                                            focusedBorder: OutlineInputBorder(
                                              borderSide: BorderSide(color: black),
                                              borderRadius: BorderRadius.circular(30),
                                            ),
                                            enabledBorder: OutlineInputBorder(
                                              borderSide: BorderSide(color: ko),
                                              borderRadius: BorderRadius.circular(30),
                                            ),
                                          ),

                                          onEditingComplete: (){
                                            if(GameCubit.get(context).changePassword.text!='')
                                            {
                                              showToast(text: 'تم تحديث كلمه المرور بنجاح', state: ToastStates.SUCCESS);
                                              GameCubit.get(context).upDataPassword(GameCubit.get(context).changePassword.text);
                                              navigateAndFinish(context, const TabScreen());

                                            }
                                            else
                                            {
                                              showToast(text: 'يجب ادخال كلمه مرور', state: ToastStates.ERROR);
                                            }
                                          },

                                        ),
                                        const SizedBox(height: 10),
                                        floatTextButton(
                                          'showExam',
                                          null,
                                          ko,
                                          white,
                                          sizeFromWidth(context, 20),
                                          FontWeight.bold,
                                          'Updata',
                                              () async {

                                            if(GameCubit.get(context).changePassword.text!='')
                                            {
                                              GameCubit.get(context).upDataPassword(GameCubit.get(context).changePassword.text);
                                              showToast(text: 'تم تحديث كلمه المرور بنجاح', state: ToastStates.SUCCESS);
                                              navigateAndFinish(context, const TabScreen());
                                            }
                                            else
                                            {
                                              showToast(text: 'يجب ادخال كلمه مرور', state: ToastStates.ERROR);
                                            }

                                          },
                                        ),

                                      ],
                                    ),

                                  ],
                                  MainAxisAlignment.start,
                                  false,
                                  10,
                                  Colors.amber,
                                      () {},
                                  CrossAxisAlignment.end),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            );
          }),
    );
  }
}
