import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:quran_app/constants/my_colors.dart';
import 'package:quran_app/providers/providers.dart';

class AyahList extends ConsumerWidget {
  final int surahNumber;

  const AyahList({super.key, required this.surahNumber});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final ayahsAsyncValue = ref.watch(ayahsProvider(surahNumber));

    return Scaffold(
      appBar: AppBar(
        foregroundColor: Colors.white,
        title: Text(
          'Ayahs',
          style: GoogleFonts.montserrat().copyWith(color: Colors.white),
        ),
        backgroundColor: customDarkGreen,
      ),
      body: ayahsAsyncValue.when(
        data: (ayahs) {
          return ListView.builder(
            itemCount: ayahs.length,
            itemBuilder: (context, index) {
              final ayah = ayahs[index];
              return Card(
                color: const Color.fromARGB(255, 214, 255, 215),
                margin: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(
                        ayah['text'],
                        style: const TextStyle(
                          fontFamily: 'Amiri',
                          fontSize: 18,
                          color: Colors.black87,
                          height: 2,
                        ),
                        textAlign: TextAlign.right,
                      ),
                      const SizedBox(height: 2.5),
                      Text(
                        'Ayah',
                        style: GoogleFonts.montserrat().copyWith(
                          fontSize: 14,
                          color: Colors.grey,
                        ),
                        textAlign: TextAlign.left,
                      ),
                    ],
                  ),
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
