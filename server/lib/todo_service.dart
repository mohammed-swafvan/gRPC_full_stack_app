import 'package:protos/protos.dart';

class TodoService extends TodoServiceBase {
  @override
  Future<Todo> getTodo(ServiceCall call, GetTodoByIdRequest request) async {
    try {
      final id = request.id;

      final todo = Todo(
        id: id,
        title: 'title $id',
        completed: false,
      );

      return todo;
    } catch (e) {
      print('Error occurred while processing request: $e');
      throw Exception();
    }
  }
}
