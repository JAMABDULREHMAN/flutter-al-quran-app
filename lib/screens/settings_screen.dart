import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:quran_app/constants/my_colors.dart';
import 'package:quran_app/providers/providers.dart';
import 'editions_list.dart';

class SettingsScreen extends ConsumerWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final AsyncValue<List<String>> languages = ref.watch(languagesProvider);
    final AsyncValue<List<String>> types = ref.watch(typesProvider);
    final String selectedLanguage = ref.watch(selectedLanguageProvider);
    final String selectedType = ref.watch(selectedTypeProvider);

    return Scaffold(
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.5,
              child: Image.asset(
                'assets/quran_editions.jfif',
                fit: BoxFit.fitWidth,
              ),
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                languages.when(
                  data: (data) {
                    return Expanded(
                      child: Card(
                        margin: const EdgeInsets.symmetric(horizontal: 4),
                        elevation: 4,
                        child: DropdownButtonFormField<String>(
                          decoration: InputDecoration(
                            contentPadding: const EdgeInsets.all(2.5),
                            filled: true,
                            fillColor: Colors.white,
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8),
                              borderSide: BorderSide.none,
                            ),
                          ),
                          hint: Text(
                            'Select Language',
                            style: GoogleFonts.montserrat().copyWith(
                                fontSize: 14, fontWeight: FontWeight.bold),
                          ),
                          value: selectedLanguage.isEmpty
                              ? null
                              : selectedLanguage,
                          onChanged: (value) {
                            ref.read(selectedLanguageProvider.notifier).state =
                                value!;
                          },
                          items: data.map((lang) {
                            return DropdownMenuItem<String>(
                              value: lang,
                              child: Text(lang),
                            );
                          }).toList(),
                        ),
                      ),
                    );
                  },
                  loading: () => const CircularProgressIndicator(),
                  error: (error, stack) => Text('Error: $error'),
                ),
                const SizedBox(width: 10),
                types.when(
                  data: (data) {
                    return Expanded(
                      child: Card(
                        margin: const EdgeInsets.symmetric(horizontal: 8),
                        elevation: 4,
                        child: DropdownButtonFormField<String>(
                          decoration: InputDecoration(
                            contentPadding: const EdgeInsets.all(8),
                            filled: true,
                            fillColor: Colors.white,
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8),
                              borderSide: BorderSide.none,
                            ),
                          ),
                          hint: Text(
                            'Select Type',
                            style: GoogleFonts.montserrat().copyWith(
                                fontSize: 16, fontWeight: FontWeight.bold),
                          ),
                          value: selectedType.isEmpty ? null : selectedType,
                          onChanged: (value) {
                            ref.read(selectedTypeProvider.notifier).state =
                                value!;
                          },
                          items: data.map((type) {
                            return DropdownMenuItem<String>(
                              value: type,
                              child: Text(type),
                            );
                          }).toList(),
                        ),
                      ),
                    );
                  },
                  loading: () => const CircularProgressIndicator(),
                  error: (error, stack) => Text('Error: $error'),
                ),
              ],
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                if (selectedLanguage.isEmpty && selectedType.isEmpty) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(
                        'Please select both language and type.',
                        style: GoogleFonts.montserrat()
                            .copyWith(color: customDarkGreen),
                      ),
                      backgroundColor: const Color.fromARGB(255, 198, 255, 200),
                    ),
                  );
                } else {
                  final params = {
                    'language': selectedLanguage,
                    'type': selectedType,
                  };
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => EditionsList(params: params),
                    ),
                  );
                }
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: customDarkGreen,
                foregroundColor: Colors.white,
                padding:
                    const EdgeInsets.symmetric(horizontal: 32, vertical: 12),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              child: Text(
                'Filtered Editions List',
                style: GoogleFonts.montserrat().copyWith(fontSize: 16),
              ),
            ),
            const SizedBox(height: 10),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const EditionsList(params: null),
                  ),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: customDarkGreen,
                foregroundColor: Colors.white,
                padding:
                    const EdgeInsets.symmetric(horizontal: 32, vertical: 12),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              child: Text(
                'Unfiltered Editions List',
                style: GoogleFonts.montserrat().copyWith(fontSize: 16),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
