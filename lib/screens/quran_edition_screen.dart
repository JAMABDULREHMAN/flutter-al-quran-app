// screens/quran_edition_screen.dart
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../providers/providers.dart';

class QuranEditionScreen extends ConsumerWidget {
  final String editionIdentifier;

  const QuranEditionScreen({super.key, required this.editionIdentifier});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final quranEdition = ref.watch(quranEditionProvider(editionIdentifier));

    return Scaffold(
      appBar: AppBar(
        title: Text('Quran Edition: $editionIdentifier'),
        backgroundColor: Colors.green,
      ),
      body: quranEdition.when(
        data: (data) {
          return ListView.builder(
            itemCount: data.length,
            itemBuilder: (context, index) {
              final surah = data[index];
              return ListTile(
                title: Text(surah['englishName']),
                subtitle: Text(surah['name']),
              );
            },
          );
        },
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, stack) => Center(child: Text('Error: $error')),
      ),
    );
  }
}
