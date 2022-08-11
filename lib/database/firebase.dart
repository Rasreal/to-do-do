import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart' as fb_core;
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'dart:io';


var user_uid = '';
String task_name1 = '';
final FirebaseFirestore fb_store = FirebaseFirestore.instance;
class Firebase_all {




  Future<void> addTaskDB(String taskName) async {
    //Creates the user doc named whatever the user uid is in te collection "users"
    //and adds the user data
    await fb_store.collection("tasks_to_do").doc().set({
      'Task':taskName
    });
    // task_name1 = await FirebaseFirestore.instance
    //     .collection('users')
    //     .doc('qwerty')
    //     .get()
    //     .then((value) {
    //   return value.data()!['Task']; // Access your after your get the data
    // });

  }
}