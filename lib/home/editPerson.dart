
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tailer/home/models/gamedata.dart';
import 'package:tailer/shared/Components.dart';
import 'package:tailer/shared/Style.dart';

import 'game_cubit/exam_cubit.dart';
import 'game_state/exam_state.dart';

class EditePerson extends StatelessWidget {

  late GameModel gameModel;
  EditePerson({
    super.key,
    required this.gameModel,
  });

  @override
  Widget build(BuildContext context) {

    return BlocProvider(
      create: (BuildContext context) => GameCubit()..holdData(gameModel),
      child: BlocConsumer<GameCubit, GameStates>(
        listener: (BuildContext context, state) {
        },
        builder: (context, state) {

          return Scaffold(
            appBar: AppBar(
              backgroundColor: const Color(0xff1a033b),
              title: Text('  تعديل بيانات ${gameModel.nameGame.split(' ')[0]} '),
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
                            return 'يجب أدخل اسم العبه';
                          }
                          return null;
                        },
                        hint: gameModel.nameGame,
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
                            return 'يجب أدخل السن او مرحله المناسبه للعبه';
                          }
                          return null;
                        },
                        hint: gameModel.ageSuitable,
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
                            return 'يجب شرح اللعبه';
                          }
                          return null;
                        },
                        hint: gameModel.description,
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
                            return 'يجب طلبات اللعبه';
                          }
                          return null;
                        },
                        hint: gameModel.requirement,
                        isExpanded: true,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 15.0, right: 15,top: 10),
                      child: textFormField(
                        controller: GameCubit.get(context).amiController,
                        type: TextInputType.text,
                        validate: (value) {
                          if (value!.isEmpty) {
                            return 'يجب أدخل هدف اللعبه';
                          }
                          return null;
                        },
                        hint: gameModel.gameIma,
                        isExpanded: true,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 15.0, right: 15,top: 10),
                      child: textFormField(
                        controller: GameCubit.get(context).notesController,
                        type: TextInputType.text,
                        validate: (value) {
                          if (value!.isEmpty) {
                            return 'يجب أدخل ملاحظات اللعبه';
                          }
                          return null;
                        },
                        hint:gameModel.description,
                        isExpanded: true,
                      ),
                    ),

                    Padding(
                      padding: const EdgeInsets.only(left: 15.0, right: 15,top: 10),
                      child: textFormField(
                        controller: GameCubit.get(context).number3Controller,
                        type: TextInputType.text,
                        validate: (value) {
                          if (value!.isEmpty) {
                            return 'يجب أدخل ملاحظات اللعبه';
                          }
                          return null;
                        },
                        hint:gameModel.number3,
                        isExpanded: true,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 15.0, right: 15,top: 10),
                      child: textFormField(
                        controller: GameCubit.get(context).number4Controller,
                        type: TextInputType.text,
                        validate: (value) {
                          if (value!.isEmpty) {
                            return 'يجب أدخل ملاحظات اللعبه';
                          }
                          return null;
                        },
                        hint:gameModel.number4,
                        isExpanded: true,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 15.0, right: 15,top: 10),
                      child: textFormField(
                        controller: GameCubit.get(context).emailController,
                        type: TextInputType.text,
                        validate: (value) {
                          if (value!.isEmpty) {
                            return 'يجب أدخل ملاحظات اللعبه';
                          }
                          return null;
                        },
                        hint:gameModel.email,
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
                                GameCubit.get(context).cheekPerson(context,gameModel);

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
