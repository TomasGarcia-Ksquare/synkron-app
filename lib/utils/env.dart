import 'package:flutter_dotenv/flutter_dotenv.dart';

//This function is used to load the environment file in the application.
//It takes a required parameter 'path' which is the path of the .env file.
//It returns a Future object of Map<String, String> that contains the key-value pairs of the environment variables.
//It uses the flutter_dotenv package to load the file and access the variables.
Future<Map<String, String>> loadEnvFile(String path) async {
  await dotenv.load(fileName: path);
  return dotenv.env;
}
