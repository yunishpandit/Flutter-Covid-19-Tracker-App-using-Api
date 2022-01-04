import 'package:covid_tracker/View/detail_screen.dart';
import 'package:covid_tracker/services/states_services.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class Countrylist extends StatefulWidget {
  const Countrylist({Key? key}) : super(key: key);

  @override
  _CountrylistState createState() => _CountrylistState();
}

class _CountrylistState extends State<Countrylist> {
  TextEditingController searchcontroller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    Stateservices stateservices = Stateservices();
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextFormField(
              controller: searchcontroller,
              onChanged: (value) {
                setState(() {});
              },
              decoration: InputDecoration(
                  contentPadding: const EdgeInsets.symmetric(horizontal: 20),
                  hintText: "Search here with country",
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(40))),
            ),
          ),
          Expanded(
              child: FutureBuilder(
                  future: stateservices.countrieslist(),
                  builder: (context, AsyncSnapshot<List<dynamic>> snapshots) {
                    if (snapshots.hasData) {
                      return ListView.builder(
                          itemCount: snapshots.data!.length,
                          itemBuilder: (context, index) {
                            String name = snapshots.data![index]["country"];
                            if (searchcontroller.text.isEmpty) {
                              return Column(
                                children: [
                                  InkWell(
                                    onTap: () {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) => Detailpage(
                                                  name: name,
                                                  image: snapshots.data![index]
                                                      ["countryInfo"]["flag"],
                                                  test: snapshots.data![index]
                                                      ["tests"],
                                                  todayDeaths: snapshots
                                                      .data![index]["deaths"],
                                                  todayRecovered:
                                                      snapshots.data![index]
                                                          ["todayRecovered"],
                                                  totalcases: snapshots
                                                      .data![index]["cases"],
                                                  active: snapshots.data![index]
                                                      ["active"],
                                                  critical: snapshots.data![index]
                                                      ["critical"])));
                                    },
                                    child: ListTile(
                                      title: Text(
                                          snapshots.data![index]["country"]),
                                      subtitle: Text(snapshots.data![index]
                                              ["cases"]
                                          .toString()),
                                      leading: Image(
                                          height: 50,
                                          width: 50,
                                          image: NetworkImage(
                                              snapshots.data![index]
                                                  ["countryInfo"]["flag"])),
                                    ),
                                  )
                                ],
                              );
                            } else if (name.toLowerCase().contains(
                                searchcontroller.text.toLowerCase())) {
                              return Column(
                                children: [
                                  InkWell(
                                    onTap: () {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) => Detailpage(
                                                  name: name,
                                                  image: snapshots.data![index]
                                                      ["countryInfo"]["flag"],
                                                  test: snapshots.data![index]
                                                      ["tests"],
                                                  todayDeaths: snapshots
                                                      .data![index]["deaths"],
                                                  todayRecovered:
                                                      snapshots.data![index]
                                                          ["todayRecovered"],
                                                  totalcases: snapshots
                                                      .data![index]["cases"],
                                                  active: snapshots.data![index]
                                                      ["active"],
                                                  critical: snapshots.data![index]
                                                      ["critical"])));
                                    },
                                    child: ListTile(
                                      title: Text(
                                          snapshots.data![index]["country"]),
                                      subtitle: Text(snapshots.data![index]
                                              ["cases"]
                                          .toString()),
                                      leading: Image(
                                          height: 50,
                                          width: 50,
                                          image: NetworkImage(
                                              snapshots.data![index]
                                                  ["countryInfo"]["flag"])),
                                    ),
                                  )
                                ],
                              );
                            } else {
                              return const SizedBox(
                                height: 0,
                                width: 0,
                              );
                            }
                          });
                    } else {
                      return ListView.builder(
                          itemCount: 7,
                          itemBuilder: (context, index) {
                            return Shimmer.fromColors(
                                child: Column(
                                  children: [
                                    ListTile(
                                        subtitle: Container(
                                          height: 10,
                                          width: 89,
                                          color: Colors.white,
                                        ),
                                        title: Container(
                                          height: 10,
                                          width: 89,
                                          color: Colors.white,
                                        ),
                                        leading: Container(
                                          height: 50,
                                          width: 50,
                                          color: Colors.white,
                                        ))
                                  ],
                                ),
                                baseColor: Colors.grey.shade700,
                                highlightColor: Colors.grey.shade700);
                          });
                    }
                  }))
        ],
      ),
    );
  }
}
