import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hydated_bloc_example/Bloc/todo_bloc.dart';
import 'package:hydated_bloc_example/Data/Model/todo_model.dart';
import 'package:hydated_bloc_example/constant.dart';

import '../../Bloc/todo_event.dart';

class TaskViewBuilder extends StatelessWidget {
  final List<TodoModel> tasks;
  const TaskViewBuilder({super.key, required this.tasks});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: tasks.length,
        itemBuilder: (context, index) {
          TodoModel task = tasks[index];
          String time =
              DateTime.parse(task.updatedAt).timeAgo(numericDates: false);

          return Container(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
              margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
              decoration: BoxDecoration(
                  color: Colors.transparent,
                  border: Border.all(color: Colors.white),
                  borderRadius: BorderRadius.circular(16)),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Flexible(
                          child: Text(
                        task.title,
                        style: const TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Colors.white),
                      )),
                      IconButton(
                          onPressed: () {
                            BlocProvider.of<TodoBloc>(context)
                                .add(TodoRemove(task.id));
                          },
                          icon: const Icon(
                            Icons.clear,
                            size: 35,
                            color: Colors.red,
                          ))
                    ],
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Row(
                    children: [
                      Flexible(
                          child: Text(
                        task.description,
                        maxLines: 3,
                        style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w500,
                            color: Colors.grey.shade300),
                      ))
                    ],
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        time,
                        style:
                            const TextStyle(color: Colors.white, fontSize: 14),
                      ),
                      Row(
                        children: [
                          SizedBox(
                            height: 30,
                            width: 30,
                            child: Transform.scale(
                              scale: 1.5,
                              child: Checkbox(
                                  splashRadius: 30,
                                  shape: const CircleBorder(
                                      side: BorderSide(color: Colors.white)),
                                  value: task.isCompleted,
                                  activeColor: Colors.green,
                                  onChanged: (value) {
                                    BlocProvider.of<TodoBloc>(context)
                                        .add(TodoUpdate(task.id, value!));
                                  }),
                            ),
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          Text(
                            task.isCompleted ? "Completed" : "Incomplete",
                            style: const TextStyle(color: Colors.white),
                          )
                        ],
                      )
                    ],
                  )
                ],
              ));
        });
  }
}
