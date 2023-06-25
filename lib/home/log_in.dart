import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tailer/shared/Style.dart';

import '../shared/Components.dart';
import 'game_cubit/exam_cubit.dart';
import 'game_state/exam_state.dart';
import 'tab_screen.dart';

class SignIn extends StatelessWidget {
  const SignIn({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    return BlocProvider(
      create: (BuildContext context) => GameCubit()..getPassword()..getTotal(),
      child: BlocConsumer<GameCubit, GameStates>(
        listener: (BuildContext context, state) {},
        builder: (context, state) {
          return Scaffold(
            extendBodyBehindAppBar: true,
            appBar: AppBar(
              backgroundColor: Colors.transparent,
              elevation: 0,

            ),
            body: SingleChildScrollView(
              physics:const BouncingScrollPhysics(),
              child: Container(
                height: sizeFromHeight(context, 1),
                width: sizeFromWidth(context, 1),
                decoration: const BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage("assets/images/logo.png"),
                    fit: BoxFit.fill,
                  ),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Spacer(),
                    Container(
                        margin: EdgeInsets.symmetric(
                            vertical: 5, horizontal: sizeFromWidth(context, 5)),
                        decoration: BoxDecoration(
                            color: ko, borderRadius: BorderRadius.circular(10)),
                        child: Expanded(
                          child: TextFormField(
                            controller:GameCubit.get(context).signIn ,
                            cursorColor: white,
                            textAlign: TextAlign.center,
                            style:TextStyle(color: white) ,
                            keyboardType: TextInputType.number,
                            decoration: const InputDecoration(
                              hintText: 'xxxxx',
                              hintStyle: TextStyle(color: Colors.white),
                              border:OutlineInputBorder(),

                            ),

                            onEditingComplete: (){
                              if(GameCubit.get(context).signIn.text==GameCubit.get(context).password)
                              {
                                navigateAndFinish(context, const TabScreen());
                              }
                              else
                                {
                                  showToast(text: 'The password is incorrect ,Please Try again', state: ToastStates.ERROR);
                                }
                            },

                          ),
                        )),

                    const SizedBox(height: 10),
                    floatTextButton(
                      'showExam',
                      null,
                      ko,
                      white,
                      sizeFromWidth(context, 20),
                      FontWeight.bold,
                      'Log in',
                          () async {
                            print(GameCubit.get(context).password);
                            print(';;;;');
                            print(GameCubit.get(context).signIn.text);
                            GameCubit.get(context).getPassword();
                        if(GameCubit.get(context).signIn.text==GameCubit.get(context).password)
                        {

                          navigateAndFinish(context, const TabScreen());
                        }
                        else
                        {
                          showToast(text: 'The password is incorrect ,Please Try again', state: ToastStates.ERROR);
                        }

                      },
                    ),
                    const SizedBox(height: 25),

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
