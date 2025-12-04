import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:supabase_flutter/supabase_flutter.dart';

class ResendService {
  Future<void> sendEmail() async {
    try {
      final String apiKey = dotenv.get("Resend_Api_Key");
      final user = await Supabase.instance.client.auth.currentUser;
      String userName = user?.userMetadata?['name'];
      String? to = user?.email;
      final url = Uri.parse('https://api.brevo.com/v3/smtp/email');

      print('mail to $userName ( $to ) form resend with api $apiKey');

      String subject = 'Task complettion update';
      String html =
          '<div><p>Hello $userName</p><h1>Congragulation for completing one task</h1></div>';
      if (apiKey == null) {
        throw Exception("Api key is missing");
      }
      final response = await http.post(
        url,
        headers: {
          'accept': 'application/json',
          'api-key': apiKey,
          'content-type': 'application/json',
        },
        body: jsonEncode({
          'sender': {'name': 'TO-DO', 'email': 'yogeshsri1209@gmail.com'},
          'to': [
            {'email': to}
          ],
          'subject': subject,
          'htmlContent': html,
        }),
      );
      print('email response ${response.body}');
      if (response.statusCode < 400) {
        print("Email sent successfully");
      } else {
        throw Exception("Email not sent");
      }
    } catch (err) {
      print("sending email error $err");
    }
  }
}
