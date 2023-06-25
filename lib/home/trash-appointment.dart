import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tailer/home/appointment_details.dart';
import 'package:tailer/home/models/appontimentdata.dart';
import 'package:tailer/home/return-trash-Appointment.dart';
import 'package:tailer/shared/Style.dart';

import '../shared/Components.dart';
import 'game_cubit/exam_cubit.dart';
import 'game_state/exam_state.dart';

class TrashAppointment extends StatelessWidget {
  const TrashAppointment({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => GameCubit()..getAppointmentDelete(),
      child: BlocConsumer<GameCubit, GameStates>(
        listener: (BuildContext context, state) {},
        builder: (context, state) {
          return Scaffold(
            appBar: AppBar(

              backgroundColor: const Color(0xff1a033b),
              title: const Text('سله المحزوفات',style: TextStyle(fontSize: 24,fontWeight: FontWeight.bold),),
              centerTitle: true,
            ),
            body:  SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: Column(
                children: [
                  ConditionalBuilder(
                    condition: GameCubit.get(context).appointmentDelete.isNotEmpty,
                    builder: (context) => ListView.separated(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemBuilder: (context, index) {
                        return buildAppointmentItem(GameCubit.get(context).appointmentDelete[index], context, index);
                      },
                      separatorBuilder: (context, index) =>
                          divider(10, 10, lightGrey),
                      itemCount: GameCubit.get(context).appointmentDelete.length,
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
                              'لا يوجد حسابات محزوفه',
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
                "هل تريد ان تمسح الحساب اليومي هذا ؟"),
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
      GameCubit.get(context).deleteAppointment(model.id);
    },
    key: Key(index.toString()),
    child: InkWell(
      onTap: () async {
        navigateTo(context, ReturnAppointmentDetails(appointmentModel: model,));
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