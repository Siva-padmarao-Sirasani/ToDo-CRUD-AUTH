import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:todo/Screens/AddToDoScreen.dart';
import 'package:todo/Screens/SignUp.dart';
import 'package:todo/Screens/ViewToDo.dart';
import 'package:todo/Widgets/TodoCard.dart';
class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final Stream<QuerySnapshot<Map<String, dynamic>>> _stram=FirebaseFirestore.instance.collection("ToDo").snapshots();
  List<Select> selected=[];
  @override
  Widget build(BuildContext context) {
    if (FirebaseAuth.instance.currentUser == null) {
      // User is not authenticated, navigate to login screen
      Navigator.pushReplacementNamed(context, '/login');
    }

    return Scaffold(
      backgroundColor: Colors.black87,
      appBar: AppBar(
        backgroundColor: Colors.black87,
        title: const Text("Today's Schedule",
          style: TextStyle(
            fontSize: 25.0,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        actions: [
          PopupMenuButton(
            itemBuilder: (context) => [
              PopupMenuItem(
                child: Text('Sign Out'),
                value: 'signOut',
              ),
            ],
            onSelected: (value) {
              if (value == 'signOut') {
                // Implement the sign-out logic
                signOut();
              }
            },
          ),
        ],
        bottom:const PreferredSize(
          child: Align(
            alignment: Alignment.centerLeft,
            child: Padding(
              padding:  EdgeInsets.only(left: 15.0),
              child: Text(
                "Monday 21",
                style:  TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w600,
                  fontSize: 25.0,
                ),
              ),
            ),
          ),
          preferredSize:Size.fromHeight(35),
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.black87,
        items: [
          const BottomNavigationBarItem(
              icon: Icon(Icons.home_filled,size: 32.0,color: Colors.white,),
            label: '',
          ),
          BottomNavigationBarItem(
              icon: Container(
                height: 50.0,
                width: 50.0,
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  gradient: LinearGradient(colors: [
                    Colors.indigoAccent,
                    Colors.purple,
                  ]),
                ),
                child: IconButton(
                  onPressed: (){
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context)=>const AddToDo()),
                    );

                  },
                    icon:const Icon(Icons.add),
                    ),
              ),
            label: '',
          ),
          const BottomNavigationBarItem(
            icon: Icon(Icons.settings,size: 32.0,color: Colors.white,),
            label: '',
          ),




        ],
      ),
      body: StreamBuilder(
        stream: _stram,
        builder: (context,snapshot) {
          if (!snapshot.hasData) {
            return const Center(child: CircularProgressIndicator());
          }
          return ListView.builder(

            itemCount: snapshot.data?.docs.length,
              itemBuilder: (context,index){
              IconData? iconData;
              Color? iconColor;
              String? time;
              Map<String,dynamic> document=snapshot.data?.docs[index].data() as Map<String,dynamic>;
              switch(document["category"]) {
                case "Work":
                  iconData=Icons.work;
                  iconColor=Colors.black;
                  time="11.30AM";
                  break;
                case "Workout":
                  iconData=Icons.sports_gymnastics_rounded;
                  iconColor=Colors.purple;
                  time="10AM";
                  break;
                case "Food":
                  iconColor=Colors.orange;
                  iconData=Icons.local_grocery_store_rounded;
                  time="11AM";
                  break;
                case "Design":
                  iconData=Icons.audiotrack_sharp;
                  iconColor=Colors.indigo;
                  time="9AM";
                  break;
                default:
                  iconColor=Colors.red;
                  iconData=Icons.run_circle_sharp;
                  time="5M";

              }
              selected.add(Select(id: snapshot.data!.docs[index].id, checkvalue: false));

                return InkWell(
                  onTap: (){
                    Navigator.push(context, MaterialPageRoute(builder: (context)=>ViewToDo(document: document,id:snapshot.data?.docs[index].id)));
                  },
                  child: TodoCard(
                  title: document["title"]==null?"Hey There":document["title"],
                  iconBgColor: Colors.white,
                  iconColor: iconColor,
                  iconData: iconData,
                  time: time,
                  check: selected[index].checkvalue,
                    index: index,
                    onChange: onChange,
                  ),
                );
        },
          );
  }
  ),
    );
  }
  void signOut() async {
    try {
      await FirebaseAuth.instance.signOut();
      // Navigate to the login screen using named route
      Navigator.pushReplacementNamed(context, '/login');
    } catch (e) {
      print("Error signing out: $e");
    }
  }

  void onChange(int index) {
    print('Checkbox changed for index $index');
    setState(() {
      selected[index].checkvalue = !selected[index].checkvalue;
    });
  }



}
class Select{
  String? id;
  bool checkvalue=false;
  Select({required this.id,required this.checkvalue});
}

