import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../shared/Components.dart';
import '../shared/Style.dart';
import 'game_cubit/exam_cubit.dart';
import 'game_state/exam_state.dart';

class AddPerson extends StatelessWidget {
  const AddPerson({Key? key}) : super(key: key);

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
            'هل انتهيت من أضافه شخص',
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
                title: const Text('أضافه شخص',style: TextStyle(fontSize: 24,fontWeight: FontWeight.bold)),
                centerTitle: true,
              ),
              body: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: Form(
                  key: GameCubit.get(context).key,
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 15.0, right: 15,top: 10),
                        child: textFormField(
                          controller: GameCubit.get(context).gameNameController,
                          type: TextInputType.text,
                          validate: (value) {
                            if (value!.isEmpty) {
                              return 'يجب أدخل اسم الشخص';
                            }
                            return null;
                          },
                          hint: 'أدخل اسم الشخص',
                          isExpanded: true,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 15.0, right: 15,top: 10),
                        child: textFormField(
                          controller: GameCubit.get(context).ageController,
                          type: TextInputType.text,
                          validate: (value) {
                            if (value!.isEmpty) {
                              return 'يجب أدخل مقاس الشخص';
                            }
                            return null;
                          },
                          hint: 'أدخل مقاس الشخص ',
                          isExpanded: true,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 15.0, right: 15,top: 10),
                        child: textFormField(
                          controller: GameCubit.get(context).describeController,
                          type: TextInputType.text,
                          validate: (value) {
                            if (value!.isEmpty) {
                              return 'يجب نوع التفصيله';
                            }
                            return null;
                          },
                          hint: 'أدخل نوع التفصيله',
                          isExpanded: true,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 15.0, right: 15,top: 10),
                        child: textFormField(
                          controller: GameCubit.get(context).gameOrderController,
                          type: TextInputType.text,
                          validate: (value) {
                            if (value!.isEmpty) {
                              return 'يجب تفاصيل الحساب';
                            }
                            return null;
                          },
                          hint: 'أدخل تفاصيل الحساب ',
                          isExpanded: true,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 15.0, right: 15,top: 10),
                        child: textFormField(
                          controller: GameCubit.get(context).amiController,
                          type: TextInputType.number,
                          validate: (value) {
                            if (value!.isEmpty) {
                              return 'يجب أدخل رقم الموبايل';
                            }
                            return null;
                          },
                          hint: 'أدخل رقم الموبايل',
                          isExpanded: true,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 15.0, right: 15,top: 10),
                        child: textFormField(
                          controller: GameCubit.get(context).notesController,
                          type: TextInputType.number,
                          validate: (value) {
                            if (value!.isEmpty) {
                              return 'يجب أدخل رقم البيت';
                            }
                            return null;
                          },
                          hint: 'أدخل  رقم البيت',
                          isExpanded: true,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 15.0, right: 15,top: 10),
                        child: textFormField(
                          controller: GameCubit.get(context).number3Controller,
                          type: TextInputType.number,
                          validate: (value) {
                            if (value!.isEmpty) {
                              return 'يجب أدخل رقم الشفل';
                            }
                            return null;
                          },
                          hint: 'أدخل رقم الشفل',
                          isExpanded: true,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 15.0, right: 15,top: 10),
                        child: textFormField(
                          controller: GameCubit.get(context).number4Controller,
                          type: TextInputType.number,
                          validate: (value) {
                            if (value!.isEmpty) {
                              return 'يجب أدخل رقم اخر';
                            }
                            return null;
                          },
                          hint: 'أدخل رقم اخر',
                          isExpanded: true,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 15.0, right: 15,top: 10),
                        child: textFormField(
                          controller: GameCubit.get(context).emailController,
                          type: TextInputType.emailAddress,
                          validate: (value) {
                            if (value!.isEmpty) {
                              return 'يجب أدخل الايميل';
                            }
                            return null;
                          },
                          hint: 'أدخل الايميل',
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
                                  GameCubit.get(context).cheekGame(context);

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
