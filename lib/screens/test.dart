import 'package:aaviss_motors/widgets/radioformfield.dart';
import 'package:flutter/material.dart';

class Test extends StatefulWidget {
  const Test({super.key});

  @override
  State<Test> createState() => _TestState();
}

class _TestState extends State<Test> {
  @override
  final GlobalKey<FormState> _formkey = GlobalKey<FormState>();

  int? gv;
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width * 0.5,
        child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
          Padding(
            padding: const EdgeInsets.all(30.0),
            child: Form(
              autovalidateMode: AutovalidateMode.always,
              key: _formkey,
              child: CustomRadioFormField(
                fieldname1: 'Public',
                fieldname2: 'Private',
                formkey: _formkey,
                grpvalue: gv,
                ctx: context,
                onChanged: (newValue) {
                  setState(() {
                    gv = newValue;
                  });
                },
                onSaved: (Finalvalue) {
                  print('value: $gv');
                },
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: TextButton(
                onPressed: () {
                  //print(groupvalue);
                  _formkey.currentState!.validate();
                  _formkey.currentState!.save();
                  // _formkey.currentState!.reset();
                },
                child: Text('Check')),
          )
        ]),
      ),
    );
  }
}
