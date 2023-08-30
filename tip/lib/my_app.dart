import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Tip Time App',
      theme: ThemeData(
        primarySwatch: Colors.green,
      ),
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Tip Time'),
        ),
        body: const FormValidation(),
      ),
    );
  }
}

class FormValidation extends StatefulWidget {
  const FormValidation({Key? key}) : super(key: key);

  @override
  State<FormValidation> createState() => _FormValidation();
}

class _FormValidation extends State<FormValidation> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _ammount = TextEditingController();
  bool onSwitch = false;
  double tip = 0.0;
  int? _radioSelectedValue;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 20, left: 15),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    width: 230,
                    child: TextFormField(
                      keyboardType: TextInputType.number,
                      controller: _ammount,
                      inputFormatters: <TextInputFormatter>[FilteringTextInputFormatter.allow(RegExp((r'^\d+\.?\d*')))],
                      decoration: const InputDecoration(
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Colors.green,
                          ),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Colors.blue,
                          ),
                        ),
                        icon: Icon(
                          Icons.store,
                          color: Colors.green,
                        ),
                        hintText: 'Enter the cost',
                        labelText: 'Cost of service',
                      ),
                    ),
                  ),
    
                  const SizedBox(
                    width: 230,
                    child: Row(
                      children: [
                        Icon(
                          Icons.room_service,
                          color: Colors.green,
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Text(
                            'How was the service?',
                            style: TextStyle(
                              fontSize: 17,
                            ),
                          ),
                        ),
                      ],  
                    ) 
                  ),
    
                  SizedBox(
                    width: 230,
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 15),
                          child: RadioListTile(
                            title: const Text('Amazing (20%)'),
                            value: 20, 
                            groupValue: _radioSelectedValue,
                            onChanged: (int? value) {
                              setState(() {
                                _radioSelectedValue = value;
                              });
                            },
                            ),
                        ),
    
                        Padding(
                          padding: const EdgeInsets.only(left: 15),
                          child: RadioListTile(
                            title: const Text('Good (18%)'),
                            value: 18, 
                            groupValue: _radioSelectedValue, 
                            onChanged: (int? value) {
                              setState(() {
                                _radioSelectedValue = value;
                              });
                            },
                            ),
                        ),  
    
                        Padding(
                          padding: const EdgeInsets.only(left: 15),
                          child: RadioListTile(
                            title: const Text('Okay (15%)'),
                            value: 15, 
                            groupValue: _radioSelectedValue, 
                            onChanged: (int? value) {
                              setState(() {
                                _radioSelectedValue = value;
                              });
                            },
                            ),
                        ),
    
                      ],
                    )
                  ),
                
                SizedBox(
                    // width: 230,
                    child: Row(
                      children: [
                        const Icon(
                          Icons.arrow_outward_sharp,
                          color: Colors.green,
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        const Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Text(
                            'Round up tip?',
                            style: TextStyle(
                              fontSize: 17,
                            ),
                          ),
                        ),
                        
                        Expanded(child: Container()),
    
                        Switch(
                          value: onSwitch, 
                          activeColor: Colors.green,
                          onChanged: (bool value) {
                            setState(() {
                              double decimal = tip - tip.floorToDouble();
                              onSwitch = value;
                              if (onSwitch == true) {
                                if((decimal) > 0.5){
                                  tip = tip.ceilToDouble(); 
                                }else{
                                  tip = tip.floorToDouble();
                                }
                              }else{ 
                                double tipValue = double.parse(_ammount.text) * _radioSelectedValue! / 100;
                                tip = double.parse(_ammount.text) + tipValue;
                              }
                            });
                          },
                        )
                      ],  
                    ) 
                  ),
    
                SizedBox(
                  width: 385,
                    child: ElevatedButton(
                      onPressed: () {
                        double tipValue = double.parse(_ammount.text) * _radioSelectedValue! / 100;
                        double total = double.parse(_ammount.text) + tipValue;

                        setState(() {
                          tip = total;
                        });
                      },
                      child: const Text('CALCULATE'),
                    )
                ),

              Padding(
                padding: const EdgeInsets.only(right: 15),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text("Tip Ammount: \$${tip.toStringAsFixed(2)}"),
                  ],
                ),
              ),

                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
