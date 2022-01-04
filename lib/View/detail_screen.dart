import 'package:covid_tracker/View/world_states.dart';
import 'package:flutter/material.dart';

class Detailpage extends StatefulWidget {
  final String name;
  final String image;
  final int totalcases, todayDeaths, todayRecovered, active, critical, test;
  const Detailpage({
    Key? key,
    required this.name,
    required this.image,
    required this.test,
    required this.todayDeaths,
    required this.todayRecovered,
    required this.totalcases,
    required this.active,
    required this.critical,
  }) : super(key: key);

  @override
  _DetailpageState createState() => _DetailpageState();
}

class _DetailpageState extends State<Detailpage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.name),
        centerTitle: true,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Stack(
            children: [
              Padding(
                padding: EdgeInsets.only(
                    top: MediaQuery.of(context).size.height * 0.067),
                child: Card(
                  child: Column(
                    children: [
                      SizedBox(
                        height: MediaQuery.of(context).size.height * .06,
                      ),
                      Reusablerow(
                          value: widget.totalcases.toString(), title: "Cases"),
                      Reusablerow(
                          value: widget.todayDeaths.toString(), title: "Death"),
                      Reusablerow(
                          value: widget.active.toString(), title: "Active"),
                      Reusablerow(
                          value: widget.todayRecovered.toString(),
                          title: "TodayRecovered"),
                      Reusablerow(
                          value: widget.critical.toString(), title: "Critical"),
                    ],
                  ),
                ),
              ),
              CircleAvatar(
                radius: 50,
                backgroundImage: NetworkImage(widget.image),
              )
            ],
          )
        ],
      ),
    );
  }
}
