import 'package:flutter/material.dart';
import 'package:pdl/home.dart';
import 'package:pdl/result.dart';
import 'package:tflite_flutter/tflite_flutter.dart';

class DiabetesDetect extends StatefulWidget {
  const DiabetesDetect({super.key});

  @override
  State<DiabetesDetect> createState() => _DiabetesDetectState();
}

class _DiabetesDetectState extends State<DiabetesDetect> {
  int age = 0;
  String gender = "Select Gender";
  List<String> genderlist = ['Male', 'Female'];
  List<Map> patientData = [
    {
      'name': 'Polyuria',
      'isCheck': false,
    },
    {
      'name': 'Polydipsia',
      'isCheck': false,
    },
    {
      'name': 'Sudden weight loss',
      'isCheck': false,
    },
    {
      'name': 'Weakness',
      'isCheck': false,
    },
    {
      'name': 'Polyphagia',
      'isCheck': false,
    },
    {
      'name': 'Genital thrush',
      'isCheck': false,
    },
    {
      'name': 'Visual blurring',
      'isCheck': false,
    },
    {
      'name': 'Itching',
      'isCheck': false,
    },
    {
      'name': 'Irritability',
      'isCheck': false,
    },
    {
      'name': 'Delayed healing',
      'isCheck': false,
    },
    {
      'name': 'Partial paresis',
      'isCheck': false,
    },
    {
      'name': 'Muscle stiffness',
      'isCheck': false,
    },
    {
      'name': 'Alopecia',
      'isCheck': false,
    },
    {
      'name': 'Obesity',
      'isCheck': false,
    },
  ];
  var finaldata = {};
  Future<void> predData() async {
    finaldata['Age'] = age;
    if (gender == 'Male') {
      finaldata['Gender'] = 1;
    } else {
      finaldata['Gender'] = 0;
    }
    patientData.forEach((item) {
      finaldata[item['name']] = item['isCheck'] ? 1 : 0;
    });
    print(finaldata);
    final interpreter =
        await Interpreter.fromAsset('assets/diabetes_model.tflite');
    var output = List.filled(1, 0).reshape([1, 1]);
    interpreter.run([finaldata.values.toList()], output);
    print(output[0][0]);
    Navigator.push(context, MaterialPageRoute(builder: (context) {
      return Result(
        output: output[0][0],
      );
    }));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back,
            color: Colors.white,
          ),
          onPressed: () {},
        ),
        title: const Text(
          "Diabetes Test",
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
        backgroundColor: const Color(0xFF32BFAE),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(
              height: 20,
            ),
            const Text(
              "Please Select The Symptoms:",
              style: TextStyle(fontSize: 16),
            ),
            const SizedBox(
              height: 2,
            ),
            const Divider(
              color: Colors.grey,
              thickness: 1,
            ),
            const SizedBox(height: 10),
            Container(
                width: double.infinity,
                child: DropdownButton(
                  isExpanded: true,
                  items: <String>["Select Gender", "Men", "Women"]
                      .map<DropdownMenuItem<String>>((String val) {
                    return DropdownMenuItem<String>(
                        value: val, child: Text(val));
                  }).toList(),
                  onChanged: (String? e) {
                    setState(() {
                      gender = e!;
                    });
                  },
                  value: gender,
                  icon: Icon(Icons.arrow_drop_down, color: Colors.grey),
                )),
            TextField(
              onChanged: (val) {
                setState(() {
                  age = int.parse(val);
                });
              },
              decoration: const InputDecoration(labelText: "Enter your age"),
              keyboardType: TextInputType.number,
            ),
            Column(
              children: patientData.map((e) {
                return CheckboxListTile(
                    activeColor: const Color(0xFF32BFAE),
                    checkboxShape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(6)),
                    title: Text(e['name']),
                    value: e['isCheck'],
                    onChanged: (value) {
                      setState(() {
                        e['isCheck'] = value;
                      });
                    });
              }).toList(),
            ),
            Center(
              child: ElevatedButton(
                onPressed: () {
                  print((gender, age, patientData));
                  predData();
                },
                style: ElevatedButton.styleFrom(
                  minimumSize: const Size(260, 50),
                  textStyle: const TextStyle(fontSize: 24),
                  backgroundColor: const Color(0xFF32BFAE),
                  foregroundColor: Colors.white,
                ),
                child: const Text("Predict"),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
