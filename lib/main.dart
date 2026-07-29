import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'widgets/buttons_section.dart';
import 'widgets/text_inputs_section.dart';
import 'widgets/selection_section.dart';
import 'widgets/slider_section.dart';
import 'widgets/select_date_section.dart';
import 'widgets/file_upload_section.dart';
import 'widgets/textarea_section.dart';
import 'widgets/badges_section.dart';
import 'widgets/progress_section.dart';
import 'widgets/tooltip_section.dart';
import 'widgets/tabs_section.dart';
import 'widgets/alerts_section.dart' show AlertsRow, AlertType;
import 'widgets/modal_section.dart' show ModalSection, ModalAction;
import 'summary_page.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(scaffoldBackgroundColor: const Color(0xFFF9FAFB), useMaterial3: true),
      home: const ComponentLibraryDashboard(),
    );
  }
}

class ComponentLibraryDashboard extends StatefulWidget {
  const ComponentLibraryDashboard({super.key});

  @override
  State<ComponentLibraryDashboard> createState() => _ComponentLibraryDashboardState();
}

class _ComponentLibraryDashboardState extends State<ComponentLibraryDashboard> {
  // Shared state collected from sections
  final _nameController = TextEditingController(text: 'Ada Lovelace');
  final _passwordController = TextEditingController();
  final _notesController = TextEditingController();
  bool _emailNotif = false;
  bool _smsNotif = false;
  int _billing = 0;
  bool _darkMode = true;
  double _sliderValue = 62;
  String _role = 'Editor';
  DateTime _date = DateTime(2023, 2, 3);
  String _activeTab = 'Overview';
  List<String> _tags = ['Design', 'Frontend'];
  int _fileCount = 0;
  List<Uint8List> _uploadedFiles = [];
  AlertType _selectedAlert = AlertType.none;
  ModalAction _modalAction = ModalAction.none;
  String _lastButtonPressed = '';

  void _onSubmit() {
    final data = {
      'name': _nameController.text,
      'password': _passwordController.text,
      'notes': _notesController.text,
      'emailNotif': _emailNotif,
      'smsNotif': _smsNotif,
      'billing': _billing,
      'darkMode': _darkMode,
      'sliderValue': _sliderValue,
      'role': _role,
      'date':
          '${_date.month.toString().padLeft(2, '0')}/${_date.day.toString().padLeft(2, '0')}/${_date.year}',
      'activeTab': _activeTab,
      'tags': _tags,
      'fileCount': _fileCount,
      'uploadedFiles': _uploadedFiles,
      'selectedAlert': _selectedAlert.name,
      'modalAction': _modalAction.name,
      'lastButtonPressed': _lastButtonPressed,
    };
    Navigator.push(context, MaterialPageRoute(builder: (_) => SummaryPage(data: data)));
  }

  @override
  void dispose() {
    _nameController.dispose();
    _passwordController.dispose();
    _notesController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFFF9FAFB),
        elevation: 0,
        toolbarHeight: 100,
        title: const Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Text('Component library',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 26, color: Colors.black)),
            SizedBox(height: 4),
            Text('A reference sheet of common front-end controls, grouped by type.',
                style: TextStyle(fontSize: 13, color: Colors.black54)),
          ],
        ),
      ),
      body: LayoutBuilder(
        builder: (context, constraints) {
          final isWide = constraints.maxWidth > 900;
          return SingleChildScrollView(
            padding: const EdgeInsets.all(24),
            child: isWide ? _wideLayout() : _narrowLayout(),
          );
        },
      ),
    );
  }

  Widget _wideLayout() {
    return Column(
      children: [
        _row([_buttons(), _textInputs(), _selection()]),
        const SizedBox(height: 16),
        _row([_slider(), _selectDate(), _fileUpload()]),
        const SizedBox(height: 16),
        _textarea(),
        const SizedBox(height: 16),
        _row([_badges(), const ProgressSection(), const TooltipSection()]),
        const SizedBox(height: 16),
        _tabs(),
        const SizedBox(height: 16),
        alertsRow(),
        const SizedBox(height: 24),
        _modal(),
        // _row([alertsRow(), _modal()]),
        const SizedBox(height: 24),
        _submitButton(),
        const SizedBox(height: 24),
      ],
    );
  }

  Widget _narrowLayout() {
    return Column(
      children: [
        _buttons(),
        const SizedBox(height: 16),
        _textInputs(),
        const SizedBox(height: 16),
        _selection(),
        const SizedBox(height: 16),
        _slider(),
        const SizedBox(height: 16),
        _selectDate(),
        const SizedBox(height: 16),
        _fileUpload(),
        const SizedBox(height: 16),
        _textarea(),
        const SizedBox(height: 16),
        _badges(),
        const SizedBox(height: 16),
        const ProgressSection(),
        const SizedBox(height: 16),
        const TooltipSection(),
        const SizedBox(height: 16),
        _tabs(),
        const SizedBox(height: 16),
        alertsRow(),
        const SizedBox(height: 16),
        _modal(),
        const SizedBox(height: 24),
        _submitButton(),
        const SizedBox(height: 24),
      ],
    );
  }

  Widget _row(List<Widget> children) {
    return IntrinsicHeight(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: children
            .expand((w) => [Expanded(child: w), const SizedBox(width: 16)])
            .toList()
          ..removeLast(),
      ),
    );
  }

  // Stateful wrappers that sync back to dashboard state
  Widget _buttons() => ButtonsSection(
        onButtonPressed: (v) => setState(() => _lastButtonPressed = v),
      );

  Widget _textInputs() => TextInputsSection(
        nameController: _nameController,
        passwordController: _passwordController,
      );

  Widget _selection() => SelectionSection(
        emailNotif: _emailNotif,
        smsNotif: _smsNotif,
        billing: _billing,
        darkMode: _darkMode,
        onEmailChanged: (v) => setState(() => _emailNotif = v),
        onSmsChanged: (v) => setState(() => _smsNotif = v),
        onBillingChanged: (v) => setState(() => _billing = v),
        onDarkModeChanged: (v) => setState(() => _darkMode = v),
      );

  Widget _slider() => SliderSection(
        value: _sliderValue,
        onChanged: (v) => setState(() => _sliderValue = v),
      );

  Widget _selectDate() => SelectDateSection(
        role: _role,
        date: _date,
        onRoleChanged: (v) => setState(() => _role = v),
        onDateChanged: (v) => setState(() => _date = v),
      );

  Widget _fileUpload() => FileUploadSection(
        onFileCountChanged: (v) => setState(() => _fileCount = v),
        onFilesChanged: (v) => setState(() => _uploadedFiles = v),
      );

  Widget _textarea() => TextareaSection(controller: _notesController);

  Widget _badges() => BadgesSection(
        tags: _tags,
        onTagsChanged: (v) => setState(() => _tags = v),
      );

  Widget _tabs() => TabsSection(
        onTabChanged: (v) => setState(() => _activeTab = v),
      );

  Widget alertsRow() => AlertsRow(
        selected: _selectedAlert,
        onChanged: (v) => setState(() => _selectedAlert = v),
      );

  Widget _modal() => ModalSection(
        onAction: (v) => setState(() => _modalAction = v),
      );

  Widget _submitButton() {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: _onSubmit,
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color(0xFF2563EB),
          foregroundColor: Colors.white,
          elevation: 0,
          padding: const EdgeInsets.symmetric(vertical: 18),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        ),
        child: const Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Submit', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600)),
            SizedBox(width: 8),
            Icon(Icons.arrow_forward, size: 18),
          ],
        ),
      ),
    );
  }
}
