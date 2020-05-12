import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:shutz_ui/Models/job_list.dart';

class jwmatch
{
  Future<QuerySnapshot> workerrmatch(Job_list joblist) async
  {
    int res=-1;
    final CollectionReference userref = Firestore.instance.collection('users');
     QuerySnapshot snap =  await userref.where('job_title',isEqualTo:joblist.job_title).where('status',isEqualTo:'Available').getDocuments();
     
    return snap;

     
  }
}