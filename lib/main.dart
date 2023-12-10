import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  build(BuildContext context) {
    return FutureBuilder(
      future: fetchDate(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const MaterialApp(
              home: Scaffold(
                body: Center(
                  child: SizedBox(
                    width: 50.0,
                    height: 50.0,
                    child: CircularProgressIndicator(),
                  ),
                ),
              ),
          );
        } else {
          return MaterialApp(
            home: Scaffold(
              body: Center(
                child: Text(snapshot.data?.message ?? ""),
              ),
            ),
          );
        }
      },
    );
  }
  
  Future<ApiResponse> fetchDate() async {
    final response = await http.get(Uri.parse("https://training-erake-3trpph2t7q-uc.a.run.app"));
    print(response.statusCode);
    if (response.statusCode == 200) {
      return ApiResponse.fromJson(jsonDecode(response.body));
    } else {
      return ApiResponse(message: "error");
    }
  }
}

class ApiResponse {
  final String message;

  ApiResponse({required this.message});

  factory ApiResponse.fromJson(Map<String, dynamic> json) {
    return ApiResponse(
      message: json['message'] ?? '',
    );
  }
}
