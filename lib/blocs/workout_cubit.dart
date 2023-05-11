import 'package:bloc_app/models/workout.dart';
import 'package:bloc_app/states/workout_states.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class WorkoutCubit extends Cubit<WorkoutState>{
  WorkoutCubit():super(const WorkoutInitial());

  editWorkout(Workout workout, int index) 
  => emit(WorkoutEditing(workout, index, null));

  editExercise(int? exIndex) {
    emit(WorkoutEditing(state.workout,(state as WorkoutEditing).index,exIndex!));
  }

  goHome()=>emit(const WorkoutInitial());

}