import 'package:flutter/material.dart';
import 'package:flutter_task/screens/login_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  String? username;

  void getName() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      username = prefs.getString('username').toString();
    });
  }

  List<Map<String,dynamic>> personDetails = [
    {'name':'Atulya','age':'26','city':'Jaipur'},
    {'name':'Kabir','age':'22','city':'Hyderabad'},
    {'name':'Karan','age':'24','city':'Chandigarh'},
    {'name':'Raj','age':'25','city':'Bengaluru'},
  ];

  @override
  void initState() {
   getName();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Details"),
        actions: [
          PopupMenuButton(
              icon: Icon(Icons.sort),
              itemBuilder: (ctx) => [
               //Name
                PopupMenuItem(
                    onTap: () {
                      setState(() {
                        personDetails.sort((a,b)=> a['name'].toString().compareTo(b['name']));
                      });
                    },
                    child: Text("Name by ascending")),
                PopupMenuItem(
                    onTap: () {
                      setState(() {
                        personDetails.sort((a,b)=> b['name'].toString().compareTo(a['name']));
                      });
                    },
                    child: Text("Name by descending")),
                //Age
                PopupMenuItem(
                    onTap: () {
                      setState(() {
                        personDetails.sort((a,b)=> a['age'].toString().compareTo(b['age']));
                      });
                    },
                    child: Text("Age by ascending")),
                PopupMenuItem(
                    onTap: () {
                      setState(() {
                        personDetails.sort((a,b)=> b['age'].toString().compareTo(a['age']));
                      });
                    },
                    child: Text("Age by descending")),
                //City
                PopupMenuItem(
                    onTap: () {
                      setState(() {
                        personDetails.sort((a,b)=> a['city'].toString().compareTo(b['city']));
                      });
                    },
                    child: Text("City by Ascending")),
                PopupMenuItem(
                    onTap: () {
                      setState(() {
                        personDetails.sort((a,b)=> b['city'].toString().compareTo(a['city']));
                      });
                    },
                    child: Text("City by descending"))
              ]),
        ],
      ),
      drawer: Drawer(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Column(
            children: [
              SizedBox(height: 40,),
              Text(username.toString()),
              SizedBox(height: 50,),
              InkWell(
                onTap: () async {
                  SharedPreferences prefs = await SharedPreferences.getInstance();
                  prefs.clear();
                  Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => LoginScreen()), (route) => false);
                },
                child: Row(
                children: [
                  Icon(Icons.logout),
                  SizedBox(width: 15,),
                  Text("Logout")
                ],
              ),)
            ],
          ),
        ),
      ),
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: Column(
          children: [
            ListView.builder(
              padding: EdgeInsets.symmetric(horizontal: 10,vertical: 10),
              shrinkWrap: true,
                itemCount: personDetails.length,
                itemBuilder: (context,index) {
                  return Card(
                    elevation: 5,
                    child: ListTile(
                      leading: Text("Name: "+personDetails[index]['name']),
                      title: Text("Age: "+personDetails[index]['age']),
                      subtitle: Text("City: "+personDetails[index]['city']),
                    ),
                  );
                }),
          ],
        ),
      ),
    );
  }
}
