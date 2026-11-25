import 'package:flutter/material.dart';
import 'package:myportofolio_mobile/models/item_homepage.dart';
import 'package:myportofolio_mobile/screens/experience_form.dart';
import 'package:myportofolio_mobile/screens/login_screen.dart';
import 'package:myportofolio_mobile/screens/project_form.dart';
import 'package:myportofolio_mobile/screens/project_list_screen.dart';
import 'package:myportofolio_mobile/services/auth_state.dart';
import 'package:myportofolio_mobile/widgets/auth_guard.dart';
import 'package:myportofolio_mobile/widgets/left_drawer.dart';
import 'package:myportofolio_mobile/widgets/project_card.dart';
import 'package:provider/provider.dart';

class MyHomePage extends StatelessWidget {
  MyHomePage({super.key});

  final String npm = '2506620192';
  final String nama = 'Alya Tsabita Imani';
  final String kelas = 'PBP A';

  final List<ItemHomepage> items = [
    ItemHomepage('View Projects', Icons.folder, Colors.blue),
    ItemHomepage('Add Project', Icons.add_circle, Colors.cyan),
    ItemHomepage(
      'Add Experience',
      Icons.add_circle,
      const Color.fromARGB(255, 78, 205, 144),
    ),
  ];

  Future<void> _handleItemTap(BuildContext context, ItemHomepage item) async {
    final navigator = Navigator.of(context);
    if (item.name == 'View Projects') {
      await navigator.push<void>(
        MaterialPageRoute<void>(builder: (_) => const ProjectListScreen()),
      );
    } else if (item.name == 'Add Project') {
      if (!await ensureLoggedIn(context) || !context.mounted) return;
      await navigator.push<void>(
        MaterialPageRoute<void>(builder: (_) => const ProjectFormPage()),
      );
    } else if (item.name == 'Add Experience') {
      await navigator.push<void>(
        MaterialPageRoute<void>(builder: (_) => const ExperienceFormPage()),
      );
    }
  }

  Future<void> _handleAuth(BuildContext context, bool isLoggedIn) async {
    if (!isLoggedIn) {
      await Navigator.push<bool>(
        context,
        MaterialPageRoute(builder: (_) => const LoginScreen()),
      );
      return;
    }
    try {
      await context.read<AuthState>().logout();
      if (context.mounted) {
        ScaffoldMessenger.of(context)
            .showSnackBar(const SnackBar(content: Text('Logout berhasil.')));
      }
    } catch (_) {
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text(
              'Logout lokal berhasil, tetapi server tidak dapat dihubungi.',
            ),
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final isLoggedIn = context.watch<AuthState>().isLoggedIn;
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'MyPortfolio',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        backgroundColor: Theme.of(context).colorScheme.primary,
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      drawer: const LeftDrawer(),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                InfoCard(title: 'NPM', content: npm),
                InfoCard(title: 'Name', content: nama),
                InfoCard(title: 'Class', content: kelas),
              ],
            ),
            const SizedBox(height: 16),
            const Padding(
              padding: EdgeInsets.only(top: 16),
              child: Text(
                'Selamat datang di MyPortfolio Mobile!',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                textAlign: TextAlign.center,
              ),
            ),
            GridView.count(
              primary: false,
              padding: const EdgeInsets.all(20),
              crossAxisSpacing: 10,
              mainAxisSpacing: 10,
              crossAxisCount: 2,
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              children: [
                for (final item in items)
                  ItemCard(item, onTap: () => _handleItemTap(context, item)),
                ItemCard(
                  ItemHomepage(
                    isLoggedIn ? 'Logout' : 'Login',
                    isLoggedIn ? Icons.logout : Icons.login,
                    Colors.red,
                  ),
                  onTap: () => _handleAuth(context, isLoggedIn),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class InfoCard extends StatelessWidget {
  const InfoCard({super.key, required this.title, required this.content});

  final String title;
  final String content;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Card(
        elevation: 2,
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Column(
            children: [
              Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
              const SizedBox(height: 8),
              Text(content, textAlign: TextAlign.center),
            ],
          ),
        ),
      ),
    );
  }
}
