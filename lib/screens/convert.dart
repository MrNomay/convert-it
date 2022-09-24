// ignore_for_file: unnecessary_brace_in_string_interps, prefer_interpolation_to_compose_strings, prefer_typing_uninitialized_variables, unnecessary_null_comparison

import 'package:convertit/functions/functions.dart';
import 'package:flutter/material.dart';

class AnytoAny extends StatefulWidget {
  const AnytoAny({Key? key, @required this.rates, required this.currencies})
      : super(key: key);
  final rates;
  final Map currencies;
  @override
  State<AnytoAny> createState() => _AnytoAnyState();
}

class _AnytoAnyState extends State<AnytoAny> {
  String choose = 'USD';
  String choose2 = 'PKR';
  String result = 'Conversion will be shown here';
  TextEditingController input = TextEditingController();
  @override
  Widget build(BuildContext context) {
    var h = MediaQuery.of(context).size.height;
    var w = MediaQuery.of(context).size.width;
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            const Text(
              'Convert Any to Any',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            SizedBox(
              height: h / 32,
            ),
            TextFormField(
              controller: input,
              decoration: InputDecoration(
                  label: const Text('Enter Amount'),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                  )),
              keyboardType: TextInputType.number,
              cursorColor: Colors.yellow,
            ),
            SizedBox(
              height: h / 32,
            ),
            Center(
              child: SizedBox(
                height: h / 16,
                width: w,
                child: Row(
                  children: [
                    const Spacer(
                      flex: 1,
                    ),
                    DropdownButton<String>(
                      elevation: 16,
                      style: const TextStyle(color: Colors.black87),
                      icon: const Icon(
                        Icons.arrow_downward,
                        color: Colors.black87,
                      ),
                      underline: Container(
                        height: h / 512,
                        color: Colors.yellow,
                      ),
                      value: choose,
                      onChanged: (String? value) {
                        setState(() {
                          choose = value!;
                        });
                      },
                      items: widget.currencies.keys
                          .toSet()
                          .toList()
                          .map<DropdownMenuItem<String>>((value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value),
                        );
                      }).toList(),
                    ),
                    const Spacer(
                      flex: 1,
                    ),
                    const Text('To'),
                    const Spacer(
                      flex: 1,
                    ),
                    DropdownButton<String>(
                      style: const TextStyle(color: Colors.black87),
                      icon: const Icon(
                        Icons.arrow_downward,
                        color: Colors.black87,
                      ),
                      underline: Container(
                        height: h / 512,
                        color: Colors.yellow,
                      ),
                      value: choose2,
                      onChanged: (String? value) {
                        setState(() {
                          choose2 = value!;
                        });
                      },
                      items: widget.currencies.keys
                          .toSet()
                          .toList()
                          .map<DropdownMenuItem<String>>((value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value),
                        );
                      }).toList(),
                    ),
                    const Spacer(
                      flex: 1,
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(
              height: h / 32,
            ),
            ElevatedButton(
                onPressed: () {
                  setState(() {
                    if (input.text.isEmpty) {
                      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(backgroundColor: Colors.red,
                          content: Text('Please Enter a valid number !')));
                    }
                    else {
                      result = input.text +
                        ' ' +
                        choose +
                        '=' +
                        conversion(widget.rates, input.text, choose,
                            choose2) + ' '+
                        choose2;
                    }
                  });
                },
                child: const Text('Convert')),
            SizedBox(
              height: h / 32,
            ),
            Text(
              result,
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            SizedBox(
              height: h / 32,
            ),
          ],
        ),
      ),
    );
  }
}
