// ignore_for_file: use_build_context_synchronously


import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';

import 'package:intl/intl.dart';
import 'package:tailer/home/appointmentScreen.dart';
import 'package:tailer/home/game_state/exam_state.dart';
import 'package:tailer/home/home-screen.dart';
import 'package:tailer/home/models/appontimentdata.dart';
import 'package:tailer/home/models/gamedata.dart';
import 'package:tailer/home/tab_screen.dart';

import '../../../../shared/Components.dart';
import '../../../../shared/Style.dart';
import '../../../../shared/constants.dart';


class GameCubit extends Cubit<GameStates> {
  GameCubit() : super(GameInitialState());

  static GameCubit get(context) => BlocProvider.of(context);

  TextEditingController searchGameController = TextEditingController();
  TextEditingController searchAppointmentController = TextEditingController();
  TextEditingController kadmaNumber = TextEditingController();
  TextEditingController saanController = TextEditingController();
  TextEditingController gameNameController = TextEditingController();
  TextEditingController ageController = TextEditingController();
  TextEditingController describeController = TextEditingController();
  TextEditingController gameOrderController = TextEditingController();
  TextEditingController amiController = TextEditingController();
  TextEditingController notesController = TextEditingController();
  TextEditingController signIn = TextEditingController();
 //
  TextEditingController number3Controller = TextEditingController();
  TextEditingController number4Controller = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController totalController = TextEditingController();

  TextEditingController changePassword = TextEditingController();


  String timePerDay = '';
  String startTimeExam = DateFormat.jm().format(DateTime.now()).trim();
  String endTimeExam = DateFormat.jm().format(DateTime.now()).trim();
  TimeOfDay time = TimeOfDay(hour: DateTime.now().hour.toInt(), minute: DateTime.now().minute.toInt());

  final key = GlobalKey<FormState>();
  String typeOfUser = '';

  int currentIndex=0;
  List<Widget>screen=[
    const HomeScreen(),
   const AppointmentScreen(),
  ];

  void changePage(int index) {
    if(index==0){
      getGame();
    }
    if(index==1){
      getAppointment();
    }
    currentIndex = index;
    emit(TabChangeScreenState());
  }


  void emptyFields() {
    ageController.text = '';
    amiController.text = '';
    describeController.text = '';
    gameOrderController.text = '';
    notesController.text = '';
    gameNameController.text = '';
    number3Controller.text='';
    number4Controller.text='';
    emailController.text='';
    emit(EmptyFieldsState());
  }

  void selectDatePerDay(BuildContext context) {
    DatePicker.showDatePicker(
      context,
      showTitleActions: true,
      minTime: DateTime(2, 3, 5),
      maxTime: DateTime(3500, 6, 7),
      onChanged: (date) {
        timePerDay = DateFormat.yMMMd().format(date).toString();
        emit(SelectDatePerDayState());
      },
      onConfirm: (date) {
        timePerDay = DateFormat.yMMMd().format(date).toString();
        emit(SelectDatePerDayState());
      },
      currentTime: DateTime.now(),
    );
  }

  void selectStartTimeExam(BuildContext context) {
    showTimePicker(
      context: context,
      initialTime: time,
      builder: (context, child) {
        return Theme(
          data: ThemeData(
            colorScheme: ColorScheme.light(primary: ko),
          ),
          child: child!,
        );
      },
    ).then((value) {
      if (value == null) {
        FocusScope.of(context).unfocus();
        return;
      } else {
        startTimeExam = value.format(context).toString().trim();
        emit(SelectStartExamState());
      }
    });
  }

  void selectEndTimeExam(BuildContext context) {
    showTimePicker(
        context: context,
        initialTime: time,
        builder: (context, child) {
          return Theme(
            data: ThemeData(
              colorScheme: ColorScheme.light(primary: ko),
            ),
            child: child!,
          );
        }).then((value) async {
      examId = '';

      if (value == null) {
        FocusScope.of(context).unfocus();

        return;
      }
      endTimeExam = value.format(context).toString().trim();
      emit(SelectEndExamState());
    });
  }

  void cheekAppointment(BuildContext context) {
     if (timePerDay == '') {
      showToast(
          text: 'لازم تحدد اليوم', state: ToastStates.WARNING);
    } else if (key.currentState!.validate() && timePerDay != '' ) {
       sendAppointment();
      showToast(
          text: 'الحساب تم حفظه بنجاح', state: ToastStates.SUCCESS);
     navigatePop(context);
    }

    emit(ChangeChooseState());
  }
  void cheekPerson(BuildContext context,GameModel gameModel) {
    if (key.currentState!.validate()) {
      showToast(text: 'تم تعديل البيانات بنجاح', state: ToastStates.SUCCESS);

      upDataGame(
          gameModel,
          gameNameController.text,
          ageController.text,
          describeController.text,
          gameOrderController.text,
          amiController.text,
          notesController.text,
          gameModel.createdAt,
          number3Controller.text,
          number4Controller.text,
          emailController.text,
      );
      navigateAndFinish(context,const TabScreen());

    } else {
      showToast(text: 'لازم تملئ كل البيانات', state: ToastStates.ERROR);
    }
    emit(ChangeChooseState());
  }

