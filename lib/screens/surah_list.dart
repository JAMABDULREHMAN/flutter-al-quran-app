import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:quran_app/screens/ayah_list.dart';
import '../providers/providers.dart';
import '../constants/my_colors.dart'; // Assuming you have custom colors defined here

class SurahList extends ConsumerWidget {
  const SurahList({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final surahsAsyncValue = ref.watch(surahsProvider);

    return Scaffold(
      body: surahsAsyncValue.when(
        data: (surahs) {
          return ListView.builder(
            itemCount: surahs.length,
            itemBuilder: (context, index) {
              final surah = surahs[index];
              return Card(
                margin: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                child: ListTile(
                  contentPadding: const EdgeInsets.all(10.0),
                  title: Text(
                    surah['englishName'],
                    style: GoogleFonts.montserrat().copyWith(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: customDarkGreen,
                    ),
                  ),
                  subtitle: Text(
                    surah['name'],
                    style: const TextStyle(
                      fontFamily: 'Amiri',
                      fontSize: 16,
                      color: Colors.black87,
                    ),
                  ),
                  trailing: Icon(
                    Icons.arrow_forward_ios,
                    color: customDarkGreen,
                  ),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                            AyahList(surahNumber: surah['number']),
                      ),
                    );
                  },
                ),
              );
            },
          );
        },
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, stackTrace) => Center(child: Text('Error: $error')),
      ),
    );
  }
}
