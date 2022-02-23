import 'package:flutter/material.dart';
// import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() => runApp(const MaterialApp(
  home: Home(),
));


class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  _Home createState() => _Home();
}

class _Home extends State<Home> {
  TimeOfDay selectedTime = TimeOfDay.now();
  String lastMeal = "";

  @override
  void initState() {
    super.initState();
    setInitLastMeal();
  }

  @override
  Widget build(BuildContext context) {
    return(Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.red[600],
        centerTitle: true,
        leading: IconButton(
          onPressed: () {},
          icon: const Icon(
            Icons.menu,
          ),
        ),
        title: const Text('Meal tracker'),
        actions: <Widget>[
          IconButton(
              onPressed: () {},
              icon: const Icon(
                  Icons.search
              )
          )
        ],
      ),
      body: Column(
        children: <Widget>[
          Expanded(
            child: Container(
              decoration: const BoxDecoration(
                color: Colors.amber,
                borderRadius: BorderRadius.all(Radius.circular(10.0)),
              ),
              margin: const EdgeInsets.all(5.0),
              child: Row(
                children: <Widget>[
                  Expanded(
                    child: Container(
                      margin: const EdgeInsets.only(left: 20.0),
                      child: Text(
                        lastMeal,
                        style: const TextStyle(fontSize: 40),
                        ),
                    ),
                  ),
                  ElevatedButton(
                    onPressed: () {_selectTime(context);}, child: const Text("Pick Time"),
                  ),
                  const SizedBox(
                    width: 5.0,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
      backgroundColor: const Color.fromARGB(255, 80, 118, 185),
    ));
  }
  void _selectTime(BuildContext context) async {
    selectedTime = TimeOfDay.now();
    TimeOfDay? timeOfDay = await showTimePicker(
      context: context,
      initialTime: selectedTime,
      initialEntryMode: TimePickerEntryMode.dial,
    );
    if(timeOfDay != null)
      {
        SharedPreferences prefs = await SharedPreferences.getInstance();
        prefs.setString("lastMeal", "${timeOfDay.hour}: ${timeOfDay.minute}");
        setState(() {
          lastMeal = "${prefs.getString('lastMeal')}";
        });
      }
  }
  void setInitLastMeal() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      lastMeal = "${prefs.getString('lastMeal')}";
    });
  }
}


