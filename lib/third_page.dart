import 'dart:async';

import 'package:audioplayers/audioplayers.dart';
import 'package:fitness_app/model/model.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';

class ThirdPage extends StatefulWidget {
   ThirdPage({Key? key,this.excerciesModel,this.second}) : super(key: key);

   ExcerciesModel ? excerciesModel;
   double ? second;

  @override
  State<ThirdPage> createState() => _ThirdPageState();
}

class _ThirdPageState extends State<ThirdPage> {

  AudioPlayer audioPlayer=AudioPlayer();
  AudioCache audioCache=AudioCache();
  late Timer timer;
  bool isComplete=false;
  bool isPlaying=false;
  String path="audio.wav";
  int startSound=0;

  void playAudio() async{
    await audioPlayer.play(AssetSource(path));
    Navigator.of(context).pop();
  }

  @override
  void initState() {
    // TODO: implement initState
    timer=Timer.periodic(Duration(seconds: 1), (timer) {
      if(timer.tick==widget.second!.toInt()){
        timer.cancel();
        setState(() {
          playAudio();
        });
      }
      setState(() {
        startSound=timer.tick;
      });
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Image.network("${widget.excerciesModel!.gif}",
          width: double.infinity,
          height: double.infinity,
          fit: BoxFit.cover,
          ),
          // Text("${widget.second?.toInt()}"),
          Text("${startSound} / ${widget.second!.toStringAsFixed(0)}"),
        ],
      ),
    );
  }
}