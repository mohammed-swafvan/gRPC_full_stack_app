import 'dart:math';

import 'package:flutter/material.dart';
import 'package:protos/protos.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'gRPC',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'gRPC Demo Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  late ClientChannel channel;
  late TodoServiceClient stub;
  Todo? todo;
  bool completed = false;

  @override
  void initState() {
    channel = ClientChannel(
      'localhost',
      port: 8080,
      options: const ChannelOptions(credentials: ChannelCredentials.insecure()),
    );

    stub = TodoServiceClient(channel);
    super.initState();
  }

  Future<void> getTodo() async {
    final id = Random().nextInt(100);
    final todo = await stub.getTodo(
      GetTodoByIdRequest(
        id: id,
        title: "swafvan",
        completed: !completed,
      ),
    );

    setState(() {
      this.todo = todo;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (todo != null)
              Column(
                children: [
                  Text(
                    "id ${todo!.id}",
                    style: Theme.of(context).textTheme.headlineMedium,
                  ),
                  Text(
                    todo!.title,
                    style: Theme.of(context).textTheme.headlineMedium,
                  ),
                  Text(
                    todo!.completed.toString(),
                    style: Theme.of(context).textTheme.headlineMedium,
                  ),
                ],
              )
            else
              Text(
                "Get Todo",
                style: Theme.of(context).textTheme.headlineMedium,
              ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: getTodo,
        tooltip: 'Get Todo',
        child: const Icon(Icons.add),
      ),
    );
  }
}
