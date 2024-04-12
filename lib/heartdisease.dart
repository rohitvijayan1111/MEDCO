import 'package:flutter/material.dart';
import 'package:tflite_flutter/tflite_flutter.dart';
import 'package:pdl/resultheart.dart';

class HeartDisease extends StatefulWidget {
  @override
  _HeartDiseaseState createState() => _HeartDiseaseState();
}

class _HeartDiseaseState extends State<HeartDisease> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _ageController = TextEditingController();
  final TextEditingController _sexController = TextEditingController();
  final TextEditingController _cpController = TextEditingController();
  final TextEditingController _trestbpsController = TextEditingController();
  final TextEditingController _cholController = TextEditingController();
  final TextEditingController _fbsController = TextEditingController();
  final TextEditingController _restecgController = TextEditingController();
  final TextEditingController _thalachController = TextEditingController();
  final TextEditingController _oldpeakController = TextEditingController();
  final TextEditingController _slopeController = TextEditingController();
  final TextEditingController _caController = TextEditingController();
  final TextEditingController _thalController = TextEditingController();

  String _sex = 'Male';
  String _cpValue = '0';
  String _fbsValue = '0';
  String _restecgValue = '0';
  String _slopeValue = '1';
  String _thalValue = '3';

  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      Map<String, dynamic> inputData = {
        'age': int.parse(_ageController.text),
        'sex': _sexController.text == 'Male' ? 1 : 0,
        'cp': int.parse(_cpController.text),
        'trestbps': int.parse(_trestbpsController.text),
        'chol': int.parse(_cholController.text),
        'fbs': int.parse(_fbsController.text),
        'restecg': int.parse(_restecgController.text),
        'thalach': int.parse(_thalachController.text),
        'oldpeak': double.parse(_oldpeakController.text),
        'slope': int.parse(_slopeController.text),
        'ca': int.parse(_caController.text),
        'thal': int.parse(_thalController.text),
      };

      try {
        final interpreter = Interpreter.fromAsset('assets/heart.tflite');
        interpreter.then((interpreter) {
          var output = List.filled(1, 0).reshape([1, 1]);
          interpreter.run([inputData.values.toList()], output);

          showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                title: Text('Heart Disease Prediction Result'),
                content: Text(output[0][0] > 0.5
                    ? 'You Might Have Heart Disease'
                    : 'You May Not Have Heart Disease'),
                actions: <Widget>[
                  TextButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              ResultHeart(hasHeartDisease: output[0][0] > 0.5),
                        ),
                      );
                    },
                    child: Text('OK'),
                  ),
                ],
              );
            },
          );
        });
      } catch (e) {
        print('Error: $e');
        // Handle error
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Heart Disease Prediction Form'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                TextFormField(
                  controller: _ageController,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    labelText: 'Age',
                    border: OutlineInputBorder(),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your age';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 10),
                TextFormField(
                  controller: _sexController,
                  decoration: InputDecoration(
                    labelText: 'Sex (Male/Female)',
                    border: OutlineInputBorder(),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your sex';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 10),
                DropdownButtonFormField<String>(
                  value: _cpValue,
                  onChanged: (String? newValue) {
                    setState(() {
                      _cpValue = newValue!;
                    });
                  },
                  items: <String>['0', '1', '2', '3']
                      .map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                  decoration: InputDecoration(
                    labelText: 'Chest Pain Type (CP)',
                    border: OutlineInputBorder(),
                  ),
                ),
                SizedBox(height: 10),
                TextFormField(
                  controller: _trestbpsController,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    labelText: 'Resting Blood Pressure (Trestbps)',
                    border: OutlineInputBorder(),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your resting blood pressure';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 10),
                TextFormField(
                  controller: _cholController,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    labelText: 'Serum Cholesterol Level (Chol)',
                    border: OutlineInputBorder(),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your serum cholesterol level';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 10),
                DropdownButtonFormField<String>(
                  value: _fbsValue,
                  onChanged: (String? newValue) {
                    setState(() {
                      _fbsValue = newValue!;
                    });
                  },
                  items: <String>['0', '1']
                      .map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value == '0'
                          ? 'False (<= 120 mg/dl)'
                          : 'True (> 120 mg/dl)'),
                    );
                  }).toList(),
                  decoration: InputDecoration(
                    labelText: 'Fasting Blood Sugar (Fbs)',
                    border: OutlineInputBorder(),
                  ),
                ),
                SizedBox(height: 10),
                ElevatedButton(
                  onPressed: _submitForm,
                  child: Text('Submit'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
