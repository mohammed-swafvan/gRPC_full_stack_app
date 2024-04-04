import 'dart:io';

import 'package:protos/protos.dart';

void main(List<String> arguments) async {
  final server = Server.create(
    services: [],
    codecRegistry: CodecRegistry(codecs: const [GzipCodec(), IdentityCodec()]),
  );

  final int port = int.parse(Platform.environment['PORT'] ?? '8080');
  await server.serve(
    port: port,
  );

  print("server listening on port ${server.port}...");
}
