import 'package:cloud_firestore/cloud_firestore.dart';
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

  final Stream<QuerySnapshot> _personStream = FirebaseFirestore
      .instance.collection("Person").snapshots();

 bool isName = false;

 bool isAge = false;

 bool isCity = false;


  @override
  void initState() {
    getName();
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Drawer(
        child: Column(
          children: [
            SizedBox(height: 40,),
            Text(username.toString(),style: TextStyle(fontSize: 17),),
            SizedBox(height: 50,),
            InkWell(
              onTap: () async{
                SharedPreferences prefs = await SharedPreferences.getInstance();
                prefs.clear();
                Navigator.pushAndRemoveUntil(context,
                    MaterialPageRoute(builder: (context) => LoginScreen()), 
                        (route) => false);
              },
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Row(
                  children: [
                    Icon(Icons.logout),
                    SizedBox(width: 15,),
                    Text("Logout")
                  ],
                ),
              ),
            )
          ],
        ),
      ),
      appBar: AppBar(
        title: Text("Details"),
      ),
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: isName ?
        StreamBuilder(
          stream: FirebaseFirestore.instance.collection("Person").orderBy('name').snapshots(),
          builder: (context,snapshot){
            if(!snapshot.hasData) {
              return Center(child: CircularProgressIndicator(),);
            }
            if(snapshot.data!.docs.length == 0) {
              return Text("no data");
            }
            return Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    PopupMenuButton(
                        icon: Icon(Icons.sort),
                        itemBuilder: (ctx)=> [
                          PopupMenuItem(
                              onTap: () {
                                setState(() {
                                  isName = !isName;
                                });
                              },
                              child: Row(
                                children: [
                                  Checkbox(
                                      activeColor: Colors.green,
                                      value: isName, onChanged: (value) {
                                 setState(() {
                                   isName = !isName;
                                 });
                                  }),
                                  Text("Sort by Name",
                                    style: TextStyle(color: isName == true ?
                                    Colors.green :Colors.red),),
                                ],
                              )),
                          PopupMenuItem(
                              onTap: () {
                                setState(() {
                                  isAge = !isAge;
                                });
                              },
                              child: Row(
                                children: [
                                  Checkbox(value: isAge,
                                      onChanged: (value) {
                                    setState(() {
                                      isAge = !isAge;
                                    });
                                      }),
                                  Text("Sort by Age",
                                    style: TextStyle(color: isAge == true ?
                                    Colors.green :Colors.red),),
                                ],
                              )),
                          PopupMenuItem(
                              onTap: () {
                                setState(() {
                                  isCity = !isCity;
                                });
                              },
                              child: Row(
                                children: [
                                  Checkbox(value: isCity,
                                      onChanged: (value) {
                                    setState(() {
                                      isCity = !isCity;
                                    });
                                      }),
                                  Text("Sort by City",
                                    style: TextStyle(color: isCity == true ?
                                    Colors.green :Colors.red),),
                                ],
                              ))
                        ])
                  ],
                ),
                ListView.builder(
                    shrinkWrap: true,
                    itemCount: snapshot.data?.docs.length,
                    itemBuilder: (context,index) {
                      return Card(
                        elevation: 5,
                        child: ListTile(
                          leading: Text("Name: ${snapshot.data!.docs[index]['name']}"),
                          title: Text("Age: ${snapshot.data!.docs[index]['age']}"),
                          trailing: Text("City: ${snapshot.data!.docs[index]['city']}"),
                        ),
                      );
                    }),
              ],
            );
          },
        ) : isAge ?
        StreamBuilder(
          stream: FirebaseFirestore.instance.collection("Person").orderBy('age').snapshots(),
          builder: (context,snapshot){
            if(!snapshot.hasData) {
              return Center(child: CircularProgressIndicator(),);
            }
            if(snapshot.data!.docs.length == 0) {
              return Text("no data");
            }
            return Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    PopupMenuButton(
                        icon: Icon(Icons.sort),
                        itemBuilder: (ctx)=> [
                          PopupMenuItem(
                              onTap: () {
                                setState(() {
                                  isName = !isName;
                                });
                              },
                              child: Row(
                                children: [
                                  Checkbox(
                                      activeColor: Colors.green,
                                      value: isName, onChanged: (value) {
                                    setState(() {
                                      isName = !isName;
                                    });
                                  }),
                                  Text("Sort by Name",
                                    style: TextStyle(color: isName == true ?
                                    Colors.green :Colors.red),),
                                ],
                              )),
                          PopupMenuItem(
                              onTap: () {
                                setState(() {
                                  isAge = !isAge;
                                });
                              },
                              child: Row(
                                children: [
                                  Checkbox(value: isAge,
                                      onChanged: (value) {
                                        setState(() {
                                          isAge = !isAge;
                                        });
                                      }),
                                  Text("Sort by Age",
                                    style: TextStyle(color: isAge == true ?
                                    Colors.green :Colors.red),),
                                ],
                              )),
                          PopupMenuItem(
                              onTap: () {
                                setState(() {
                                  isCity = !isCity;
                                });
                              },
                              child: Row(
                                children: [
                                  Checkbox(value: isCity,
                                      onChanged: (value) {
                                        setState(() {
                                          isCity = !isCity;
                                        });
                                      }),
                                  Text("Sort by City",
                                    style: TextStyle(color: isCity == true ?
                                    Colors.green :Colors.red),),
                                ],
                              ))
                        ])
                  ],
                ),
                ListView.builder(
                    shrinkWrap: true,
                    itemCount: snapshot.data?.docs.length,
                    itemBuilder: (context,index) {
                      return Card(
                        elevation: 5,
                        child: ListTile(
                          leading: Text("Name: ${snapshot.data!.docs[index]['name']}"),
                          title: Text("Age: ${snapshot.data!.docs[index]['age']}"),
                          trailing: Text("City: ${snapshot.data!.docs[index]['city']}"),
                        ),
                      );
                    }),
              ],
            );
          },
        ) : isCity ?
        StreamBuilder(
          stream: FirebaseFirestore.instance.collection("Person").orderBy('city').snapshots(),
          builder: (context,snapshot){
            if(!snapshot.hasData) {
              return Center(child: CircularProgressIndicator(),);
            }
            if(snapshot.data!.docs.length == 0) {
              return Text("no data");
            }
            return Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    PopupMenuButton(
                        icon: Icon(Icons.sort),
                        itemBuilder: (ctx)=> [
                          PopupMenuItem(
                              onTap: () {
                                setState(() {
                                  isName = !isName;
                                });
                              },
                              child: Row(
                                children: [
                                  Checkbox(
                                      activeColor: Colors.green,
                                      value: isName, onChanged: (value) {
                                    setState(() {
                                      isName = !isName;
                                    });
                                  }),
                                  Text("Sort by Name",
                                    style: TextStyle(color: isName == true ?
                                    Colors.green :Colors.red),),
                                ],
                              )),
                          PopupMenuItem(
                              onTap: () {
                                setState(() {
                                  isAge = !isAge;
                                });
                              },
                              child: Row(
                                children: [
                                  Checkbox(value: isAge,
                                      onChanged: (value) {
                                        setState(() {
                                          isAge = !isAge;
                                        });
                                      }),
                                  Text("Sort by Age",
                                    style: TextStyle(color: isAge == true ?
                                    Colors.green :Colors.red),),
                                ],
                              )),
                          PopupMenuItem(
                              onTap: () {
                                setState(() {
                                  isCity = !isCity;
                                });
                              },
                              child: Row(
                                children: [
                                  Checkbox(value: isCity,
                                      onChanged: (value) {
                                        setState(() {
                                          isCity = !isCity;
                                        });
                                      }),
                                  Text("Sort by City",
                                    style: TextStyle(color: isCity == true ?
                                    Colors.green :Colors.red),),
                                ],
                              ))
                        ])
                  ],
                ),
                ListView.builder(
                    shrinkWrap: true,
                    itemCount: snapshot.data?.docs.length,
                    itemBuilder: (context,index) {
                      return Card(
                        elevation: 5,
                        child: ListTile(
                          leading: Text("Name: ${snapshot.data!.docs[index]['name']}"),
                          title: Text("Age: ${snapshot.data!.docs[index]['age']}"),
                          trailing: Text("City: ${snapshot.data!.docs[index]['city']}"),
                        ),
                      );
                    }),
              ],
            );
          },
        ) :
        Visibility(
          visible: isName || isAge || isCity == true ? false : true,
          child: StreamBuilder(
            stream: FirebaseFirestore.instance.collection("Person").snapshots(),
            builder: (context,snapshot){
              if(!snapshot.hasData) {
                return Center(child: CircularProgressIndicator(),);
              }
              if(snapshot.data!.docs.length == 0) {
                return Text("no data");
              }
              return Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      PopupMenuButton(
                          icon: Icon(Icons.sort),
                          itemBuilder: (ctx)=> [
                            PopupMenuItem(
                                onTap: () {
                                  setState(() {
                                    isName = !isName;
                                  });
                                },
                                child: Row(
                                  children: [
                                    Checkbox(
                                        activeColor: Colors.green,
                                        value: isName, onChanged: (value) {
                                      setState(() {
                                        isName = !isName;
                                      });
                                    }),
                                    Text("Sort by Name",
                                      style: TextStyle(color: isName == true ?
                                      Colors.green :Colors.red),),
                                  ],
                                )),
                            PopupMenuItem(
                                onTap: () {
                                  setState(() {
                                    isAge = !isAge;
                                  });
                                },
                                child: Row(
                                  children: [
                                    Checkbox(value: isAge,
                                        onChanged: (value) {
                                          setState(() {
                                            isAge = !isAge;
                                          });
                                        }),
                                    Text("Sort by Age",
                                      style: TextStyle(color: isAge == true ?
                                      Colors.green :Colors.red),),
                                  ],
                                )),
                            PopupMenuItem(
                                onTap: () {
                                  setState(() {
                                    isCity = !isCity;
                                  });
                                },
                                child: Row(
                                  children: [
                                    Checkbox(value: isCity,
                                        onChanged: (value) {
                                          setState(() {
                                            isCity = !isCity;
                                          });
                                        }),
                                    Text("Sort by City",
                                      style: TextStyle(color: isCity == true ?
                                      Colors.green :Colors.red),),
                                  ],
                                ))
                          ])
                    ],
                  ),
                  ListView.builder(
                      shrinkWrap: true,
                      itemCount: snapshot.data?.docs.length,
                      itemBuilder: (context,index) {
                        return Card(
                          elevation: 5,
                          child: ListTile(
                            leading: Text("Name: ${snapshot.data!.docs[index]['name']}"),
                            title: Text("Age: ${snapshot.data!.docs[index]['age']}"),
                            trailing: Text("City: ${snapshot.data!.docs[index]['city']}"),
                          ),
                        );
                      }),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
