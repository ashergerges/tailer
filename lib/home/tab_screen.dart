
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tailer/shared/Style.dart';
import 'game_cubit/exam_cubit.dart';
import 'game_state/exam_state.dart';



class TabScreen extends StatelessWidget {
  const TabScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => GameCubit(),
      child: BlocConsumer<GameCubit, GameStates>(
        listener: (BuildContext context, state) {},
        builder: (context, state) {
          final items=[
           const  Icon(Icons.home,),
           const Icon(Icons.date_range,),
          ];
          var cubit=GameCubit.get(context);
          return Scaffold(
            backgroundColor: white,
            body:cubit.screen[cubit.currentIndex],
            extendBody: true,
            bottomNavigationBar: Theme(
              data: Theme.of(context).copyWith(
                iconTheme: const IconThemeData(color: Colors.white),
              ),
              child: CurvedNavigationBar(
                index:cubit.currentIndex,
                onTap: (index){
                  cubit.changePage(index);
                },
                height: 60,
                color: ko,
                backgroundColor: Colors.transparent,
                buttonBackgroundColor: ko,
                animationCurve: Curves.easeInOut,
                animationDuration: const Duration(milliseconds: 300),
                items: items,
              ),
            ),
          );
        },
      ),
    );

  }
}