  void cheekAppoint(BuildContext context,AppointmentModel gameModel) {
    if (key.currentState!.validate()) {
      showToast(text: 'الحساب اليوم تم تحديثه', state: ToastStates.SUCCESS);

      upDataAppointment(
          gameModel,
         kadmaNumber.text,
          timePerDay,
        totalController.text,
      );
      navigateAndFinish(context,const TabScreen());

    } else {
      showToast(text: 'لازم تملئ كل البيانات', state: ToastStates.ERROR);
    }
    emit(ChangeChooseState());
  }

  void cheekGame(BuildContext context) {
    if (key.currentState!.validate()) {
      showToast(text: 'تم اضافه شخص بنجاح', state: ToastStates.SUCCESS);
      sendGame();

      navigateAndFinish(context,const TabScreen());

    } else {
      showToast(text: 'لازم تملئ كل البيانات', state: ToastStates.ERROR);
    }
    emit(ChangeChooseState());
  }
  void sendGame() {

    GameModel model = GameModel(
      ageSuitable:ageController.text.trim(),
      description:describeController.text.trim() ,
      gameIma:amiController.text.trim() ,
      nameGame: gameNameController.text.trim(),
      notes:notesController.text.trim()  ,
      requirement:gameOrderController.text.trim() ,
      email: emailController.text.trim(),
      number3:number3Controller.text.trim() ,
      number4: number4Controller.text.trim(),

      createdAt: Timestamp.now().toString(),
      id: '',
      delete: false
    );
    FirebaseFirestore.instance.collection('Game').add(model.toMap())
        .then((value) {
      FirebaseFirestore.instance.collection('Game').doc(value.id).update(
          {'id':value.id }
      );
      //sendNotification(receiverId, 'أرسل رسالة لك ${userModel!.userName}', text);
      emptyFields();
      emit(SendGameSuccessState());
    }).catchError((error) {
      // print('falseeeeeeeeeeee');
      // emit(SendGameErrorState());
    });
  }

  List<GameModel> games = [];


  void getGame() {
    FirebaseFirestore.instance
        .collection('Game')
        .orderBy('createdAt', descending: true)
        .snapshots()
        .listen((event) {
      games = [];
      for (var element in event.docs) {
        if(element['delete']==false)
        {games.add(GameModel.fromJson(element.data()));}

      }
      emit(GetMessagesSuccessState());
    });

  }
  List<GameModel> gamesDelete = [];
  void getGameDelete() {
    FirebaseFirestore.instance
        .collection('Game')
        .orderBy('createdAt', descending: true)
        .snapshots()
        .listen((event) {
      gamesDelete = [];
      for (var element in event.docs) {
        if(element['delete']==true)
          {gamesDelete.add(GameModel.fromJson(element.data()));}
      }
      emit(GetMessagesSuccessState());
    });

  }

  void sendAppointment() {

    AppointmentModel model = AppointmentModel(
      namekhadma: kadmaNumber.text.trim(),
      total: totalController.text.trim(),
      data: timePerDay,
      createdAt: Timestamp.now().toString(),
      id: '',
      delete: false
    );
    FirebaseFirestore.instance.collection('Appointment').add(model.toMap())
        .then((value) {
      FirebaseFirestore.instance.collection('Appointment').doc(value.id).update(
          {'id':value.id }
      );
      //sendNotification(receiverId, 'أرسل رسالة لك ${userModel!.userName}', text);

      emptyFields();
      emit(SendGameSuccessState());
    }).catchError((error) {
      // print('falseeeeeeeeeeee');
      // emit(SendGameErrorState());
    });
  }

  List<AppointmentModel> appointment = [];

  void getAppointment() {
    FirebaseFirestore.instance
        .collection('Appointment')
        .orderBy('createdAt', descending: true)
        .snapshots()
        .listen((event) {
      appointment = [];
      for (var element in event.docs) {
        if(element['delete']==false)
        {appointment.add(AppointmentModel.fromJson(element.data()));}
      }
      emit(GetMessagesSuccessState());
    });

  }
  List<AppointmentModel> appointmentDelete = [];
  void getAppointmentDelete() {
    FirebaseFirestore.instance
        .collection('Appointment')
        .orderBy('createdAt', descending: true)
        .snapshots()
        .listen((event) {
      appointmentDelete = [];
      for (var element in event.docs) {
        if(element['delete']==true)
          {appointmentDelete.add(AppointmentModel.fromJson(element.data()));}
      }
      emit(GetAppointmentDeleteSuccessState());
    });

  }

