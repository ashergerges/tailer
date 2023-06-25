import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tailer/home/editPerson.dart';
import 'package:tailer/home/models/gamedata.dart';
import 'package:tailer/shared/Components.dart';
import 'package:url_launcher/url_launcher.dart';




import '../shared/Style.dart';
import 'game_cubit/exam_cubit.dart';
import 'game_state/exam_state.dart';

class PersonDetails extends StatelessWidget {
  late GameModel gameModel;
  PersonDetails({
    super.key,
    required this.gameModel,
  });

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => GameCubit(),
      child: BlocConsumer<GameCubit, GameStates>(
        listener: (BuildContext context, state) {},
        builder: (context, state) {
          return Scaffold(
            appBar: AppBar(
              backgroundColor: ko,
              title: Text('  تفاصيل ${gameModel.nameGame.split(' ')[0]}'),
              centerTitle: true,
              actions: [
                Padding(
                  padding: const EdgeInsets.only(right: 8.0),
                  child: CircleAvatar(
                    backgroundColor: white,
                    child: IconButton(
                      onPressed: () {
                        navigateTo(context,  EditePerson(gameModel: gameModel,));
                      },
                      icon: Icon(Icons.edit, color: ko),
                    ),
                  ),
                ),
              ],
            ),
            body: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: Column(
                children: [
                  Padding(
                    padding:
                    const EdgeInsets.only(left: 10, right: 10, top: 10),
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
                              textWidget(
                                'اسم الشخص ',
                                TextDirection.rtl,
                                null,
                                orange,
                                sizeFromWidth(context, 20),
                                FontWeight.bold,
                              ),
                              textWidget(
                                gameModel.nameGame,
                                TextDirection.rtl,
                                null,
                                white,
                                sizeFromWidth(context, 25),
                                FontWeight.bold,
                              ),

                            ],
                            MainAxisAlignment.center,
                            false,
                            10,
                            ko,
                                () {},
                            CrossAxisAlignment.center
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding:
                    const EdgeInsets.only(left: 10, right: 10, top: 10),
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
                              textWidget(
                                'أدخل مقاس الشخص ',
                                TextDirection.rtl,
                                null,
                                orange,
                                sizeFromWidth(context, 20),
                                FontWeight.bold,
                              ),
                              textWidget(
                                gameModel.ageSuitable,
                                TextDirection.rtl,
                                null,
                                white,
                                sizeFromWidth(context, 25),
                                FontWeight.bold,
                              ),

                            ],
                            MainAxisAlignment.center,
                            false,
                            10,
                            ko,
                                () {},
                            CrossAxisAlignment.center
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding:
                    const EdgeInsets.only(left: 10, right: 10, top: 10),
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
                                    'نوع التفصيله ',
                                    TextDirection.rtl,
                                    null,
                                    orange,
                                    sizeFromWidth(context, 20),
                                    FontWeight.bold,
                                  ),
                                  textWidget(
                                    gameModel.description,
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
                            ko,
                                () {},
                            CrossAxisAlignment.end),
                      ],
                    ),
                  ),
                  Padding(
                    padding:
                    const EdgeInsets.only(left: 10, right: 10, top: 10),
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
                                    'تفاصيل الحساب ',
                                    TextDirection.rtl,
                                    null,
                                    orange,
                                    sizeFromWidth(context, 20),
                                    FontWeight.bold,
                                  ),
                                  textWidget(
                                    gameModel.requirement,
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
                            ko,
                                () {},
                            CrossAxisAlignment.end),
                      ],
                    ),
                  ),

                  Padding(
                    padding:
                    const EdgeInsets.only(left: 10, right: 10, top: 10),
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
                                    'رقم الموبايل',
                                    TextDirection.rtl,
                                    null,
                                    orange,
                                    sizeFromWidth(context, 20),
                                    FontWeight.bold,
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      textWidget(
                                        gameModel.gameIma,
                                        TextDirection.rtl,
                                        null,
                                        white,
                                        sizeFromWidth(context, 25),
                                        FontWeight.bold,
                                      ),
                                      IconButton(onPressed: (){
                                        launch('tel://${gameModel.gameIma}');
                                      },
                                          icon: Icon(Icons.call,color: white,)),
                                    ],
                                  ),
                                ],
                              ),

                            ],
                            MainAxisAlignment.start,
                            false,
                            10,
                            ko,
                                () {},
                            CrossAxisAlignment.end),
                      ],
                    ),
                  ),
                  Padding(
                    padding:
                    const EdgeInsets.only(left: 10, right: 10, top: 10),
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
                                    'رقم البيت',
                                    TextDirection.rtl,
                                    null,
                                    orange,
                                    sizeFromWidth(context, 20),
                                    FontWeight.bold,
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      textWidget(
                                        gameModel.notes,
                                        TextDirection.rtl,
                                        null,
                                        white,
                                        sizeFromWidth(context, 25),
                                        FontWeight.bold,
                                      ),
                                      IconButton(onPressed: (){
                                        launch('tel://${gameModel.notes}');
                                      },
                                          icon: Icon(Icons.call,color: white,)),
                                    ],
                                  ),
                                ],
                              ),

                            ],
                            MainAxisAlignment.start,
                            false,
                            10,
                            ko,
                                () {},
                            CrossAxisAlignment.end),
                      ],
                    ),
                  ),
                  Padding(
                    padding:
                    const EdgeInsets.only(left: 10, right: 10, top: 10),
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
                                    'رقم الشفل',
                                    TextDirection.rtl,
                                    null,
                                    orange,
                                    sizeFromWidth(context, 20),
                                    FontWeight.bold,
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      textWidget(
                                        gameModel.number3,
                                        TextDirection.rtl,
                                        null,
                                        white,
                                        sizeFromWidth(context, 25),
                                        FontWeight.bold,
                                      ),
                                      IconButton(onPressed: (){
                                        launch('tel://${gameModel.number3}');
                                      },
                                          icon: Icon(Icons.call,color: white,)),
                                    ],
                                  ),
                                ],
                              ),

                            ],
                            MainAxisAlignment.start,
                            false,
                            10,
                            ko,
                                () {},
                            CrossAxisAlignment.end),
                      ],
                    ),
                  ),
                  Padding(
                    padding:
                    const EdgeInsets.only(left: 10, right: 10, top: 10),
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
                                    'رقم اخر',
                                    TextDirection.rtl,
                                    null,
                                    orange,
                                    sizeFromWidth(context, 20),
                                    FontWeight.bold,
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      textWidget(
                                        gameModel.number4,
                                        TextDirection.rtl,
                                        null,
                                        white,
                                        sizeFromWidth(context, 25),
                                        FontWeight.bold,
                                      ),
                                      IconButton(onPressed: (){
                                        launch('tel://${gameModel.number4}');
                                      },
                                          icon: Icon(Icons.call,color: white,)),
                                    ],
                                  ),
                                ],
                              ),

                            ],
                            MainAxisAlignment.start,
                            false,
                            10,
                            ko,
                                () {},
                            CrossAxisAlignment.end),
                      ],
                    ),
                  ),
                  //
                  Padding(
                    padding:
                    const EdgeInsets.only(left: 10, right: 10, top: 10),
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
                                    'الايميل ',
                                    TextDirection.rtl,
                                    null,
                                    orange,
                                    sizeFromWidth(context, 20),
                                    FontWeight.bold,
                                  ),
                                  textWidget(
                                    gameModel.email,
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
                            ko,
                                () {},
                            CrossAxisAlignment.end),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
