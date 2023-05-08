import 'dart:ui';

import 'package:bloc_app/blocs/workouts_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() {
  ()=>runApp(const WorkoutTime());
}

class WorkoutTime extends StatelessWidget {
  const WorkoutTime({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Workouts',
      theme: ThemeData(
        primaryColor: Colors.amber,
        textTheme: const TextTheme(
          bodyText2: TextStyle(color: Color.fromARGB(155, 66, 74, 9))
        )
      ),
      home: BlocProvider<WorkoutsCubit>(
        create: (context){
           WorkoutsCubit workoutsCubit =  WorkoutsCubit();
           if(workoutsCubit.state.isEmpty){
              workoutsCubit.getWorkouts();
           }
          return workoutsCubit;
        },
      ),
    );
  }
}