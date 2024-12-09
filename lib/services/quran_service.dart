import 'dart:convert';
import 'package:http/http.dart' as http;

class QuranService {
  final String baseUrl = 'http://api.alquran.cloud/v1';

  Future<List<dynamic>> getSurahs() async {
    final response = await http.get(Uri.parse('$baseUrl/surah'));
    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      return data['data'];
    } else {
      throw Exception('Failed to load surahs');
    }
  }

  Future<List<dynamic>> getAyahs(int surahNumber) async {
    final response = await http.get(Uri.parse('$baseUrl/surah/$surahNumber'));
    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      return data['data']['ayahs'];
    } else {
      throw Exception('Failed to load ayahs');
    }
  }
}
