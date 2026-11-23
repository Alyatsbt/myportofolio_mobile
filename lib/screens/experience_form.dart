import 'package:flutter/material.dart';
import 'package:myportofolio_mobile/widgets/left_drawer.dart';

class ExperienceFormPage extends StatefulWidget {
  const ExperienceFormPage({super.key});

  @override
  State<ExperienceFormPage> createState() => _ExperienceFormPageState();
}

class _ExperienceFormPageState extends State<ExperienceFormPage> {
  final _formKey = GlobalKey<FormState>();

  final _positionController = TextEditingController();
  final _organizationController = TextEditingController();
  final _descriptionController = TextEditingController();

  DateTime? _startDate;
  DateTime? _endDate;

  String _formatDate(DateTime date) {
    return '${date.day}/${date.month}/${date.year}';
  }

  Future<void> _pickDate(bool isStartDate) async {
    final pickedDate = await showDatePicker(
      context: context,
      initialDate: isStartDate
          ? (_startDate ?? DateTime.now())
          : (_endDate ?? _startDate ?? DateTime.now()),
      firstDate: DateTime(1950),
      lastDate: DateTime(2100),
    );

    if (pickedDate == null) return;

    setState(() {
      if (isStartDate) {
        _startDate = pickedDate;

        if (_endDate != null && _endDate!.isBefore(pickedDate)) {
          _endDate = null;
        }
      } else {
        _endDate = pickedDate;
      }
    });
  }

  void _showSummary() {
    if (!_formKey.currentState!.validate()) return;

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Experience Summary'),
        content: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text('Position: ${_positionController.text}'),
              const SizedBox(height: 8),
              Text('Organization: ${_organizationController.text}'),
              const SizedBox(height: 8),
              Text('Description: ${_descriptionController.text}'),
              const SizedBox(height: 8),
              Text('Start Date: ${_formatDate(_startDate!)}'),
              const SizedBox(height: 8),
              Text(
                'End Date: ${_endDate == null ? "Present" : _formatDate(_endDate!)}',
              ),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _positionController.dispose();
    _organizationController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Experience'),
        backgroundColor: Colors.indigo,
        foregroundColor: Colors.white,
      ),
      drawer: const LeftDrawer(),
      body: Form(
        key: _formKey,
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              TextFormField(
                controller: _positionController,
                decoration: const InputDecoration(
                  labelText: 'Position / Role',
                  hintText: 'e.g. UI/UX Designer',
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'Position cannot be empty';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),

              TextFormField(
                controller: _organizationController,
                decoration: const InputDecoration(
                  labelText: 'Organization / Company',
                  hintText: 'e.g. BEM Fasilkom UI',
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'Organization cannot be empty';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),

              TextFormField(
                controller: _descriptionController,
                maxLines: 4,
                decoration: const InputDecoration(
                  labelText: 'Job Description',
                  hintText: 'Describe your responsibilities...',
                  border: OutlineInputBorder(),
                  alignLabelWithHint: true,
                ),
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'Description cannot be empty';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),

              FormField<DateTime>(
                validator: (value) {
                  if (_startDate == null) {
                    return 'Start date is required';
                  }
                  return null;
                },
                builder: (field) => Padding(
                  padding: const EdgeInsets.only(bottom: 16),
                  child: InkWell(
                    onTap: () async {
                      await _pickDate(true);
                      field.didChange(_startDate);
                    },
                    child: InputDecorator(
                      decoration: InputDecoration(
                        labelText: 'Start Date',
                        border: const OutlineInputBorder(),
                        suffixIcon: const Icon(Icons.calendar_today),
                        errorText: field.errorText,
                      ),
                      child: Text(
                        _startDate == null
                            ? 'Select start date'
                            : _formatDate(_startDate!),
                      ),
                    ),
                  ),
                ),
              ),

              FormField<DateTime>(
                validator: (value) {
                  if (_endDate != null &&
                      _startDate != null &&
                      _endDate!.isBefore(_startDate!)) {
                    return 'End date must be after start date';
                  }
                  return null;
                },
                builder: (field) => Padding(
                  padding: const EdgeInsets.only(bottom: 16),
                  child: InkWell(
                    onTap: () async {
                      await _pickDate(false);
                      field.didChange(_endDate);
                    },
                    child: InputDecorator(
                      decoration: InputDecoration(
                        labelText: 'End Date (Optional)',
                        border: const OutlineInputBorder(),
                        suffixIcon: const Icon(Icons.calendar_today),
                        errorText: field.errorText,
                      ),
                      child: Text(
                        _endDate == null
                            ? 'Ongoing / Select end date'
                            : _formatDate(_endDate!),
                      ),
                    ),
                  ),
                ),
              ),

              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: _showSummary,
                  child: const Text('Save'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
