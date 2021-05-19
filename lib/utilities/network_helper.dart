import 'package:http/http.dart' as http;
import 'dart:convert';


  Future getData() async {
    var url = Uri.parse('https://example.com/whatsit/create');
    var response = await http.post(url, body: {'name': 'doodle', 'color': 'blue'});
    print('Response status: ${response.statusCode}');
    print('Response body: ${response.body}');

  }

