import 'package:hydated_bloc_example/Bloc/todo_event.dart';
import 'package:hydated_bloc_example/Bloc/todo_state.dart';
import 'package:hydated_bloc_example/Data/Model/todo_model.dart';
import 'package:hydated_bloc_example/Data/Repo/todo_repo.dart';
import 'package:hydated_bloc_example/UI/Widgets/fake_loading.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';

class TodoBloc extends HydratedBloc<TodoEvent, TodoState> {
  final TodoRepo todoRepo = TodoRepo();
  TodoBloc() : super(TodoInitial()) {
    on<TodoFetch>((event, emit) async {
      emit(TodoStateLoaded(todoRepo.tasks));
    });
    on<TodoAdd>((event, emit) async {
      await fakeLoading();
      emit(TodoStateLoaded(todoRepo.addTodo(event.task)));
    });
    on<TodoRemove>((event, emit) async {
      await fakeLoading();
      emit(TodoStateLoaded(todoRepo.removeTodo(event.id)));
    });
    on<TodoUpdate>((event, emit) async {
      await fakeLoading();
      emit(TodoStateLoaded(todoRepo.updateTask(event.id, event.status)));
    });
  }

  @override
  TodoState? fromJson(Map<String, dynamic> json) {
    if (json['data'] != null && (json['data'] as List<dynamic>).isNotEmpty) {
      return TodoStateLoaded((json['data'] as List<dynamic>)
          .map((e) => TodoModel.fromJson(e))
          .toList());
    }
    return TodoInitial();
  }

  @override
  Map<String, dynamic>? toJson(TodoState state) {
    if (state is TodoStateLoaded) {
      return {'data': state.task.map((e) => e.toJson()).toList()};
    }
    return {'data': []};
  }
}
