import 'dart:math';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(
    home: GuessMyNumber(),
  ));
}

class GuessMyNumber extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.deepPurple,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: const MyHomePage(title: 'Guess My Number'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  String m = '';
  String m1 = '';
  String message;
  int number;
  bool pressOK = false;
  int randomNumber = Random().nextInt(100);
  TextEditingController msgController = TextEditingController();
  bool showMessages = false;

  // ignore: non_constant_identifier_names
  void Guess() {
    pressOK = false;
    print(randomNumber);
    if (number != null) {
      if (randomNumber < number) {
        setState(() {
          m = 'You Tried $number';
          m1 = 'Try Smaller!';
        });
      } else if (randomNumber > number) {
        setState(() {
          m = 'You Tried $number';
          m1 = 'Try Higher!';
        });
      } else
        setState(() {
          m = 'You tried $number';
          m1 = 'Good Job! You guessed right.';
          _showDialog();
          msgController.clear();
          randomNumber = Random().nextInt(100);
        });
    }
  }

  void _showDialog() {
    showDialog<AlertDialog>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20.0),
          ),
          title: const Text('You Guessed Right!'),
          content: Text('$number was the correct number!'),
          actions: <Widget>[
            FlatButton(
              onPressed: () {
                setState(() {
                  m = '';
                  m1 = '';
                });
                Navigator.of(context).pop();
              },
              child: const Text('Play again!'),
            ),
            FlatButton(
              onPressed: () {
                setState(() {
                  pressOK = !pressOK;
                  showMessages = !showMessages;
                });
                Navigator.of(context).pop();
              },
              child: const Text('OK!'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Scaffold(
        appBar: AppBar(
          title: Text(widget.title),
          centerTitle: true,
        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Container(
              padding: const EdgeInsets.fromLTRB(2.0, 10.0, 2.0, 10.0),
              child: Text(
                'I am thinking of a number between 1 and 100.',
                style: TextStyle(
                  letterSpacing: 1.0,
                  color: Colors.grey[850],
                  fontSize: 20.0,
                ),
                textAlign: TextAlign.center,
              ),
            ),
            Container(
              padding: const EdgeInsets.fromLTRB(20.0, 5.0, 20.0, 15.0),
              child: Text(
                'It is your turn to guess my number!',
                style: TextStyle(
                  letterSpacing: 1.0,
                  color: Colors.grey[850],
                  fontSize: 15.0,
                ),
                textAlign: TextAlign.center,
              ),
            ),
            Container(
              child: Text(
                m,
                style: const TextStyle(
                  letterSpacing: 1.0,
                  color: Colors.deepPurple,
                  fontSize: 25.0,
                ),
                textAlign: TextAlign.center,
              ),
            ),
            Container(
              child: Text(
                m1,
                style: const TextStyle(
                  letterSpacing: 1.0,
                  color: Colors.deepPurple,
                  fontSize: 25.0,
                ),
                textAlign: TextAlign.center,
              ),
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 20.0),
              child: Card(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    ListTile(
                      title: Text(
                        'Try a number!',
                        style: TextStyle(
                          letterSpacing: 1.0,
                          color: Colors.grey[850],
                          fontSize: 30.0,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                    TextFormField(
                      controller: msgController,
                      keyboardType: TextInputType.number,
                      style: TextStyle(
                        letterSpacing: 1.0,
                        color: Colors.grey[850],
                        fontSize: 20.0,
                      ),
                      decoration: const InputDecoration(
                        hintText: 'Insert the number here',
                      ),
                      onChanged: (String value) {
                        setState(() {
                          message = value;
                        });
                      },
                      validator: (String value) {
                        if (value.contains('.') || value.contains(',') || value.contains('-') || value.contains(' ')) {
                          return 'Please Enter an Integer!';
                        }
                        return null;
                      },
                    ),
                    FlatButton(
                      textTheme: ButtonTextTheme.accent,
                      color: Colors.grey,
                      onPressed: () {
                        if (_formKey.currentState.validate()) {
                          setState(() {
                            number = int.tryParse(message);
                            Guess();
                          });
                        }
                      },
                      child: pressOK ? const Text('RESET!') : const Text('GUESS!'),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
