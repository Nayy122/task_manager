import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:task_manager/models/tasks.dart';
import 'package:task_manager/models/user.dart';

class DatabaseService{
  final String uid;
  DatabaseService({required this.uid});
  final CollectionReference taskCollection = FirebaseFirestore.instance.collection('tasks');

  Future updateUserData(String tasks,String name,int hours) async{
    return await taskCollection.doc(uid).set({
      'tasks':tasks,
      'name':name,
      'hours':hours,
    });
  }

  // task list Iterable<Tasks>ot
 List<Tasks>_taskListFromSnapshot(QuerySnapshot snapshot){
    return snapshot.docs.map((doc){
      return Tasks(
          name: doc.get('name') ?? " ",
          tasks: doc.get('tasks')??'0',
          hours: doc.get('hours')??0
      );
    }).toList();
  }

  //userdata from snapshot
  UserData _userDataFromSnapshot(DocumentSnapshot snapshot){
    final data=snapshot.data() as Map<String,dynamic>;
    return UserData(uid: uid, name: data['name'].toString(), hours: data['hours'], tasks: data['tasks'].toString());
  }

  //get tasks stream
 Stream<List<Tasks>> get tasks {
    return taskCollection.snapshots()
    .map(_taskListFromSnapshot);
 }

 //get user doc stream
Stream<UserData> get userData {
    return taskCollection.doc(uid).snapshots()
        .map(_userDataFromSnapshot);
}
}