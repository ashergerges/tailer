import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tailer/home/Main_Drawer.dart';
import 'package:tailer/home/addperson.dart';
import 'package:tailer/home/models/gamedata.dart';
import 'package:tailer/home/person_details.dart';
import 'package:tailer/home/trash-game.dart';

import '../shared/Components.dart';
import '../shared/Style.dart';

import 'game_cubit/exam_cubit.dart';
import 'game_state/exam_state.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    return BlocProvider(
      create: (BuildContext context) => GameCubit()..getGame()..getTotal(),
      child: BlocConsumer<GameCubit, GameStates>(
        listener: (BuildContext context, state) {},
        builder: (context, state) {
          return Scaffold(
            drawer: MainDrawer(),
            appBar: AppBar(
              actions: [
                Padding(
                  padding: const EdgeInsets.only(right: 8.0),
                  child: CircleAvatar(
                    backgroundColor: white,
                    child: IconButton(
                      onPressed: () {
                        GameCubit.get(context).getPassword();
                        navigateTo(context, const AddPerson());
                      },
                      icon: Icon(Icons.add, color: ko),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(right: 8.0),
                  child: CircleAvatar(
                    backgroundColor: Colors.amber,
                    child: IconButton(
                      onPressed: () {
                        GameCubit.get(context).getPassword();
                        navigateTo(context, const TrashGame());
                      },
                      icon: Icon(Icons.auto_delete_outlined, color: ko),
                    ),
                  ),
                ),
              ],
              backgroundColor:const Color(0xff1a033b),
              title:const Text('الزبائن',style: TextStyle(fontSize: 24,fontWeight: FontWeight.bold),),
              centerTitle: true,
            ),
            body:  SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(20),
                    child: textFormField(
                        controller: GameCubit.get(context).searchGameController,
                        type: TextInputType.text,
                        validate: (value) {
                          return null;
                        },
                        hint: "ابحث عن زبون.......",
                        isExpanded: true,
                        fromLTR: false,
                        onTap: () {
                           GameCubit.get(context).getGame();
                        },
                        onChange: (value) {
                          if (GameCubit.get(context).searchGameController.text ==
                              '' || GameCubit.get(context).games.isEmpty) {
                            GameCubit.get(context).getGame();
                          }
                          GameCubit.get(context).searchAboutGame(value);
                        //  GameCubit.get(context).searchAboutGametype(value);

                        }),
                  ),
                  ConditionalBuilder(
                    condition: GameCubit.get(context).games.isNotEmpty,
                    builder: (context) =>  ListView.separated(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemBuilder: (context, index) {
                        return buildGameItem(GameCubit.get(context).games[index], context,index);
                      },
                      separatorBuilder: (context, index) =>
                          divider(10, 10, lightGrey),
                      itemCount: GameCubit.get(context).games.length,
                    ),
                    fallback: (context) => Center(
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 15, vertical: 5),
                        child: materialWidget(
                          context,
                          sizeFromHeight(context, 3, hasAppBar: true),
                          sizeFromWidth(context, 1),
                          20,
                          null,
                          BoxFit.fill,
                          [
                            textWidget(
                              'لا يوجد اشخاص مضافه',
                              null,
                              null,
                              petroleum,
                              sizeFromWidth(context, 20),
                              FontWeight.bold,
                            ),
                          ],
                          MainAxisAlignment.center,
                          false,
                          10,
                          Colors.amber,
                              () {},
                        ),
                      ),
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

Widget buildGameItem(GameModel model, context,index) {
  return Dismissible(
    background: Container(
      margin: const EdgeInsets.only(top: 10),
      color: Colors.red,
      alignment: Alignment.centerLeft,
      child: const Icon(Icons.delete),
    ),
    secondaryBackground: Container(
      margin: const EdgeInsets.only(top: 10),
      color: Colors.red,
      alignment: Alignment.centerRight,
      child: const Icon(Icons.delete),
    ),
    confirmDismiss: (DismissDirection direction) async {
      return await showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text("تاكيدالمسح"),
            content: const Text(
                "هل تريد ان تمسح الحساب الشخصي هذا الي سله المحزوفات؟"),
            actions: <Widget>[

              TextButton(
                onPressed: () => Navigator.of(context).pop(false),
                child: const Text("Cancel",style: TextStyle(color: const Color(0xff1a033b))),
              ),
              TextButton(
                onPressed: () => Navigator.of(context).pop(true),

                child: const Text("Delete",style: TextStyle(color: const Color(0xff1a033b)),),

              ),
            ],
          );
        },
      );
    },

    onDismissed: (_) {
      GameCubit.get(context).trashGame(model.id);
    },
    key: Key(index.toString()),
    child: InkWell(
      onTap: () async {
        navigateTo(context, PersonDetails(gameModel: model,));
      },
      child: Padding(
        padding: const EdgeInsets.all(5),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            storyShape(
              context,
              white,
              const NetworkImage('https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRX59n2TtcbvxByFG28M5BR4Tox4_KajwhOM_qlgmA665nwiJSW6uVp2xVZ6T1_Lt_bxAg&usqp=CAU'),
                20,
              18,
            ),
            const SizedBox(width: 5),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  textWidget(
                    model.nameGame,
                    TextDirection.rtl,
                    TextAlign.center,
                    petroleum,
                    sizeFromWidth(context, 20),
                    FontWeight.bold,
                  ),

                ],
              ),
            ),

          ],
        ),
      ),
    ),
  );
}