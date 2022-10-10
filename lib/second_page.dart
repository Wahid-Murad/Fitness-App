import 'package:fitness_app/model/model.dart';
import 'package:fitness_app/third_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:sleek_circular_slider/sleek_circular_slider.dart';

class SecondPage extends StatefulWidget {
  SecondPage({Key? key,this.excerciesModel}) : super(key: key);

  ExcerciesModel ? excerciesModel;

  @override
  State<SecondPage> createState() => _SecondPageState();
}

class _SecondPageState extends State<SecondPage> {
  double second=10;
    @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Stack(
        children: [
          Image.network("${widget.excerciesModel!.thumbanil}",
          width: double.infinity,
          height: double.infinity,
          fit: BoxFit.cover,
          ),
          Positioned(
            bottom: 20,
            right: 0,
            left: 0,
            child: Column(
              children: [
                SleekCircularSlider(
                  innerWidget: (value){
                    return Container(
                      alignment: Alignment.center,
                      child: Text("${second.toStringAsFixed(0)} Sec",style: TextStyle(fontSize: 20, color: Colors.white,fontWeight: FontWeight.w600),),
                    );
                  },
    appearance: CircularSliderAppearance(
    customWidths: CustomSliderWidths(progressBarWidth: 10)),
     min: 10,
     max: 100,
     initialValue: second,
     onChange: (value){
      setState(() {
        second=value;
      });
     }
),
      MaterialButton(onPressed: (){
        Navigator.of(context).push(MaterialPageRoute(builder: (context) => ThirdPage(
         excerciesModel: widget.excerciesModel,
         second: second,
        )));   
      },
      color: Colors.orange,
      child:  Text("Start"),
      ),        
        ],
            ),
            ),
        ],
      ),
    );
  }
}
