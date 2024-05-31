import 'package:flutter/material.dart';
import 'package:interf/Fragment/login.dart';

class AddQuestionScreen extends StatefulWidget {
  @override
  _AddQuestionScreenState createState() => _AddQuestionScreenState();
}

class _AddQuestionScreenState extends State<AddQuestionScreen> {
  final _formKey = GlobalKey<FormState>();
  final _questionController = TextEditingController();
  final _optionControllers = List<TextEditingController>.generate(
    4,
    (index) => TextEditingController(),
  );
  String? _selectedAnswer;
  // String? _selectedCategory;

  @override
  void dispose() {
    _questionController.dispose();
    _optionControllers.forEach((controller) => controller.dispose());
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add Question'),
        actions: [
          IconButton(
            icon: Icon(Icons.logout),
            onPressed: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => LoginPage()),
              );
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              children: [
                TextFormField(
                  controller: _questionController,
                  decoration: InputDecoration(labelText: 'Question'),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter a question';
                    }
                    return null;
                  },
                ),
                ..._optionControllers.map((controller) {
                  return TextFormField(
                    controller: controller,
                    decoration: InputDecoration(labelText: 'Option'),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter an option';
                      }
                      return null;
                    },
                    onChanged: (text) {
                      setState(() {
                        // Force the dropdown to rebuild and reflect the new options
                      });
                    },
                  );
                }).toList(),
                DropdownButtonFormField<String>(
                  value: _selectedAnswer,
                  items: _optionControllers.map((controller) {
                    return DropdownMenuItem<String>(
                      value: controller.text,
                      child: Text(controller.text),
                    );
                  }).toList(),
                  onChanged: (value) {
                    setState(() {
                      _selectedAnswer = value;
                    });
                  },
                  decoration: InputDecoration(labelText: 'Correct Answer'),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please select the correct answer';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      final newQuestion = {
                        'question': _questionController.text,
                        'options': _optionControllers
                            .map((controller) => controller.text)
                            .toList(),
                        'answer': _selectedAnswer
                      };
                      Navigator.pop(context, newQuestion);
                    }
                  },
                  child: Text('Add Question'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
