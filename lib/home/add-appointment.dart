
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';
import 'package:tailer/home/game_state/exam_state.dart';
import 'package:tailer/shared/Components.dart';
import 'package:tailer/shared/Style.dart';
import 'game_cubit/exam_cubit.dart';

class AddAppointment extends StatelessWidget {
  const AddAppointment({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    Future<bool> onWillPop() async {
      return await showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: textWidget(
            'هل انت متاكد ؟',
            TextDirection.rtl,
            null,
            petroleum,
            sizeFromWidth(context, 20),
            FontWeight.w600,
          ),
          content: textWidget(
            'هل انتهيت من انهاء الحساب',
            TextDirection.rtl,
            null,
            petroleum,
            sizeFromWidth(context, 20),
            FontWeight.w400,
          ),
          actions: <Widget>[

            TextButton(
              onPressed: () => Navigator.of(context).pop(false),
              child: Text('No', style: TextStyle(color: ko)),
            ),
            TextButton(
              onPressed: (){
                Navigator.of(context).pop(true);
                GameCubit.get(context).cheekAppointment(context);

              },
              child: Text(
                'Yes',
                style: TextStyle(color: ko),
              ),
            ),
          ],
        ),
      );
    }
    return BlocProvider(
      create: (BuildContext context) => GameCubit(),
      child: BlocConsumer<GameCubit, GameStates>(
        listener: (BuildContext context, state) {},
        builder: (context, state) {
          return WillPopScope(
              onWillPop: onWillPop,
              child: Scaffold(
                appBar: AppBar(
                  backgroundColor: const Color(0xff1a033b),
                  title: const Text('الحساب اليومي',style: TextStyle(fontSize: 24,fontWeight: FontWeight.bold),),
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

                        SizedBox(
                            height: sizeFromHeight(context, 2, hasAppBar: true)),
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
                                  'انهاء الحساب ',
                                      () async {
                                        GameCubit.get(context).cheekAppointment(context);

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
              ),
          );
        },
      ),
    );
  }
}
