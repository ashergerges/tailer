import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tailer/home/models/appontimentdata.dart';
import 'package:tailer/shared/Components.dart';
import 'package:tailer/shared/Style.dart';

import 'game_cubit/exam_cubit.dart';
import 'game_state/exam_state.dart';

class ReturnAppointmentDetails extends StatelessWidget {
  late AppointmentModel appointmentModel;
  ReturnAppointmentDetails({
    super.key,
    required this.appointmentModel,
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
              title:  Text('  ${appointmentModel.data} تفاصيل'),
              centerTitle: true,
              actions: [
                Padding(
                  padding: const EdgeInsets.only(right: 8.0),
                  child: CircleAvatar(
                    backgroundColor: white,
                    child: IconButton(
                      onPressed: () {
                        GameCubit.get(context).returnTrashAppointment(appointmentModel.id);
                        navigatePop(context);
                      },
                      icon: Icon(Icons.dangerous, color: ko),
                    ),
                  ),
                ),
              ],
            ),
            body: Column(
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
                        Column(
                          children: [
                            textButton(
                              context,
                              GameCubit.get(context).timePerDay != ''
                                  ? GameCubit.get(context).timePerDay
                                  : appointmentModel.data,
                              ko,
                              white,
                              sizeFromWidth(context, 25),
                              FontWeight.w800,
                                  () {
                                GameCubit.get(context).selectDatePerDay(context);
                              },
                            ),

                          ],
                        ),
                        Padding(
                          padding: const EdgeInsets.only(right: 8.0),
                          child: textWidget(
                            "توقيت الحساب ",
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
                              'الحساب  ',
                              TextDirection.rtl,
                              null,
                              orange,
                              sizeFromWidth(context, 20),
                              FontWeight.bold,
                            ),
                            textWidget(
                              appointmentModel.namekhadma,
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
                              'اجمالي الحساب',
                              TextDirection.rtl,
                              null,
                              orange,
                              sizeFromWidth(context, 20),
                              FontWeight.bold,
                            ),
                            textWidget(
                              appointmentModel.total,
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

              ],
            ),
          );
        },
      ),
    );

  }
}
