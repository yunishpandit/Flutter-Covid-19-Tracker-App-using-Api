import 'package:covid_tracker/View/country_list.dart';
import 'package:covid_tracker/model/worldstatusmodel.dart';
import 'package:covid_tracker/services/states_services.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:pie_chart/pie_chart.dart';

class Worldstates extends StatefulWidget {
  const Worldstates({Key? key}) : super(key: key);

  @override
  _WorldstatesState createState() => _WorldstatesState();
}

class _WorldstatesState extends State<Worldstates>
    with TickerProviderStateMixin {
  late final AnimationController _animationController =
      AnimationController(duration: const Duration(seconds: 3), vsync: this)
        ..repeat();

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  final colorList = <Color>[
    const Color(0xff4285f4),
    const Color(0xff1aa260),
    const Color(0xffde5246)
  ];
  @override
  Widget build(BuildContext context) {
    Stateservices stateservices = Stateservices();
    return Scaffold(
      body: SafeArea(
          child: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          children: [
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.1,
            ),
            Expanded(
              child: FutureBuilder(
                  future: stateservices.fetchworldstates(),
                  builder: (context, AsyncSnapshot<Covidmodel> snapshots) {
                    if (!snapshots.hasData) {
                      return Expanded(
                          flex: 1,
                          child: SpinKitFadingCircle(
                            color: Colors.white,
                            size: 50,
                            controller: _animationController,
                          ));
                    } else {
                      return SingleChildScrollView(
                        child: Column(
                          children: [
                            PieChart(
                              dataMap: {
                                "Total": double.parse(
                                    snapshots.data!.cases.toString()),
                                "Recovers": double.parse(
                                    snapshots.data!.recovered.toString()),
                                "Deaths": double.parse(
                                    snapshots.data!.deaths.toString())
                              },
                              chartValuesOptions: const ChartValuesOptions(
                                  showChartValuesInPercentage: true),
                              animationDuration:
                                  const Duration(milliseconds: 1200),
                              chartType: ChartType.ring,
                              colorList: colorList,
                              legendOptions: const LegendOptions(
                                  legendPosition: LegendPosition.left),
                              chartRadius:
                                  MediaQuery.of(context).size.width / 3.2,
                            ),
                            Padding(
                              padding: EdgeInsets.symmetric(
                                  vertical: MediaQuery.of(context).size.height *
                                      0.06),
                              child: Card(
                                child: Column(
                                  children: [
                                    Reusablerow(
                                        value: "Total",
                                        title:
                                            snapshots.data!.cases.toString()),
                                    Reusablerow(
                                        value: "Recorvered",
                                        title: snapshots.data!.recovered
                                            .toString()),
                                    Reusablerow(
                                        value: "Deaths",
                                        title:
                                            snapshots.data!.deaths.toString()),
                                    Reusablerow(
                                        value: "Active",
                                        title:
                                            snapshots.data!.active.toString()),
                                    Reusablerow(
                                        value: "TodayDeaths",
                                        title: snapshots.data!.todayDeaths
                                            .toString()),
                                    Reusablerow(
                                        value: "TodayRecovered",
                                        title: snapshots.data!.todayRecovered
                                            .toString()),
                                  ],
                                ),
                              ),
                            ),
                            GestureDetector(
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            const Countrylist()));
                              },
                              child: Container(
                                height: 50,
                                decoration: BoxDecoration(
                                    color: Colors.green,
                                    borderRadius: BorderRadius.circular(10)),
                                child: const Center(
                                  child: Text("Track countries"),
                                ),
                              ),
                            )
                          ],
                        ),
                      );
                    }
                  }),
            ),
          ],
        ),
      )),
    );
  }
}

class Reusablerow extends StatelessWidget {
  final String title, value;
  const Reusablerow({
    Key? key,
    required this.value,
    required this.title,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 10.0, right: 10, top: 10, bottom: 6),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(value),
              Text(title),
            ],
          ),
          const SizedBox(
            height: 5,
          ),
          const Divider()
        ],
      ),
    );
  }
}
