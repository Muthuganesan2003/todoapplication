import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todoapplication/listProvider.dart';

class Detail extends StatefulWidget {
  const Detail({super.key});

  @override
  State<Detail> createState() => _DetailState();
}


String task = "";


class _DetailState extends State<Detail> {
  @override
  Widget build(BuildContext context) {
    return Builder(builder: (context) {
      return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.deepPurple,
          title: const Text(
            "You can do it",
            style: TextStyle(color: Colors.white),
          ),
          leading: GestureDetector(
            onTap: (){
              Navigator.pop(context);
            },
            child: Icon(
              Icons.arrow_back_ios_new_rounded,
              color: Colors.white,
            ),
          ),
          centerTitle: true,
        ),
        body: Consumer<TaskListProvider>(
          builder:((context,TaskListProviderModel,child) {
            
            return Container(
            padding: EdgeInsets.only(top: 30.0),
            height: double.infinity,
            width: double.infinity,
            child: Column(
              children: [
                Container(
                  padding: EdgeInsets.only(left: 15.0, top: 5.0),
                  margin: EdgeInsets.only(bottom: 60),
                  height: 60,
                  width: 350,
                  decoration: BoxDecoration(
                      color: Color.fromARGB(255, 192, 174, 223),
                      borderRadius: BorderRadius.circular(20)),
                  child: TextField(
                    onChanged: (val){
                      setState(() {
                        task = val;
                      });
                    },
                    decoration: InputDecoration(
                        hintText: "Enter the task", border: InputBorder.none),
                  ),
                ),
                ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.deepPurple[200],
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                      minimumSize: Size(50, 50),
                      padding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                    ),
                    onPressed: () {
                        if(task!=""){
                        TaskListProviderModel.addTask(task);
                        }
                        task ="";
                        Navigator.pop(context);
                      
                    },
                    child: Icon(Icons.add, color: Colors.white, size: 40))
              ],
            ),
          );}),
        ),
      );
    });
  }
}



// ElevatedButton(onPressed: (){Navigator.pop(context);}, child:Text("Go back")),