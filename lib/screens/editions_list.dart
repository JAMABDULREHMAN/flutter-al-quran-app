import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:quran_app/constants/my_colors.dart';
import '../providers/providers.dart';
import 'juz_screen.dart';

class EditionsList extends ConsumerWidget {
  final Map<String, String>? params;

  const EditionsList({super.key, this.params});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final editions = params != null
        ? ref.watch(filteredEditionsProvider(params!))
        : ref.watch(allEditionsProvider);

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Editions List',
          style: GoogleFonts.montserrat(),
        ),
        backgroundColor: customDarkGreen,
        foregroundColor: Colors.white,
      ),
      body: editions.when(
        data: (data) {
          if (data.isEmpty) {
            return Center(
                child: Text(
              'Oops, sorry no results on this filter.',
              style: GoogleFonts.montserrat(),
            ));
          }
          return ListView.builder(
            itemCount: data.length,
            itemBuilder: (context, index) {
              final edition = data[index];
              return ListTile(
                title: Text(edition['englishName']),
                subtitle: Text(edition['name']),
                onTap: () {
                  showDialog(
                    context: context,
                    builder: (context) => AlertDialog(
                      title: const Text('Select Juz'),
                      content: TextField(
                        keyboardType: TextInputType.number,
                        decoration: const InputDecoration(
                          labelText: 'Enter Juz Number (1-30)',
                        ),
                        onSubmitted: (value) {
                          final juzNumber = int.tryParse(value);
                          if (juzNumber != null &&
                              juzNumber > 0 &&
                              juzNumber <= 30) {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => JuzScreen(
                                  editionIdentifier: edition['identifier'],
                                  juzNumber: juzNumber,
                                ),
                              ),
                            );
                          } else {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text(
                                    'Please enter a valid Juz number (1-30).'),
                              ),
                            );
                          }
                        },
                      ),
                    ),
                  );
                },
              );
            },
          );
        },
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, stack) {
          WidgetsBinding.instance.addPostFrameCallback((_) {
            showDialog(
              context: context,
              builder: (context) => AlertDialog(
                title: Text(
                  'Oops, sorry no results on this filter.',
                  style: GoogleFonts.montserrat(),
                ),
                content: Text(
                  'Nothing Found for this Filter.',
                  style: GoogleFonts.montserrat(),
                ),
                actions: [
                  TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                      Navigator.popUntil(context, ModalRoute.withName('/'));
                    },
                    child: Text(
                      'OK',
                      style: GoogleFonts.montserrat()
                          .copyWith(color: Colors.white),
                    ),
                  ),
                ],
              ),
            );
          });
          return const Center(child: CircularProgressIndicator());
        },
      ),
    );
  }
}
