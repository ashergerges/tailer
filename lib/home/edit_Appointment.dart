import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tailer/home/models/appontimentdata.dart';
import 'package:tailer/shared/Components.dart';
import 'package:tailer/shared/Style.dart';

import 'game_cubit/exam_cubit.dart';
import 'game_state/exam_state.dart';

class EditeAppointment extends StatelessWidget {
  late AppointmentModel gameModel;
  EditeAppointment({
    super.key,
    required this.gameModel,
  });


  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => GameCubit()..holdAppointment(gameModel),
      child: BlocConsumer<GameCubit, GameStates>(
        listener: (BuildContext context, state) {
        },
        builder: (context, state) {

          return Scaffold(
            appBar: AppBar(
              backgroundColor: const Color(0xff1a033b),
              title: Text('   ${gameModel.data} تعديل حساب'),
              centerTitle: true,
            ),
            body: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: Form(
                key: GameCubit.get(context).key,
                child: Column(
                  children: [

                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        decoration: BoxDecoration(
                          color: ko,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            textButton(
                              context,
                              GameCubit.get(context).timePerDay != ''
                                  ? GameCubit.get(context).timePerDay
                                  : 'اختر يوم الحساب',
                              ko,
                              white,
                              sizeFromWidth(context, 25),
                              FontWeight.w800,
                                  () {
                                GameCubit.get(context).selectDatePerDay(context);
                              },
                            ),
                            Padding(
                              padding: const EdgeInsets.only(right: 8.0),
                              child: textWidget(
                                "توقيت الحساب",
                                null,
                                null,
                                white,
                                sizeFromWidth(context, 20),
                                FontWeight.w800,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 15.0, right: 15,top: 10),
                      child: textFormField(
                        controller: GameCubit.get(context).kadmaNumber,
                        type: TextInputType.text,
                        validate: (value) {
                          if (value!.isEmpty) {
                            return 'يجب أدخل الحساب';
                          }
                          return null;
                        },
                        hint: 'أدخل الحساب',
                        isExpanded: true,
                      ),
                    ),

                    Padding(
                      padding: const EdgeInsets.only(left: 75.0, right: 75,top: 10),
                      child: textFormField(
                        controller: GameCubit.get(context).totalController,
                        type: TextInputType.number,
                        validate: (value) {
                          if (value!.isEmpty) {
                            return 'يجب أدخل اجمالي الحساب';
                          }
                          return null;
                        },
                        hint: 'أدخل اجمالي الحساب',
                        isExpanded: true,
                      ),
                    ),
                    ///////////////
                    SizedBox(
                        height: sizeFromHeight(context, 5.5, hasAppBar: true)),
                    Padding(
                      padding: EdgeInsets.symmetric(
                          vertical: 0, horizontal: sizeFromWidth(context, 10)),
                      child: Row(
                        children: [
                          Expanded(
                            child: floatTextButton(
                              'showExam',
                              null,
                              ko,
                              white,
                              sizeFromWidth(context, 20),
                              FontWeight.bold,
                              'تاكيد',
                                  () async {
                                GameCubit.get(context).cheekAppoint(context,gameModel);

                              },
                            ),
                          )
                        ],
                      ),
                    ),
                    SizedBox(
                        height: sizeFromHeight(context, 15, hasAppBar: true)),

                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
