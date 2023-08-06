import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hydated_bloc_example/Bloc/todo_bloc.dart';
import 'package:hydated_bloc_example/Bloc/todo_state.dart';
import 'package:hydated_bloc_example/UI/Views/todo_add_screen.dart';
import 'package:hydated_bloc_example/UI/Widgets/widgets.dart';

class TodoScreen extends StatefulWidget {
  const TodoScreen({super.key});

  @override
  State<TodoScreen> createState() => _TodoScreenState();
}

class _TodoScreenState extends State<TodoScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Todo Screen Example"),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            showDialog(
                context: context,
                builder: (context) => const AlertDialog(
                      content: TodoAddScreen(),
                    ));
          },
          child: const Icon(Icons.add),
        ),
        body: bodyWidget());
  }

  Widget bodyWidget() {
    return BlocBuilder<TodoBloc, TodoState>(
      builder: (context, state) {
        if (state is TodoStateLoaded) {
          return state.task.isEmpty
              ? const EmptyListWidget()
              : TaskViewBuilder(tasks: state.task);
        }

        return const EmptyListWidget();
      },
    );
  }
}
