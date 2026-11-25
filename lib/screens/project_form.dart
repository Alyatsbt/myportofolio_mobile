import 'package:flutter/material.dart';
import 'package:myportofolio_mobile/models/project.dart';
import 'package:myportofolio_mobile/screens/login_screen.dart';
import 'package:myportofolio_mobile/services/api_client.dart';
import 'package:myportofolio_mobile/services/auth_state.dart';
import 'package:myportofolio_mobile/widgets/auth_guard.dart';
import 'package:myportofolio_mobile/widgets/left_drawer.dart';
import 'package:provider/provider.dart';

class ProjectFormPage extends StatefulWidget {
  const ProjectFormPage({super.key});

  @override
  State<ProjectFormPage> createState() => _ProjectFormPageState();
}

class _ProjectFormPageState extends State<ProjectFormPage> {
  final _formKey = GlobalKey<FormState>();
  final _titleController = TextEditingController();
  final _subtitleController = TextEditingController();
  final _descriptionController = TextEditingController();
  final _projectUrlController = TextEditingController();
  final _thumbnailController = TextEditingController();
  bool _submitting = false;

  @override
  void dispose() {
    _titleController.dispose();
    _subtitleController.dispose();
    _descriptionController.dispose();
    _projectUrlController.dispose();
    _thumbnailController.dispose();
    super.dispose();
  }

  String? _validateProjectUrl(String? value) {
    final trimmed = value?.trim() ?? '';
    if (trimmed.isEmpty) return null;
    final uri = Uri.tryParse(trimmed);
    if (uri == null ||
        (uri.scheme != 'http' && uri.scheme != 'https') ||
        uri.host.isEmpty) {
      return 'Masukkan URL lengkap yang diawali http:// atau https://.';
    }
    return null;
  }

  void _showMessage(String message) {
    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(SnackBar(content: Text(message)));
  }

  Future<void> _submit() async {
    if (_submitting || !_formKey.currentState!.validate()) return;
    setState(() => _submitting = true);
    try {
      if (!await ensureLoggedIn(context) || !mounted) return;
      final auth = context.read<AuthState>();
      final token = auth.token;
      if (token == null) return;

      final created = await context.read<ApiClient>().createProject(
        Project(
          title: _titleController.text.trim(),
          subtitle: _subtitleController.text.trim(),
          description: _descriptionController.text.trim(),
          projectUrl: _projectUrlController.text.trim().isEmpty
              ? null
              : _projectUrlController.text.trim(),
          thumbnail: _thumbnailController.text.trim().isEmpty
              ? null
              : _thumbnailController.text.trim(),
        ),
        token: token,
      );
      if (!mounted) return;
      await showDialog<void>(
        context: context,
        builder: (dialogContext) => AlertDialog(
          title: const Text('Project berhasil ditambahkan'),
          content: Text(
            '${created.title}\n${created.subtitle}\n\n${created.description}',
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(dialogContext),
              child: const Text('OK'),
            ),
          ],
        ),
      );
      if (!mounted) return;
      _formKey.currentState!.reset();
      _titleController.clear();
      _subtitleController.clear();
      _descriptionController.clear();
      _projectUrlController.clear();
      _thumbnailController.clear();
    } on ApiException catch (error) {
      if (!mounted) return;
      if (error.statusCode == 400) {
        _showMessage('Server menolak data. Periksa kembali isian form.');
      } else if (error.statusCode == 401) {
        try {
          await context.read<AuthState>().logout();
        } catch (_) {
          // Local authentication state is cleared even when revocation fails.
        }
        if (!mounted) return;
        _showMessage('Sesi berakhir. Login kembali, lalu tekan Save lagi.');
        await Navigator.push<bool>(
          context,
          MaterialPageRoute(builder: (_) => const LoginScreen()),
        );
      } else if (error.statusCode == 403) {
        _showMessage(
          'Hanya portfolio owner (superuser) yang dapat membuat project.',
        );
      } else {
        _showMessage(error.message);
      }
    } catch (_) {
      if (mounted) _showMessage('Tidak dapat terhubung ke server. Coba lagi.');
    } finally {
      if (mounted) setState(() => _submitting = false);
    }
  }

  InputDecoration _decoration(String label) =>
      InputDecoration(labelText: label, border: const OutlineInputBorder());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Add Project Form')),
      drawer: const LeftDrawer(),
      body: Form(
        key: _formKey,
        child: ListView(
          padding: const EdgeInsets.all(16),
          children: [
            TextFormField(
              controller: _titleController,
              decoration: _decoration('Title'),
              maxLength: 255,
              textInputAction: TextInputAction.next,
              validator: (value) => value == null || value.trim().isEmpty
                  ? 'Title wajib diisi.'
                  : null,
            ),
            const SizedBox(height: 14),
            TextFormField(
              controller: _subtitleController,
              decoration: _decoration('Subtitle'),
              maxLength: 255,
              textInputAction: TextInputAction.next,
              validator: (value) => value == null || value.trim().isEmpty
                  ? 'Subtitle wajib diisi.'
                  : null,
            ),
            const SizedBox(height: 14),
            TextFormField(
              controller: _descriptionController,
              maxLines: 4,
              decoration: _decoration('Description'),
              validator: (value) => value == null || value.trim().isEmpty
                  ? 'Description wajib diisi.'
                  : null,
            ),
            const SizedBox(height: 14),
            TextFormField(
              controller: _projectUrlController,
              decoration: _decoration('Project URL (optional)'),
              maxLength: 200,
              keyboardType: TextInputType.url,
              validator: _validateProjectUrl,
            ),
            const SizedBox(height: 14),
            TextFormField(
              controller: _thumbnailController,
              decoration: _decoration('Thumbnail path or URL (optional)'),
              maxLength: 255,
              textInputAction: TextInputAction.done,
            ),
            const SizedBox(height: 20),
            FilledButton.icon(
              onPressed: _submitting ? null : _submit,
              icon: _submitting
                  ? const SizedBox.square(
                      dimension: 18,
                      child: CircularProgressIndicator(strokeWidth: 2),
                    )
                  : const Icon(Icons.save_outlined),
              label: Text(_submitting ? 'Saving...' : 'Save'),
            ),
          ],
        ),
      ),
    );
  }
}
