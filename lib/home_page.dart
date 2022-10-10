import 'dart:convert';
import 'package:fitness_app/model/model.dart';
import 'package:fitness_app/second_page.dart';
import 'package:fitness_app/widget/widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';


class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  List <ExcerciesModel> allData=[];
  String link = "https://raw.githubusercontent.com/codeifitech/fitness-app/master/exercises.json";

  bool isloading = false;
  fetchData() async{
     var response = await http.get(Uri.parse(link)); // API link Hit
    print("Status Code is ${response.statusCode}");
    // print("${response.body}");
    if(response.statusCode==200){
      final item=jsonDecode(response.body); //Decode the API encrypted data
      for( var data in item["exercises"]){ //for in loop
        ExcerciesModel excerciesModel = ExcerciesModel(
          id: data["id"],
          title: data["title"],
          thumbanil: data["thumbnail"],
          gif: data["gif"],
          seconds: data["seconds"],
        );
        setState(() {
          allData.add(excerciesModel);
        });
      }
      // print("Total Length is ${allData.length}");
    }
    else{
      Fluttertoast.showToast(
        msg: "Something is Wrong",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.red,
        textColor: Colors.white,
        fontSize: 16.0
    );
    }
    setState(() {
      isloading = false;
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    fetchData();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Container(
          width: MediaQuery.of(context).size.width,
          child: ListView.builder(
            itemCount: allData.length,
            shrinkWrap: true,
            itemBuilder: (context,index){
              return InkWell(
                onTap: (){
                  Navigator.of(context).push(MaterialPageRoute(builder: (context) => SecondPage(
                    excerciesModel: allData[index],
                  )));
                },
                child: Container(
                  height: 250,
                  margin: EdgeInsets.symmetric(horizontal: 8,vertical: 8),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: Stack(
                      children: [
                        Image.network("${allData[index].thumbanil}", width: double.infinity, fit: BoxFit.cover,),
                        Positioned(
                          bottom: 0,
                          left: 0,
                          right: 0,
                          child: Container(
                            width: double.infinity,
                            height: 65,
                            padding: EdgeInsets.all(12),
                            alignment: Alignment.bottomLeft,
                            child: Text("${allData[index].title}",style: TextStyle(fontSize: 18,color: Colors.white,fontWeight: FontWeight.w700),),
                            decoration: BoxDecoration(
                              gradient: LinearGradient(
                                 begin: Alignment.topCenter,
                                 end: Alignment.bottomCenter,
                              colors: [ Colors.black12,
                              Colors.black54,
                              Colors.black87,
                              Colors.black]),
                            ),
                          ),
                          ),
                          
                      ],
                    ),
                  ),
                ),
              );
            }
            ),
        ),
    );
  }
}