import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tailer/home/add-appointment.dart';
import 'package:tailer/home/appointment_details.dart';
import 'package:tailer/home/models/appontimentdata.dart';
import 'package:tailer/home/trash-appointment.dart';

import '../shared/Components.dart';
import '../shared/Style.dart';
import 'game_cubit/exam_cubit.dart';
import 'game_state/exam_state.dart';

class AppointmentScreen extends StatelessWidget {
  const AppointmentScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    return BlocProvider(
      create: (BuildContext context) => GameCubit()..getAppointment()..getTotal(),
      child: BlocConsumer<GameCubit, GameStates>(
        listener: (BuildContext context, state) {},
        builder: (context, state) {
          return Scaffold(
            appBar: AppBar(
              actions: [
                Padding(
                  padding: const EdgeInsets.only(right: 8.0),
                  child: CircleAvatar(
                    backgroundColor: white,
                    child: IconButton(
                      onPressed: () {
                        navigateTo(context,const AddAppointment());
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
                        navigateTo(context,const TrashAppointment());
                      },
                      icon: Icon(Icons.auto_delete_outlined, color: ko),
                    ),
                  ),
                ),
              ],
              backgroundColor: const Color(0xff1a033b),
              title: const Text('الحسابات',style: TextStyle(fontSize: 24,fontWeight: FontWeight.bold),),
              centerTitle: true,
            ),
            body:  SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(20),
                    child: textFormField(
                        controller: GameCubit.get(context).searchAppointmentController,
                        type: TextInputType.text,
                        validate: (value) {
                          return null;
                        },
                        hint: "ابحث عن حساب ......",
                        isExpanded: true,
                        fromLTR: false,
                        onTap: () {
                          GameCubit.get(context).searchAppointmentController.text='';
                          GameCubit.get(context).getAppointment();
                        },
                        onChange: (value) {
                          if (GameCubit.get(context).searchAppointmentController.text ==
                              '' ||
                              GameCubit.get(context).appointment.isEmpty) {
                            GameCubit.get(context).getAppointment();
                          }
                          GameCubit.get(context).searchAboutAppointment(value);
                        }),
                  ),
                  ConditionalBuilder(
                    condition: GameCubit.get(context).appointment.isNotEmpty,
                    builder: (context) => ListView.separated(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemBuilder: (context, index) {
                        return buildAppointmentItem(GameCubit.get(context).appointment[index], context, index);
                      },
                      separatorBuilder: (context, index) =>
                          divider(10, 10, lightGrey),
                      itemCount: GameCubit.get(context).appointment.length,
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
                              'لا يوجد حسابات مصافه',
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

Widget buildAppointmentItem(AppointmentModel model, context,index) {
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
                "هل تريد ان تمسح الحساب اليومي هذا الي سله المحزوفات ؟"),
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
      print('asher');
      GameCubit.get(context).trashAppointment(model.id);
    },
    key: Key(index.toString()),
    child: InkWell(
      onTap: () async {
       navigateTo(context, AppointmentDetails(appointmentModel: model,));
      },
      child: Padding(
        padding: const EdgeInsets.all(5),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            storyShape(
              context,
              white,
              const NetworkImage('https://www.in.gov/dor/images/Appointment.png'),
              20,
              18,
            ),
            const SizedBox(width: 5),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  textWidget(
                    model.data,
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