  void upDataAppointment(AppointmentModel model,acount,data,total) {
    FirebaseFirestore.instance
        .collection('Appointment')
        .snapshots()
        .listen((event) {
      for (var element in event.docs) {

        if(element['data']==model.data)
        {
          emit(UpDateWaitingGameState());
          FirebaseFirestore.instance.collection('Appointment').doc(element.id).update({
            'namekhadma': acount,
            'total': total,
            'data': data,
          });
          emit(UpDateGameState());

        }
      }
    });



  }


  void upDataGame(GameModel model,nameGame,ageSuitable,description,requirement,gameIma,notes,createdAt,number3,number4,email) {
    FirebaseFirestore.instance
        .collection('Game')
        .snapshots()
        .listen((event) {
      for (var element in event.docs) {

        if(element['nameGame']==model.nameGame)
          {
            emit(UpDateWaitingGameState());
            FirebaseFirestore.instance.collection('Game').doc(element.id).update({
              'nameGame': nameGame,
              'ageSuitable': ageSuitable,
              'description': description,
              'requirement': requirement,
              'gameIma': gameIma,
              'notes': notes,
              'number3': number3,
              'number4': number4,
              'email': email,
              'createdAt': createdAt,
            });
            emit(UpDateGameState());

          }
      }
    });

  }

  void holdData(GameModel gameModel){
    ageController.text=gameModel.ageSuitable;
    gameNameController.text=gameModel.nameGame;
    describeController.text=gameModel.description;
    gameOrderController.text=gameModel.requirement;
    amiController.text=gameModel.gameIma;
    notesController.text=gameModel.notes;
    number3Controller.text=gameModel.number3;
    number4Controller.text=gameModel.number4;
    emailController.text=gameModel.email;
    emit(HoldDataState());
  }
  void holdAppointment(AppointmentModel gameModel){
    kadmaNumber.text=gameModel.namekhadma;
    timePerDay=gameModel.data.toString();
    totalController.text=gameModel.total;
    emit(HoldDataState());
  }

  void deleteGame(String id) {
    FirebaseFirestore.instance.collection('Game').doc(id).delete();

  }
  void trashGame(String id) {
    FirebaseFirestore.instance.collection('Game').doc(id).update({
      'delete': true,
    });
  }
  void returnTrashGame(String id) {
    FirebaseFirestore.instance.collection('Game').doc(id).update({
      'delete': false,
    });

  }

  void deleteAppointment(String id) {
    FirebaseFirestore.instance.collection('Appointment').doc(id).delete();
  }


  void trashAppointment(String id) {
    FirebaseFirestore.instance.collection('Appointment').doc(id).update({
      'delete': true,
    });
  }
  void returnTrashAppointment(String id) {
    FirebaseFirestore.instance.collection('Appointment').doc(id).update({
      'delete': false,
    });

  }



  searchAboutGame(value) {
    List<GameModel> searchUsers = [];
    searchUsers = games.where((element) {
      var searchItem = element.nameGame.toLowerCase()+ element.gameIma.toUpperCase()+element.notes.toUpperCase();
      return searchItem.contains(value.toString().toLowerCase());
    }).toList();
    games = [];
    games = searchUsers;
    emit(SearchAboutGameState());
  }

  searchAboutAppointment(value) {
    List<AppointmentModel> searchUsers = [];
    searchUsers = appointment.where((element) {
      var searchItem = element.data.toLowerCase()+element.namekhadma.toLowerCase();
      return searchItem.contains(value.toString().toLowerCase());
    }).toList();
    appointment = [];
    appointment = searchUsers;
    emit(SearchAboutAppointmentState());
  }
 String password='';
  void getPassword()
  {
    FirebaseFirestore.instance.collection('Password').doc('wML7MozoM591KWDh5wef').get().then((value) {
      password='';
      password= value['Password'];
      print(value['Passsword']);
      print(value);

    });
    emit(GetPasswordState());
  }
  int total=0;
  void getTotal(){
     FirebaseFirestore.instance
        .collection('Appointment')
        .limit(1)
        .get()
        .then((value) async {
         total=0;
      if (value.size != 0) {
        FirebaseFirestore.instance
            .collection('Appointment')
            .snapshots()
            .listen((event) {
          for (var element in event.docs) {
               if(element['delete']==false)
            {total+=int.parse(element['total']);}

          }
          emit(IsTotalSuccessState());
        });
      }
      else {
        total=0;
      }
      emit(IsTotalSuccessState());
    });
  }

  void upDataPassword(String password) {
    FirebaseFirestore.instance.collection('Password').doc('wML7MozoM591KWDh5wef').update({
      'Password': password,
    }).then((value) {
      emit(UpDataPassword());
      print('password');
    });


  }

}
