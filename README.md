Quench your app's thirst with the magic of Flutter and the power of "Hydrated Bloc" - the ultimate elixir to keep your application state hydrated and happy! 🧊💧

"Hydrated Bloc" simplifies state persistence in Flutter, making it effortless to store and restore your app's state. Say goodbye to manual state serialization and deserialization – this nifty extension takes care of it all! With Hydrated Bloc, you can focus on crafting your app's features and delighting your users without worrying about state management complexities.

## What is Hydrated Bloc and How Does it Work?

Hydrated Bloc is a powerful extension built on top of the bloc package in Flutter. It automates the process of state persistence and restoration, making it easy to maintain your app's state across different sessions. When you create a `BlocProvider`, Hydrated Bloc automatically leverages the `fromJson` method to retrieve the stored state from the local storage.

Whenever the bloc's state changes, the `toJson` method comes into play. It converts the current state into a `Map<String, dynamic>` format, which is then stored in the local storage. This ensures that your app's state is always up-to-date and ready to be restored when needed, even if the app is closed or the user navigates between screens.

Hydrated Bloc streamlines the process of state persistence, preventing the hassle of handling manual serialization and deserialization. By automating state management, it enhances your app's reliability and eliminates the risk of state loss.


## Benefits of Hydrated Bloc Over Traditional Bloc

|            | **Hydrated Bloc**                                  | **Bloc**                                        |
|------------|----------------------------------------------------|-------------------------------------------------|
| **State Persistence** | Automates state persistence and restoration.       | Manual state serialization and deserialization. |
| **Package Dependency** | Built as an extension to package:bloc.            | Directly uses package:bloc.                    |
| **Complexity**        | Simplifies state management with automatic persistence. | Requires additional handling for state persistence.  |
| **Initialization**    | HydratedBloc initializes from stored state if available. | Bloc starts with initial state on each launch.  |
| **Storage**           | Utilizes local storage(`hive`[No SQL]) to persist the states.    | No built-in state storage, left to developers.  |
| **App Reliability**   | Enhances app reliability by preventing state loss. | Prone to state loss if not handled properly.     |


## Getting Started with Hydrated Bloc
Using Hydrated Bloc is a breeze! You have two options to get started:
- By Extending: You can use Hydrated Bloc by extending the existing bloc class.
```
sealed class CounterEvent {}
final class CounterIncrementPressed extends CounterEvent {}

class CounterBloc extends HydratedBloc<CounterEvent, int> {
  CounterBloc() : super(0) {
    on<CounterIncrementPressed>((event, emit) => emit(state + 1));
  }

  @override
  int fromJson(Map<String, dynamic> json) => json['value'] as int;

  @override
  Map<String, int> toJson(int state) => { 'value': state };
}

```
- Using HydratedMixin:

```
class CounterBloc extends Bloc<CounterEvent, int> with HydratedMixin {
  CounterBloc() : super(0) {
    on<CounterIncrementPressed>((event, emit) => emit(state + 1));
  }

  @override
  int fromJson(Map<String, dynamic> json) => json['value'] as int;

  @override
  Map<String, int> toJson(int state) => { 'value': state };
}

```
To access and manipulate the storage object in Hydrated Bloc, follow these steps:

- Create a custom storage class by extending the `Storage` class.
```
class MyHydratedStorage implements Storage {
  @override
  dynamic read(String key) {
    // TODO: implement read
  }

  @override
  Future<void> write(String key, dynamic value) async {
    // TODO: implement write
  }

  @override
  Future<void> delete(String key) async {
    // TODO: implement delete
  }

  @override
  Future<void> clear() async {
    // TODO: implement clear
  }
}

```
- Set the custom storage implementation:

```
HydratedBloc.storage = MyHydratedStorage();
```

Inside the custom storage class, you can implement methods to read, write, delete, and clear data. These methods allow you to interact with the local storage and manage data for the Hydrated Bloc.

## Let's Create a Simple To-Do Application

- Create a Flutter project and add the required dependencies to your `pubspec.yaml` file.


```
dependencies:
  hydrated_bloc: ^9.1.2  //hydrated bloc
  path_provider: ^2.0.15  // for getTemporaryDirectory
  flutter_easyloading: ^3.0.5 // Helpful for showing loading without context
  flutter_bloc: ^8.1.3 //flutter bloc
```
for more information [`hydrated_bloc`](https://pub.dev/packages/hydrated_bloc)

- Define the To-Do model for JSON serialization.

{% gist https://gist.github.com/Djsmk123/8d8ae7a67c982093f6d63db88de72242.js %}

- Create the Todo repository to manage tasks.

{% gist https://gist.github.com/Djsmk123/1b29755731aab1440171b849f85686a7 %}


- Define the possible states and events for the Todo Bloc.

{% gist https://gist.github.com/Djsmk123/5ece5baebe3758838aaa2debb5c941c3 %}

{% gist https://gist.github.com/Djsmk123/0cccdde78924e7505446083a6049247c %}


- Implement the Todo Bloc with Hydrated Bloc.

{% gist https://gist.github.com/Djsmk123/f2a30ce9abfeaccf9c1a52f4ad18a594 %}

- Initialize the Hydrated Bloc storage in `main.dart`.
```
Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  HydratedBloc.storage = await HydratedStorage.build(
    storageDirectory: kIsWeb
        ? HydratedStorage.webStorageDirectory
        : await getTemporaryDirectory(),
  );
  runApp(const MyApp());
}
```

- Now we are remaining with UI and widgets for that you can create own or refer to [github-repo](https://github.com/Djsmk123/todo_app_hydrated_bloc).

## Various function to manipulate Todo List

- Adding New Todo:
```

 if (formKey.currentState!.validate()) {
BlocProvider.of<TodoBloc>(context).add(TodoAdd(TodoModel.fromJson({
                        'id': DateTime.now().millisecondsSinceEpoch+
                            Random().nextInt(9999999),
                        'title': titleText.text,
                        'description': description.text,
                        'is_completed': false,
                        'created_at': DateTime.now().toUtc().toIso8601String(),
                        'updated_at': DateTime.now().toUtc().toIso8601String()
                      })));
     Navigator.pop(context);
                    }
```

- Update ToDo:

```
BlocProvider.of<TodoBloc>(context).add(TodoUpdate(task.id, value!));

```


- Remove ToDo:

```
BlocProvider.of<TodoBloc>(context).add(TodoRemove(task.id));
```

## OUTPUT

{% youtube uxZSam3Tl-s %}



Certainly! My gratitude goes out to the amazing authors and contributors of the hydrated_bloc package, including [Felix Angelov](https://twitter.com/felangelov)and others, for their brilliant work in developing this powerful tool for state management in Flutter. Thanks to [Felix Angelov](https://twitter.com/felangelov) and the entire team for creating `hydrated_bloc`, which allows developers like us to enjoy the convenience and reliability of automated state persistence and restoration with Hydrated Bloc.

Thank you, [Felix Angelov](https://twitter.com/felangelov), and the entire hydrated_bloc team, for making our lives easier and our apps more robust! 🙏👏


## Source code :
[Github Repo](https://github.com/Djsmk123/todo_app_hydrated_bloc)

## Follow me on

- [Twitter](https://twitter.com/smk_winner)

- [Instagram](https://www.instagram.com/smkwinner/)

- [Github](https://www.github.com/djsmk123)

- [linkedin](https://www.linkedin.com/in/md-mobin-bb928820b/)

- [dev.to](https://dev.to/djsmk123)

- [Medium](https://medium.com/@djsmk123)