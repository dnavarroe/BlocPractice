import 'dart:ui';

import 'package:bloc_app/blocs/workout_cubit.dart';
import 'package:bloc_app/blocs/workouts_cubit.dart';
import 'package:bloc_app/models/workout.dart';
import 'package:bloc_app/screens/edit_workout_page.dart';
import 'package:bloc_app/screens/home_page.dart';
import 'package:bloc_app/states/workout_states.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:path_provider/path_provider.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final storage = await HydratedStorage.build(
    storageDirectory: await getApplicationDocumentsDirectory()
  );
  HydratedBlocOverrides.runZoned(
    () => runApp(const WorkoutTime()),
    storage: storage
  );
}


class WorkoutTime extends StatelessWidget {
  const WorkoutTime({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Workouts',
      theme: ThemeData(
        primaryColor: Colors.amber,
        textTheme: const TextTheme(
          bodyText2: TextStyle(color: Color.fromARGB(155, 66, 74, 9))
        )
      ),
      home: MultiBlocProvider(
        providers: [
          BlocProvider<WorkoutsCubit>(
            create: (context){
              WorkoutsCubit workoutsCubit =  WorkoutsCubit();
              if(workoutsCubit.state.isEmpty){
                workoutsCubit.getWorkouts();
              }
              return workoutsCubit;
            }
          ),
          BlocProvider<WorkoutCubit>(
            create: (context)=>WorkoutCubit(),
          )
        ],
        child: BlocBuilder<WorkoutCubit, WorkoutState>(
          builder: (context, state) {
            if(state is WorkoutInitial){
              return const HomePage();
            }else if(state is WorkoutEditing){
              return const EditWorkoutPage();
            }
            return Container();
          },
        ),
      )
    );
  }
}