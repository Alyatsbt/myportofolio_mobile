import 'package:flutter/material.dart';
import 'package:myportofolio_mobile/config.dart';
import 'package:myportofolio_mobile/models/project.dart';
import 'package:myportofolio_mobile/widgets/left_drawer.dart';

class ProjectDetailScreen extends StatelessWidget {
  const ProjectDetailScreen({super.key, required this.project});

  final Project project;

  String? get _imageUrl {
    final value = project.thumbnail?.trim() ?? '';
    if (value.isEmpty) return null;
    final uri = Uri.tryParse(value);
    if (uri != null && (uri.scheme == 'http' || uri.scheme == 'https')) {
      return value;
    }
    return Uri.parse(apiBaseUrl).resolve(value).toString();
  }

  @override
  Widget build(BuildContext context) {
    final imageUrl = _imageUrl;
    return Scaffold(
      appBar: AppBar(title: Text(project.title)),
      drawer: const LeftDrawer(),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 760),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (imageUrl != null) ...[
                  ClipRRect(
                    borderRadius: BorderRadius.circular(12),
                    child: Image.network(
                      imageUrl,
                      width: double.infinity,
                      height: 240,
                      fit: BoxFit.cover,
                      errorBuilder: (_, _, _) => Container(
                        height: 180,
                        color: Theme.of(context)
                            .colorScheme
                            .surfaceContainerHighest,
                        alignment: Alignment.center,
                        child: const Icon(
                          Icons.broken_image_outlined,
                          size: 48,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                ],
                Text(
                  project.title,
                  style: Theme.of(context).textTheme.headlineMedium,
                ),
                const SizedBox(height: 12),
                Text(project.description),
                if (project.subtitle.trim().isNotEmpty) ...[
                  const SizedBox(height: 20),
                  Text(
                    'Subtitle',
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                  const SizedBox(height: 4),
                  Text(project.subtitle),
                ],
                if ((project.projectUrl ?? '').trim().isNotEmpty) ...[
                  const SizedBox(height: 20),
                  SelectableText('Project URL: ${project.projectUrl}'),
                ],
                if (project.starCount > 0) ...[
                  const SizedBox(height: 16),
                  Text('Stars: ${project.starCount}'),
                ],
              ],
            ),
          ),
        ),
      ),
    );
  }
}
