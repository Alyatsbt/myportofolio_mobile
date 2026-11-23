
import 'package:flutter/material.dart';
import 'package:myportofolio_mobile/widgets/left_drawer.dart';

// === Experience Form Page ===
class ExperienceFormPage extends StatefulWidget {
  const ExperienceFormPage({super.key});

  @override
  State<ExperienceFormPage> createState() => _ExperienceFormPageState();
}

class _ExperienceFormPageState extends State<ExperienceFormPage> {
  
  // === Form State & Controllers ===
  final _formKey = GlobalKey<FormState>();
  final _positionController = TextEditingController();
  final _organizationController = TextEditingController();
  final _descriptionController = TextEditingController();

  DateTime? _startDate;
  DateTime? _endDate;

  // === Date Helper ===
  String _formatDate(DateTime date) {
    return '${date.day}/${date.month}/${date.year}';
  }

  // === Date Picker ===
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

        // Reset end date if it is earlier than the new start date.
        if (_endDate != null && _endDate!.isBefore(pickedDate)) {
          _endDate = null;
        }
      } else {
        _endDate = pickedDate;
      }
    });
  }

  // === Form Reset ===
  void _resetForm() {
    _positionController.clear();
    _organizationController.clear();
    _descriptionController.clear();

    setState(() {
      _startDate = null;
      _endDate = null;
    });

    _formKey.currentState?.reset();
  }

  // === Form Validation & Summary Dialog ===
  void _showSummary() {
    if (!_formKey.currentState!.validate()) return;

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Experience successfully added!'),
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
            child: const Text('OK'),
            onPressed: () {
              Navigator.pop(context);
              _resetForm();
            },
          ),
        ],
      ),
    );
  }

  // === Dispose Controllers ===
  @override
  void dispose() {
    _positionController.dispose();
    _organizationController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  // === Build UI ===
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Experience Form'),
        backgroundColor: Colors.indigo,
        foregroundColor: Colors.white,
      ),
      drawer: const LeftDrawer(),
      body: Form(
        key: _formKey,
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // === Position / Role ===
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  controller: _positionController,
                  decoration: InputDecoration(
                    labelText: 'Position / Role',
                    hintText: 'e.g. UI/UX Designer',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5.0),
                    ),
                  ),
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return 'Position cannot be empty';
                    }
                    return null;
                  },
                ),
              ),

              // === Organization / Company ===
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  controller: _organizationController,
                  decoration: InputDecoration(
                    labelText: 'Organization / Company',
                    hintText: 'e.g. BEM Fasilkom UI',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5.0),
                    ),
                  ),
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return 'Organization cannot be empty';
                    }
                    return null;
                  },
                ),
              ),

              // === Description ===
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  controller: _descriptionController,
                  maxLines: 5,
                  decoration: InputDecoration(
                    labelText: 'Job Description',
                    hintText: 'Describe your responsibilities...',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5.0),
                    ),
                    alignLabelWithHint: true,
                  ),
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return 'Description cannot be empty';
                    }
                    return null;
                  },
                ),
              ),

              // === Start Date ===
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: FormField<DateTime>(
                  validator: (value) {
                    if (_startDate == null) {
                      return 'Start date is required';
                    }
                    return null;
                  },
                  builder: (field) {
                    return InkWell(
                      onTap: () async {
                        await _pickDate(true);
                        field.didChange(_startDate);
                      },
                      child: InputDecorator(
                        decoration: InputDecoration(
                          labelText: 'Start Date',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5.0),
                          ),
                          suffixIcon: const Icon(Icons.calendar_today),
                          errorText: field.errorText,
                        ),
                        child: Text(
                          _startDate == null
                              ? 'Select start date'
                              : _formatDate(_startDate!),
                        ),
                      ),
                    );
                  },
                ),
              ),

              // === End Date ===
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: FormField<DateTime>(
                  validator: (value) {
                    if (_endDate != null &&
                        _startDate != null &&
                        _endDate!.isBefore(_startDate!)) {
                      return 'End date must be after start date';
                    }
                    return null;
                  },
                  builder: (field) {
                    return InkWell(
                      onTap: () async {
                        await _pickDate(false);
                        field.didChange(_endDate);
                      },
                      child: InputDecorator(
                        decoration: InputDecoration(
                          labelText: 'End Date (Optional)',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5.0),
                          ),
                          suffixIcon: const Icon(Icons.calendar_today),
                          errorText: field.errorText,
                        ),
                        child: Text(
                          _endDate == null
                              ? 'Ongoing / Select end date'
                              : _formatDate(_endDate!),
                        ),
                      ),
                    );
                  },
                ),
              ),

              // === Save Button ===
              Align(
                alignment: Alignment.bottomCenter,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      style: ButtonStyle(
                        backgroundColor: WidgetStateProperty.all(
                          Colors.indigo,
                        ),
                      ),
                      onPressed: _showSummary,
                      child: const Text(
                        'Save',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
