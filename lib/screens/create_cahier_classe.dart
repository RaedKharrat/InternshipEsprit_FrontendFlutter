import 'package:flutter/material.dart';
import '../api/cachierdeclass_service.dart';

class CreateCahierClasse extends StatefulWidget {
  @override
  _CreateCahierClasseState createState() => _CreateCahierClasseState();
}

class _CreateCahierClasseState extends State<CreateCahierClasse> {
  final _formKey = GlobalKey<FormState>();
  final CahierClasseService _service = CahierClasseService(baseUrl: 'http://localhost:5000');

  // Form fields
  String? date;
  String? contenu;
  String? horaireSeance;
  String? titreSeance;
  String? remarque;
  String? moduleId;
  String? classeId;
  bool semestre = true; // Use boolean for toggle

  // Dropdown data (modules and classes)
  String? selectedModule;
  String? selectedClasse;
  List<String> modules = ['66db9a519c87ba6ec665608a', '66db9a559c87ba6ec665608b', 'Module 3'];
  List<String> classes = ['66db9a309c87ba6ec6656087', '66db9a439c87ba6ec6656088', 'Class 3'];

  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();

      if (date == null || contenu == null || horaireSeance == null || titreSeance == null || selectedModule == null || selectedClasse == null) {
        print('One or more required fields are null');
        return;
      }

      _service.createCahierClasse(
        date: date!,
        contenu: contenu!,
        horaireSeance: horaireSeance!,
        titreSeance: titreSeance!,
        remarque: remarque,
        moduleId: selectedModule!,
        classeId: selectedClasse!,
        semestre: semestre ? 'Semestre 1' : 'Semestre 2',
        userId: "userId",
      ).then((_) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text('CahierClasse Created'),
        ));
      }).catchError((error) {
        print('Error creating CahierClasse: $error');
      });
    }
  }

  Future<void> _selectDate(BuildContext context) async {
    DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );
    if (pickedDate != null) {
      setState(() {
        date = "${pickedDate.toLocal()}".split(' ')[0];
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Ajouter Cahier de Classe',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.red,
        iconTheme: IconThemeData(color: Colors.white),
      ),
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/bg1.png'),
            fit: BoxFit.cover,
          ),
        ),
        child: SingleChildScrollView(
          padding: EdgeInsets.all(16.0),
          child: Center(
            child: Container(
              width: double.infinity,
              constraints: BoxConstraints(maxWidth: 600),
              padding: const EdgeInsets.all(20.0),
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.8),
                borderRadius: BorderRadius.circular(20),
                border: Border.all(color: Colors.red.withOpacity(0.6), width: 2),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.1),
                    spreadRadius: 5,
                    blurRadius: 10,
                    offset: Offset(0, 3),
                  ),
                ],
              ),
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    const SizedBox(height: 20),
                    GestureDetector(
                      onTap: () => _selectDate(context),
                      child: _buildDateField(),
                    ),
                    const SizedBox(height: 15),
                    _buildTextAreaField(
                      label: 'Contenu',
                      onSaved: (value) => contenu = value,
                      validator: (value) => value!.isEmpty ? 'Please enter contenu' : null,
                    ),
                    const SizedBox(height: 15),
                    _buildTextFormField(
                      label: 'Horaire Séance',
                      onSaved: (value) => horaireSeance = value,
                      validator: (value) => value!.isEmpty ? 'Please enter horaire séance' : null,
                    ),
                    const SizedBox(height: 15),
                    _buildTextFormField(
                      label: 'Titre Séance',
                      onSaved: (value) => titreSeance = value,
                      validator: (value) => value!.isEmpty ? 'Please enter titre séance' : null,
                    ),
                    const SizedBox(height: 15),
                    _buildTextAreaField(
                      label: 'Remarque',
                      onSaved: (value) => remarque = value,
                      validator: (value) => null,
                    ),
                    const SizedBox(height: 15),
                    _buildDropdownField(
                      label: 'Module',
                      items: modules,
                      onChanged: (value) => setState(() => selectedModule = value),
                      value: selectedModule,
                    ),
                    const SizedBox(height: 15),
                    _buildDropdownField(
                      label: 'Classe',
                      items: classes,
                      onChanged: (value) => setState(() => selectedClasse = value),
                      value: selectedClasse,
                    ),
                    const SizedBox(height: 15),
                    _buildToggleButton(),
                    const SizedBox(height: 30),
                    ElevatedButton(
                      onPressed: _submitForm,
                      style: ElevatedButton.styleFrom(
                        primary: Colors.red,
                        padding: EdgeInsets.symmetric(vertical: 15),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15),
                        ),
                      ),
                      child: Text(
                        'Submit',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildDateField() {
    return TextFormField(
      initialValue: date,
      decoration: InputDecoration(
        labelText: 'Date',
        border: OutlineInputBorder(),
        suffixIcon: Icon(Icons.calendar_today),
      ),
      readOnly: true,
      onTap: () => _selectDate(context),
    );
  }

  Widget _buildTextFormField({
    required String label,
    required FormFieldSetter<String> onSaved,
    required FormFieldValidator<String> validator,
  }) {
    return TextFormField(
      decoration: InputDecoration(
        labelText: label,
        border: OutlineInputBorder(),
      ),
      keyboardType: TextInputType.text,
      onSaved: onSaved,
      validator: validator,
    );
  }

  Widget _buildTextAreaField({
    required String label,
    required FormFieldSetter<String> onSaved,
    required FormFieldValidator<String> validator,
  }) {
    return TextFormField(
      decoration: InputDecoration(
        labelText: label,
        border: OutlineInputBorder(),
      ),
      keyboardType: TextInputType.multiline,
      maxLines: 3,
      onSaved: onSaved,
      validator: validator,
    );
  }

  Widget _buildDropdownField({
    required String label,
    required List<String> items,
    required ValueChanged<String?> onChanged,
    String? value,
  }) {
    return DropdownButtonFormField<String>(
      decoration: InputDecoration(
        labelText: label,
        border: OutlineInputBorder(),
      ),
      value: value,
      items: items.map((item) => DropdownMenuItem<String>(
        value: item,
        child: Text(item),
      )).toList(),
      onChanged: onChanged,
      validator: (value) => value == null ? 'Please select $label' : null,
    );
  }

  Widget _buildToggleButton() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text('Semestre 1'),
        Switch(
          value: semestre,
          onChanged: (value) => setState(() => semestre = value),
        ),
        Text('Semestre 2'),
      ],
    );
  }
}
