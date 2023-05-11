import 'package:bloc_app/blocs/workout_cubit.dart';
import 'package:bloc_app/blocs/workouts_cubit.dart';
import 'package:bloc_app/helpers.dart';
import 'package:bloc_app/models/workout.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Workout Time!'),
        actions: [
          IconButton(onPressed: () {}, icon: const Icon(Icons.event_available)),
          IconButton(onPressed: () {}, icon: const Icon(Icons.settings))
        ],
      ),
      body: SingleChildScrollView(
        child: BlocBuilder<WorkoutsCubit, List<Workout>>(
          builder: (context, workouts) => ExpansionPanelList.radio(
            children: workouts
                .map((w) => ExpansionPanelRadio(
                    value: w,
                    headerBuilder: (context, isExpanded) => ListTile(
                          visualDensity: const VisualDensity(
                              horizontal: 0,
                              vertical: VisualDensity.maximumDensity),
                          leading: IconButton(
                              onPressed: (){BlocProvider.of<WorkoutCubit>(context)
                              .editWorkout(w, workouts.indexOf(w));}, 
                              icon: const Icon(Icons.edit)),
                          title: Text(w.title!),
                          trailing: Text(
                            formatTime(w.getTotal(), true),
                            style: const TextStyle(
                              color: Colors.black,
                            ),
                          ),
                        ),
                    body: ListView.builder(
                      itemExtent: 47,
                      shrinkWrap: true,
                      itemCount: w.exercises!.length,
                      itemBuilder: (context, index) => ListTile(
                        onTap: () {},
                        visualDensity: const VisualDensity(
                            horizontal: 0,
                            vertical: VisualDensity.maximumDensity),
                        leading: Text(
                          formatTime(w.exercises![index].prelude!, true),
                          style: const TextStyle(
                            color: Colors.black,
                          ),
                        ),
                        title: Text(w.exercises![index].title!),
                        trailing: Text(
                          formatTime(w.exercises![index].duration!, true),
                          style: const TextStyle(color: Colors.black),
                        ),
                      ),
                    )))
                .toList(),
          ),
        ),
      ),
    );
  }
}
