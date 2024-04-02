import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:todoapplication/Detail.dart';
import 'package:provider/provider.dart';
import 'package:todoapplication/listProvider.dart';

void main() {
  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(create: (context)=>TaskListProvider())
    ],
    child: MaterialApp(
      debugShowCheckedModeBanner: false,
      home: const MyApp(),
    ),
  ));
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});
  @override
  State<MyApp> createState() => _MyAppState();
}

bool containerRender = true;
int currentIndex = 0;
List<bool> containerRenderList = List.filled(100, true);
List<bool?> checkList = List.filled(100, false);
Color selectedContainerColor = Colors.deepPurple;
Color defaultContainerColor = Color.fromARGB(255, 177, 122, 221);

class _MyAppState extends State<MyApp> {
  Widget todoContainer(int index,TaskListProvider taskList) {
    containerRenderList[index] = true;
    return Container(
        margin: EdgeInsets.only(bottom: 25),
        height: 65,
        width: 360,
        decoration: BoxDecoration(
            color: checkList[index] == true
                ? selectedContainerColor
                : defaultContainerColor,
            borderRadius: BorderRadius.circular(25)),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Checkbox(
              value: checkList[index],
              activeColor: Colors.purple,
              onChanged: (newBool) {
                setState(() {
                  checkList[index] = newBool;
                });
              },
            ),
            Text(taskList.addTaskList[index]),
            ElevatedButton(
              onPressed: () {
                setState(() {
                  containerRenderList[index] = false;
                  taskList.removeTask(index);
                });
              },
              child: Icon(Icons.delete),
              style: ElevatedButton.styleFrom(
                minimumSize: Size(20, 15),
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20)),
                shadowColor: Color.fromARGB(255, 164, 0, 252),
                backgroundColor: Colors.deepPurple[50],
              ),
            )
          ],
        ),
      );
  }

  Widget searchContainer() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20),
      margin: EdgeInsets.only(bottom: 20),
      height: 50,
      width: 350,
      decoration: BoxDecoration(
          color: Color.fromARGB(255, 192, 174, 223),
          borderRadius: BorderRadius.circular(30)),
      child: const Row(
        children: [
          Padding(
            padding: const EdgeInsets.only(right: 4),
            child: Icon(
              Icons.search_sharp,
              color: Colors.white,
            ),
          ),
          Expanded(
            child: TextField(
              decoration:
                  InputDecoration(hintText: "Search", border: InputBorder.none),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => Detail()),
          );
        },
        backgroundColor: Color.fromARGB(255, 92, 57, 151),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
        child: Icon(
          Icons.add,
          color: Colors.white,
          size: 40,
        ),
      ),
      appBar: AppBar(
        backgroundColor: Colors.deepPurple,
        title: const Text(
          "Sky is the limit",
          style: TextStyle(color: Colors.white),
        ),
        leading: Icon(
          Icons.menu_sharp,
          color: Colors.white,
        ),
        centerTitle: true,
      ),
      body: Consumer<TaskListProvider>(
        builder:((context,TaskListProviderModel,child){ 
          List<String> taskList = List.from(TaskListProviderModel.addTaskList);
          return Container(
          padding: EdgeInsets.all(20),
          height: double.infinity,
          width: double.infinity,
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                searchContainer(),
                for (int i = 0; i <taskList.length; i++)
                  if (containerRenderList[i] == true) todoContainer(i,TaskListProviderModel),
              ],
            ),
          ),
        );}),
      ),
    );
  }
}
