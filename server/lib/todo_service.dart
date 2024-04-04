import 'package:protos/protos.dart';

class TodoService extends TodoServiceBase {
  @override
  Future<Todo> getTodo(ServiceCall call, GetTodoByIdRequest request) async {
    try {
      final todo = Todo(
        id: request.id,
        title: request.title,
        completed: request.completed,
      );
      return todo;
    } catch (e) {
      print('Error occurred while processing request: $e');
      throw Exception();
    }
  }
}
