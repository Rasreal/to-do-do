import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:to_do_app/components/task_tile.dart';
import 'package:to_do_app/constants.dart';
import 'package:to_do_app/components/task_list.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:to_do_app/components/add_task_screen.dart';
import 'package:to_do_app/module/tasks.dart';
import 'package:to_do_app/module/tasks_notifier.dart';
import 'package:provider/provider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:to_do_app/database/firebase.dart';


int data_size = 0;
class TaskScreen extends StatefulWidget {
  const TaskScreen({Key? key}) : super(key: key);

  @override
  State<TaskScreen> createState() => _TaskScreenState();
}

class _TaskScreenState extends State<TaskScreen> with SingleTickerProviderStateMixin{

  late AnimationController controller;
  Animation? anim;
  Animation? color_anim;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    controller = AnimationController(
        vsync: this, duration: Duration(seconds: 2), lowerBound: 0.3);
    anim = CurvedAnimation(parent: controller, curve: Curves.easeInOutExpo);
    color_anim =
        ColorTween(begin: Colors.orangeAccent, end: Colors.redAccent)
            .animate(controller);
    //controller.repeat(reverse: true); //yoyo animation effect

    controller.forward();

    controller.addListener(() {
      setState(() {});
      //print(anim?.value);
    });
  }

  bool check = false;




  @override
  Widget build(BuildContext context) {
    return Scaffold(
      /*appBar: AppBar(
        backgroundColor: Colors.redAccent,
        title: Center(
          child: Text(
            'TO-DO ✔',
            style: TextStyle(
              fontFamily: 'Pacifico',
            ),
          ),
        ),*/

      backgroundColor: Colors.orangeAccent,
      body: Stack(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                  padding: EdgeInsets.only(top: anim?.value * 80, left: 40, right: 40),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          CircleAvatar(
                            child: Icon(
                              FontAwesomeIcons.list,
                              color: Colors.blueAccent,
                              size: 34,
                            ),
                            backgroundColor: Colors.white,
                            radius: 35,
                          ),
                          CircleAvatar(
                            child: TextButton(
                              onPressed: () {
                                setState(() {
                                  data_size = 0;
                                  fb_store.collection('tasks_to_do').get().then((snapshot) {
                                      for (DocumentSnapshot ds in snapshot.docs){
                                      ds.reference.delete();}
                                  });
                                  taskStream();
                                });
                              },
                              child: Icon(
                                FontAwesomeIcons.xmark,
                                color: Colors.red,
                                size: 20,
                              ),
                            ),
                            backgroundColor: Colors.white,
                            radius: 22,
                          ),
                        ],
                      ),
                      SizedBox(
                        height: anim?.value * 20,
                      ),
                      Text(
                        'ToDoDO',
                        style:
                            pacific.copyWith(fontSize: 35, color: Colors.white),
                      ),
                      Text(

                        data_size > 1 ? '${data_size} tasks ': '${data_size} task ',
                        style:
                            eduvic.copyWith(fontSize: 19, color: Colors.white),
                      ),
                    ],
                  )),
              SizedBox(
                height: anim?.value * 20,
              ),
              Expanded(
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: anim?.value * 30, vertical: 0),
                  child: taskStream(),
                  decoration: BoxDecoration(
                      color: color_anim?.value,
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(25),
                          topRight: Radius.circular(25))),
                ),
              )
            ],
          ),
          SlidingUpPanel(
            backdropEnabled: true,
            parallaxOffset: 0.5,
            backdropColor: Colors.black54,
            backdropOpacity: 0.42,
            color: Color(0xFAc866ff),
            maxHeight: 345,
            minHeight: 125,
            panel: AddTask(
                func: (){
                  setState(() {
                      taskStream();
                      data_size++;
                  });

                },
            ),
            borderRadius: BorderRadius.only(
                topRight: Radius.circular(20), topLeft: Radius.circular(20)),
          ),
          SizedBox(
            height: 30,
          ),
        ],
      ),
    );
  }
}


class taskStream extends StatefulWidget {
  const taskStream({Key? key}) : super(key: key);

  @override
  State<taskStream> createState() => _taskStreamState();
}

class _taskStreamState extends State<taskStream> {
  @override
  Widget build(BuildContext context) {
    return  StreamBuilder<QuerySnapshot>(
        stream: fb_store
            .collection('tasks_to_do')
            .snapshots(),
        builder: (context, snapshot) {
          if(snapshot.hasError){
            return Text('Something went wrong');
          }
          if (!snapshot.hasData) {
            return Center(
                child: CircularProgressIndicator(
                  backgroundColor: Colors.grey,
                ));
          }

          final data = snapshot.requireData;

          data_size = data.size;


          return TaskList(item_count: data.size, doctask: data);
        });
  }
}

/*class ItemCountW extends StatefulWidget {
  const ItemCountW({Key? key}) : super(key: key);

  @override
  State<ItemCountW> createState() => _ItemCountWState();
}

class _ItemCountWState extends State<ItemCountW> {
  @override
  Widget build(BuildContext context) {
    return Text(

      data_size > 1 ? '$ tasks unfinished': '${Provider.of<TaskNotify>(context).dataSIZE()} task unfinished',
      style:
      eduvic.copyWith(fontSize: 19, color: Colors.white),
    );
  }
}*/





