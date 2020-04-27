import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ninjabrew/models/user.dart';
import '../models/brew.dart';
class DatabaseService{
  final String uid;
  DatabaseService({this.uid});
final CollectionReference brewcollection=Firestore.instance.collection("brews");
Future updateuserdata(String sugars,String name,int strength)async
{
  return await brewcollection.document(uid).setData({
'sugars':sugars,
'name':name,
'strength':strength
  });
}
//brew list from snapshot
List<Brew>_brewlistfromsnapshot(QuerySnapshot snapshot)
{
  return snapshot.documents.map((doc){
return Brew(name: doc.data['name'] ?? '',
sugars: doc.data['sugars'] ?? 0,
strength: doc.data['strength'] ?? '0',

);
  }).toList();
}
//userdata from snapshot
UserData _userdatafromsnapshot(DocumentSnapshot snapshot)
{
  return UserData(
    uid:uid,
    name:snapshot.data['name'],
    sugars:snapshot.data['sugars'],
    strength:snapshot.data['strength'],
  );
}
//get brews streams
Stream<List<Brew>> get brews
{
return brewcollection.snapshots().map(_brewlistfromsnapshot);
}
//get user doc streams
Stream<UserData> get userdata
{
  return brewcollection.document(uid).snapshots().map(_userdatafromsnapshot);
}
} 
