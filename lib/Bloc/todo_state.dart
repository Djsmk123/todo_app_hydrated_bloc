import 'package:hydated_bloc_example/Data/Model/todo_model.dart';

sealed class TodoState {}

final class TodoInitial extends TodoState {}

final class TodoStateLoaded extends TodoState {
  final List<TodoModel> task;

  TodoStateLoaded(this.task);
}
