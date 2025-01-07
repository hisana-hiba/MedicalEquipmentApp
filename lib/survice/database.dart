


import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseMethods{
  Future addUserDetails(Map<String,dynamic>userInfoMap,String id)async{
    return await FirebaseFirestore.instance
        .collection("SingUp")
        .doc(id)
        .set(userInfoMap);
  }

  Future<Stream<QuerySnapshot>>getProduct(String category)async{
    return await FirebaseFirestore.instance.collection(category).snapshots();
  }
}

