// ignore_for_file: prefer_const_constructors

import 'package:convertit/functions/functions.dart';
import 'package:convertit/models/RatesModel.dart';
import 'package:convertit/screens/convert.dart';
import 'package:flutter/material.dart';

class Homepage extends StatefulWidget {
  const Homepage({Key? key}) : super(key: key);

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  late Future<Rates> rates;
  late Future<Map> allcurrencies;
  final formkey = GlobalKey<FormState>();
  @override
  void initState() {
    super.initState();
    setState(() {
      rates = fetchrates();
      allcurrencies = fetchcurrency();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Currency Converter'),
      ),
      body: Container(
        padding: EdgeInsets.all(10),
        child: SingleChildScrollView(
          child: Form(
            key: formkey,
            child: FutureBuilder<Rates>(
                future: rates,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(child: CircularProgressIndicator());
                  } else if (snapshot.hasError) {
                    ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('No Internet')));
                    return const Center(
                      child:
                          Text('Make sure your device has an active internet'),
                    );
                  }
                  return Center(
                    child: FutureBuilder<Map>(
                        future: allcurrencies,
                        builder: (context, currsnapshot) {
                          if (currsnapshot.connectionState ==
                              ConnectionState.waiting) {
                            return Center(child: CircularProgressIndicator());
                          }
                          return Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              AnytoAny(
                                  rates: snapshot.data!.rates,
                                  currencies: currsnapshot.data!),
                            ],
                          );
                        }),
                  );
                }),
          ),
        ),
      ),
    );
  }
}
