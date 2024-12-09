import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:quran_app/constants/my_colors.dart';
import 'package:quran_app/providers/providers.dart';

class JuzScreen extends ConsumerWidget {
  final String editionIdentifier;
  final int juzNumber;

  const JuzScreen({
    super.key,
    required this.editionIdentifier,
    required this.juzNumber,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final parameter = JuzRequestParameter(
      juzNumber: juzNumber,
      editionIdentifier: editionIdentifier,
    );
    final juzAsyncValue = ref.watch(juzProvider(parameter));

    return Scaffold(
      appBar: AppBar(
        title: Text('Juz $juzNumber'),
        backgroundColor: customDarkGreen,
        foregroundColor: Colors.white,
      ),
      body: juzAsyncValue.when(
        data: (ayahs) {
          return ListView.builder(
            itemCount: ayahs.length,
            itemBuilder: (context, index) {
              final ayah = ayahs[index];
              return Card(
                margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        ayah['text'],
                        style: const TextStyle(
                          fontFamily: 'Amiri',
                          fontSize: 18,
                          color: Colors.black87,
                        ),
                        textAlign: TextAlign.right,
                      ),
                      const SizedBox(height: 8),
                      Text(
                        'Ayah ${ayah['numberInSurah']}',
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.grey[600],
                        ),
                      ),
                      const SizedBox(height: 8),
                      Divider(color: Colors.grey[300]),
                    ],
                  ),
                ),
              );
            },
          );
        },
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, stack) {
          return Center(child: Text('Error: $error'));
        },
      ),
    );
  }
}
