import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:water_tracker/tracker.dart';
class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}
class _HomeScreenState extends State<HomeScreen> {
  final TextEditingController _glassNoTEcontroller = TextEditingController(
      text: '1');
  List<WaterTracker> waterTrackerList = [];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Water Tracker'),
        centerTitle: true,
        backgroundColor: Colors.teal,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Text(
              getTotalNoOfGlasses().toString(),
            ),
            const Text('Glass/s', style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 16,
            ),),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                    width: 50,
                    child: TextField(
                      textAlign: TextAlign.center,
                      controller: _glassNoTEcontroller,
                      keyboardType: TextInputType.number,
                    )),
                TextButton(onPressed: _addNewGlass,
                    child: Text('Add', style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 24,
                    ),)),
              ],
            ),
            Expanded(child:
            ListView.separated(
              itemCount: waterTrackerList.length,
              itemBuilder: (context, index) {
                final WaterTracker waterTracker = waterTrackerList[index];
                return ListTile(
                  title: Text(
                      '${waterTracker.dateTime.hour}:${waterTracker.dateTime
                          .minute}'),
                  subtitle: Text(
                      '${waterTracker.dateTime.day}/${waterTracker.dateTime
                          .month}/${waterTracker.dateTime.year}'),
                  leading: CircleAvatar(
                      child: Text('${waterTracker.noOfGlasses}')),
                  trailing: IconButton(
                    onPressed:
                        () {
                      _deleteGlases(index);
                    },
                    icon: Icon(Icons.delete),
                  ),
                );
              },
              separatorBuilder: (context, index) {
                return Divider(thickness: 5.0,);
              },
            )
            )
          ],
        ),
      ),
    );
  }
  void _addNewGlass() {
    if (_glassNoTEcontroller.text.isEmpty) {
      _glassNoTEcontroller.text = '1';
    }
    final int noOfGlasses = int.tryParse(_glassNoTEcontroller.text) ?? 1;

    WaterTracker waterTracker = WaterTracker(
        noOfGlasses: noOfGlasses, dateTime: DateTime.now());
    waterTrackerList.add(waterTracker);
    setState(() {

    });
  }
  void _deleteGlases(int index) {
    waterTrackerList.removeAt(index);
    setState(() {});
  }
  int getTotalNoOfGlasses() {
    int counter = 0;
    for (WaterTracker t in waterTrackerList) {
      counter += t.noOfGlasses;
    }
    return counter;
  }
  @override
  void dispose (){
    _glassNoTEcontroller.dispose();
    super.dispose();


  }
}

