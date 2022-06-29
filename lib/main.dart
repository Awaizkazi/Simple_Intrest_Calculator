import 'package:flutter/material.dart';
// import 'dart:convert';

void main() {
  runApp(MaterialApp(
    title: 'Simple Intrest Calculator',
    home: SIForm(),
    debugShowCheckedModeBanner: false,
    theme: ThemeData(
      // Define the default brightness and colors.
      // brightness: Brightness.dark,
      primaryColor: Colors.amberAccent,
      highlightColor: Colors.amberAccent,
      accentColor: Colors.indigoAccent,
      // brightness: Brightness.dark,
      // Define the default font family.
      fontFamily: 'Georgia',

      // Define the default `TextTheme`. Use this to specify the default
      // text styling for headlines, titles, bodies of text, and more.
      textTheme: const TextTheme(
          // headline1: TextStyle(fontSize: 72.0),
          // headline6: TextStyle(fontSize: 36.0, fontStyle: FontStyle.italic),
          // bodyText2: TextStyle(fontSize: 14.0, fontFamily: 'Hind'),
          ),
    ),
  ));
}

// Create a Stful widget
class SIForm extends StatefulWidget {
  const SIForm({Key? key}) : super(key: key);

  @override
  _SIFormState createState() => _SIFormState();
}

class _SIFormState extends State<SIForm> {
  var _currencies = ['Rupees', 'Dollar', 'Pounds'];
  final _minimumpadding = 5.0;
  var value;
  var _currentItemSelected = 'Rupees';
  TextEditingController principalController = TextEditingController();
  TextEditingController roiController = TextEditingController();
  TextEditingController termController = TextEditingController();
  var displayResult = '';
  get onChanged => null;

  @override
  Widget build(BuildContext context) {
    // ignore: unused_local_variable
    TextStyle? textStyle = Theme.of(context).textTheme.titleMedium;
    return Scaffold(
      // resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: Text('Simple Intrest Calculator'),
      ),
      body: Container(
        margin: EdgeInsets.all(_minimumpadding * 2),
        child: ListView(
          children: [
            getImageAsset(),
            Padding(
                padding: EdgeInsets.only(
                    top: _minimumpadding, bottom: _minimumpadding),
                child: TextField(
                  keyboardType: TextInputType.number,
                  style: textStyle,
                  controller: principalController,
                  decoration: InputDecoration(
                    labelText: 'Principal',
                    hintText: 'Enter Principal e.g. 12000',
                    labelStyle: textStyle,
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5.0)),
                  ),
                )),
            Padding(
                padding: EdgeInsets.only(
                    top: _minimumpadding, bottom: _minimumpadding),
                child: TextField(
                  keyboardType: TextInputType.number,
                  style: textStyle,
                  controller: roiController,
                  decoration: InputDecoration(
                    labelText: 'Rate of Intrest',
                    hintText: 'In Percent',
                    labelStyle: textStyle,
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5.0)),
                  ),
                )),
            Padding(
              padding: EdgeInsets.only(
                  top: _minimumpadding, bottom: _minimumpadding),
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                      keyboardType: TextInputType.number,
                      style: textStyle,
                      controller: termController,
                      decoration: InputDecoration(
                        labelText: 'Term',
                        hintText: 'Term in years',
                        labelStyle: textStyle,
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5.0)),
                      ),
                    ),
                  ),

                  // Container Widget For the Distance in between 3rd Row
                  Container(
                    width: _minimumpadding * 5,
                  ),
                  Expanded(
                    child: DropdownButton(
                      items: _currencies.map((value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value),
                        );
                      }).toList(),
                      value: _currentItemSelected,
                      onChanged: <String>(newValueSelected) {
                        _onDropDownSelectedItem(newValueSelected);
                      },
                    ),
                  )
                ],
              ),
            ),
            Padding(
                padding: EdgeInsets.only(
                    bottom: _minimumpadding, top: _minimumpadding),
                child: Row(
                  children: [
                    Expanded(
                      child: ElevatedButton(
                        onPressed: () {
                          setState(() {
                            this.displayResult = _calaulateTotalReturns();
                          });
                        },
                        child: const Text(
                          'Calculate',
                          // style: textStyle,
                        ),
                      ),
                    ),
                    // Expanded 2
                    Expanded(
                      child: ElevatedButton(
                        onPressed: () {
                          setState(() {
                            _reset();
                          });
                        },
                        child: Text('Reset'),
                      ),
                    ),
                  ],
                )),
            Padding(
              padding: EdgeInsets.all(_minimumpadding),
              child: Text(this.displayResult),
            )
          ],
        ),
      ),
    );
  }

  Widget getImageAsset() {
    AssetImage assetImage = AssetImage('images/back.png');
    Image image = Image(
      image: assetImage,
      width: 125.0,
      height: 125.0,
    );

    return Container(
      child: image,
      margin: EdgeInsets.all(_minimumpadding * 10),
    );
  }

  void _onDropDownSelectedItem(newValueSelected) {
    setState(() {
      this._currentItemSelected = newValueSelected;
    });
  }

  String _calaulateTotalReturns() {
    double principal = double.parse(principalController.text);
    double roi = double.parse(roiController.text);
    double term = double.parse(termController.text);

    // Formula of a Simple Intrest
    double totalAmountPayable = principal + (principal * roi * term) / 100;
    String result =
        'After $term years , your investment will be worth $totalAmountPayable $_currentItemSelected';
    return result;
  }

  void _reset() {
    principalController.text = '';
    roiController.text = '';
    termController.text = '';
    displayResult = '';
    _currentItemSelected = _currencies[0];
  }
}
