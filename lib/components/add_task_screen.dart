import 'package:flutter/material.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:to_do_app/constants.dart';
import 'package:to_do_app/module/tasks_notifier.dart';
import 'package:provider/provider.dart';
import 'package:to_do_app/module/tasks.dart';
import 'package:to_do_app/screens/task_screen.dart';

class AddTask extends StatelessWidget {
  String newtask = '';
  bool check2 = false;
  final Function func;
  AddTask({required this.func});


  final fieldText = TextEditingController();
  void clearText() {
    fieldText.clear();
  }

  @override
  Widget build(BuildContext context) {
    Widget default_style (){
      return DefaultTextStyle(
        style: TextStyle(
          fontSize: 20.0,
          fontFamily: 'Pacifico',
        ),
        child: AnimatedTextKit(
          animatedTexts: [
            ScaleAnimatedText('SLIDE UP'),
          ],
          onTap: () {
            print("Tap Event");
          },
        ),
      );

    }
    return Container(
      width: 300,
      height: 30,
      padding: EdgeInsets.all(15),
      //margin: EdgeInsets.only(left: 150, top: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        //mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          default_style(),
          SizedBox(
            height: 50,
          ),
          Text('A D D    T A S K',
              style: pacific.copyWith(fontSize: 30, wordSpacing: 0)),
          SizedBox(
            height: 10,
          ),
          SizedBox(
            width: 260,
            child: TextField(
              style: eduvic,
              textAlign: TextAlign.center,
              onChanged: (value) {
                newtask = value;
              },
              controller: fieldText,
            ),
          ),
          SizedBox(
            height: 45,
          ),
          SizedBox(
            height: 50,
            width: 180,
            child: Material(
              elevation: 5,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20)),
              child: MaterialButton(
                onPressed: () {
                  Provider.of<TaskNotify>(context, listen: false).addTaskNotify(newtask);
                  func();
                  TextEditingController().clear();
                },
                child: Center(
                  child: Text('ADD', style: eduvic.copyWith(wordSpacing: 25)),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
