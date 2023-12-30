// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, sort_child_properties_last, curly_braces_in_flow_control_structures, avoid_print, non_constant_identifier_names

import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: MainPage(),
    );
  }
}

class MainPage extends StatefulWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  State<MainPage> createState() => MainPageState();
}

class MainPageState extends State<MainPage> {
  List<String> leagueList = [
    "Premier League",
    "Bundesliga",
    "Ligue 1",
    "Serie A",
    "Süper Lig",
  ];

  List<dynamic> teamList = [];
  List<dynamic> sideList = ["Home", "Away"];

  bool showTeams = false;
  bool showLeagues = false;
 
  bool first_team_search = true;

  static String teamText = "Show Teams";
  static String leagueText = "Show Leagues";
  static String teamsideText = "Side";

  static String sidetext = "";

  String league = "";

  static List<dynamic> team_win_list = [];
  static List<dynamic> team_win_list_count = [];

  static List<dynamic> team_first_half = [];
  static List<dynamic> team_first_half_count = [];

  static List<dynamic> team_second_half = [];
  static List<dynamic> team_second_half_count = [];

  static List<dynamic> team_total = [];
  static List<dynamic> team_total_count = [];

  Future<void> team_request1() async {
    try {
      final response10 = await http.post(
        Uri.parse(
            'http://127.0.0.1:50162/team_report'), // Sunucu URL'si buraya gelmeli
      );

      if (response10.statusCode == 200) {
        // Sunucudan başarılı cevap alındıysa burada işlemleri yapabilirsiniz
        print('Data1 sent successfully babba');
        team_report1(json.decode(response10.body));
      } else {
        print('Request failed with staagagtus: ${response10.statusCode}');
      }
    } catch (e) {
      print('Error: $e');
    }
  }

  Future<void> team_request2() async {
    try {
      final response20 = await http.post(
        Uri.parse(
            'http://127.0.0.1:50162/team_report2'), // Sunucu URL'si buraya gelmeli
      );
      print("uhu");
      if (response20.statusCode == 200) {
        // Sunucudan başarılı cevap alındıysa burada işlemleri yapabilirsiniz
        team_report2(json.decode(response20.body));
      } else {
        print('Request failed with staagagtus: ${response20.statusCode}');
      }
    } catch (e) {
      print('Error: $e');
    }
  }

  Future<void> team_request3() async {
    try {
      // Göndermek istediğiniz veri

      final response30 = await http.post(
        Uri.parse(
            'http://127.0.0.1:50162/team_report3'), // Sunucu URL'si buraya gelmeli
      );
      print("uhu");
      if (response30.statusCode == 200) {
        // Sunucudan başarılı cevap alındıysa burada işlemleri yapabilirsiniz
        team_report3(json.decode(response30.body));
      } else {
        print('Request failed with staagagtus: ${response30.statusCode}');
      }
    } catch (e) {
      print('Error: $e');
    }
  }

  Future<void> team_request4() async {
    try {
      final response40 = await http.post(
        Uri.parse(
            'http://127.0.0.1:50162/team_report4'), // Sunucu URL'si buraya gelmeli
      );
      print("uhu");
      if (response40.statusCode == 200) {
        // Sunucudan başarılı cevap alındıysa burada işlemleri yapabilirsiniz
        team_report4(json.decode(response40.body));
      } else {
        print('Request failed with staagagtus: ${response40.statusCode}');
      }
    } catch (e) {
      print('Error: $e');
    }
  }

  void team_report1(Map<String, dynamic> data) {
    print("teamreport 1 is okey ");

    team_win_list = data["winner"].values.toList();
    team_win_list_count = data["count"].values.toList();
  }

  void team_report2(Map<String, dynamic> data) {
    if (teamsideText == "Home") {
      team_first_half = data["first_half_home"].values.toList();
      team_first_half_count = data["count"].values.toList();
    } else if (teamsideText == "Away") {
      team_first_half = data["first_half_away"].values.toList();
      team_first_half_count = data["count"].values.toList();
    }
  }

  void team_report3(Map<String, dynamic> data) {
    if (teamsideText == "Home") {
      team_second_half = data["second_half_home"].values.toList();
      team_second_half_count = data["count"].values.toList();
    } else if (teamsideText == "Away") {
      team_second_half = data["second_half_away"].values.toList();
      team_second_half_count = data["count"].values.toList();
    }
  }

  void team_report4(Map<String, dynamic> data) {
    if (teamsideText == "Home") {
      team_total = data["total_scored_home"].values.toList();
      team_total_count = data["count"].values.toList();
    } else if (teamsideText == "Away") {
      team_total = data["total_scored_away"].values.toList();
      team_total_count = data["count"].values.toList();
    }
  }

  Future<void> send_request() async {
    try {
      // Göndermek istediğiniz veri
      Map<String, String> data = {
        'leauge_name': leagueText,
      };

      final response = await http.post(
        Uri.parse(
            'http://127.0.0.1:50162/leauge_list'), // Sunucu URL'si buraya gelmeli
        body: data, // Gönderilecek veri burada belirtiliyor
      );

      if (response.statusCode == 200) {
        // Sunucudan başarılı cevap alındıysa burada işlemleri yapabilirsiniz
        print('Data sent successfully babba');

        process_team_names(json.decode(response.body)["llist"]);
      } else {
        print('Request failed with staagagtus: ${response.statusCode}');
      }
    } catch (e) {
      print('Error: $e');
    }
  }

  Future<void> send_request2() async {
    try {
      // Göndermek istediğiniz veri
      Map<String, String> data = {
        'leauge_name': leagueText,
        "team_name": teamText,
        "team_side": teamsideText,
      };

      final response = await http.post(
        Uri.parse(
            'http://127.0.0.1:50162/team_request'), // Sunucu URL'si buraya gelmeli
        body: data, // Gönderilecek veri burada belirtiliyor
      );

      if (response.statusCode == 200) {
        // Sunucudan başarılı cevap alındıysa burada işlemleri yapabilirsiniz
        print('Data sent successfully babba');
      } else {
        print('Request failed with staagagtus: ${response.statusCode}');
      }
    } catch (e) {
      print('Error: $e');
    }
  }

  void process_team_names(List<dynamic> jlist) {
    // teamList = jlist;
    setState(() {
      // js_data = data["count"].toString();
      teamList = jlist;
    });

    }
  void check_team(List<dynamic> tlist , String tname){
    print(tlist);
    print(tname);
  
    print("condition ");
    if (tlist.contains(tname))
      {
        print("team is in the lig");
      }
    else
      { 
        print("nooo team is not in the league");
      }
    }
  
 

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage("images/bg3.jpg"),
            fit: BoxFit.cover,
          ),
        ),
        child: Center(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(0, 25, 0, 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Padding(
                      padding: EdgeInsets.only(left: 20.0),
                      child: SizedBox(
                        height: 100.0,
                        width: 100.0,
                        child: IconButton(
                          icon: Image.asset('images/bundesliganew.png'),
                          onPressed: () {       
                            leagueText = "Bundesliga";
                            send_request();
                            check_team(teamList,teamText); 
                           },
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 100.0,
                      width: 100.0,
                      child: Padding(
                        padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
                        child: IconButton(
                          icon: Image.asset('images/ligue12.png'),
                          onPressed: () {
                            leagueText = "Ligue 1";
                            send_request();
                            check_team(teamList,teamText);
                           },
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(right: 20.0),
                      child: SizedBox(
                        height: 100.0,
                        width: 100.0,
                        child: IconButton(
                          icon: Image.asset('images/premier-league2.png'),
                          onPressed: () {
                            
                            leagueText = "Premier League";
                            send_request();
                            check_team(teamList,teamText);
                    
                          },
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment
                        .spaceBetween, // Ya da istediğiniz diğer bir alignment değeri
                    children: [
                      Padding(
                        padding: EdgeInsets.only(left: 80),
                        child: SizedBox(
                          height: 100.0,
                          width: 100.0,
                          child: IconButton(
                            icon: Image.asset('images/seriea2.png'),
                            onPressed: () {
                              
                              leagueText = "Serie A";
                              send_request();
                              check_team(teamList,teamText);
                            },
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(right: 60),
                        child: SizedBox(
                          height: 100.0,
                          width: 100.0,
                          child: IconButton(
                            icon: Image.asset('images/superlig3.png'),
                            onPressed: () {
                          
                              leagueText = "Süper Lig";
                              send_request();
                              check_team(teamList,teamText);
                            },
                          ),
                        ),
                      ),
                    ],
                  ),
                  if (leagueText != "Show Leagues" && teamText != "Show Teams")
                    Padding(
                      padding: const EdgeInsets.fromLTRB(0, 40, 0, 0),
                      child: Center(
                        child: Text(
                          leagueText + "    -->     " + teamText,
                          maxLines: 3,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                              color: Colors.grey[350],
                              fontWeight: FontWeight.w900,
                              fontStyle: FontStyle.italic,
                              fontFamily: 'Open Sans',
                              fontSize: 20),
                        ),
                      ),
                    ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(0, 70, 0, 0),
                    child: ElevatedButton(
                      onPressed: () {
                        setState(() {
                          showTeams = !showTeams;
                        });
                      },
                      child:
                          Text(teamText, style: TextStyle(color: Colors.white)),
                      style: ElevatedButton.styleFrom(
                        minimumSize: Size(200, 40),
                        backgroundColor: Colors.orange,
                      ),
                    ),
                  ),
                ],
              ),
              if (showTeams)
                Expanded(
                  child: Material(
                    child: ListView.builder(
                      shrinkWrap: true,
                      physics:
                          ClampingScrollPhysics(), // veya NeverScrollableScrollPhysics()
                      itemCount: teamList.length,
                      itemBuilder: (context, index) {
                        final team = teamList[index];
                        return ListTile(
                          title: Text(team),
                          onTap: () {
                            setState(() {
                              
                              teamText = team;
                              teamsideText = "Side";
                              showTeams = false;
                            });
                          },
                        );
                      },
                    ),
                  ),
                ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Padding(
                    padding: EdgeInsets.only(right: 10.0),
                    child: SizedBox(
                      height: 100.0,
                      width: 100.0,
                      child: IconButton(
                        icon: Icon(
                          Icons.home,
                          color: Colors.black,
                          size: 34.0,
                          semanticLabel:
                              'Text to announce in accessibility modes',
                        ),
                        onPressed: () {

                          setState(() {
                            teamsideText = "Home";
                          });
                           
                           send_request2();
                          team_request1();
                          team_request2();
                          team_request3();
                          team_request4();
                        },
                      ),
                    ),
                  ),
                  Text(teamsideText),
                  Padding(
                    padding: EdgeInsets.only(right: 10.0),
                    child: SizedBox(
                        height: 100.0,
                        width: 100.0,
                        child: IconButton(
                          icon: Icon(
                            Icons.airplanemode_active,
                            color: Colors.black,
                            size: 34.0,
                            semanticLabel:
                                'Text to announce in accessibility modes',
                          ),
                          onPressed: () {
                
                            setState(() {
                            teamsideText = "Away";
                          });
                             send_request2();
                            team_request1();
                            team_request2();
                            team_request3();
                            team_request4();
                          },
                        )),
                  ),
                ],
              ),
           
              Padding(
                padding: EdgeInsets.fromLTRB(0, 30, 0, 0),
                child: ElevatedButton(
                  onPressed: () {
                    //send_request();
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => LeaugePage()),
                    );
                  },
                  child: Text('Leauge Report',
                      style: TextStyle(color: Colors.white)),
                  style: ElevatedButton.styleFrom(
                    minimumSize: Size(200, 40),
                    backgroundColor: Color.fromRGBO(255, 103, 0, 1),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.fromLTRB(0, 30, 0, 0),
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => TeamPage()),
                    );
                  },
                  child: Text(
                    'Team Report',
                    style: TextStyle(color: Colors.white),
                  ),
                  style: ElevatedButton.styleFrom(
                      minimumSize: Size(200, 40),
                      backgroundColor: Color.fromRGBO(255, 103, 0, 1)),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class LeaugePage extends StatefulWidget {
  @override
  LeaugePageState createState() => LeaugePageState();
}

class LeaugePageState extends State<LeaugePage> {
  String js_data = "";
  String leauge_name = MainPageState.leagueText;

  List<dynamic> season_list = [];
  List<dynamic> match_number_list = [];

  List<dynamic> winner_side = [];
  List<dynamic> winner_side_count = [];

  List<dynamic> match_score_list = [];
  List<dynamic> match_score_count = [];

  List<dynamic> total_goal_list = [];
  List<dynamic> total_goal_count = [];

  // Veriyi asenkron olarak getir ve widget'ın durumunu güncelle
  fetchData() async {
    try {
      final response = await http
          .get(Uri.parse('http://127.0.0.1:50162/season_match_count'));

      if (response.statusCode == 200) {
        Map<String, dynamic> data = json.decode(response.body);
        processData(data);
      }
    } catch (e) {
      print('Hata oluştu: $e');
    }
  }

  fetchData2() async {
    try {
      final response2 =
          await http.get(Uri.parse('http://127.0.0.1:50162/side_winner_count'));

      if (response2.statusCode == 200) {
        Map<String, dynamic> data = json.decode(response2.body);
        processData2(data);
      }
    } catch (e) {
      print('Hata oluştu: $e');
    }
  }

  fetchData3() async {
    try {
      final response3 =
          await http.get(Uri.parse('http://127.0.0.1:50162/match_score_count'));

      if (response3.statusCode == 200) {
        Map<String, dynamic> data = json.decode(response3.body);
        processData3(data);
      }
    } catch (e) {
      print('Hata oluştu: $e');
    }
  }

  fetchData4() async {
    try {
      final response4 =
          await http.get(Uri.parse('http://127.0.0.1:50162/total_goal_count'));

      if (response4.statusCode == 200) {
        Map<String, dynamic> data = json.decode(response4.body);
        processData4(data);
      }
    } catch (e) {
      print('Hata oluştu: $e');
    }
  }

  void processData(Map<String, dynamic> data) {
    season_list = data["season"].values.toList();
    match_number_list = data["count"].values.toList();
  }

  void processData2(Map<String, dynamic> data) {
    winner_side = data["winner"].values.toList();
    winner_side_count = data["count"].values.toList();
  }

  void processData3(Map<String, dynamic> data) {
    match_score_list = data["match_score"].values.toList().take(10).toList();
    match_score_count = data["count"].values.toList().take(10).toList();
  }

  void processData4(Map<String, dynamic> data) {
    total_goal_list = data["total_goal"].values.toList();
    total_goal_count = data["count"].values.toList();
    setState(() {
      // js_data = data["count"].toString();
    });
  }

  @override
  void initState() {
    super.initState();
    fetchData(); // Call your data fetching functions here
    fetchData2();
    fetchData3();
    fetchData4();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        backgroundColor: Color.fromRGBO(254, 220, 252, 1),
        appBar: AppBar(
          title: Text('Home'),
          backgroundColor: Color.fromRGBO(175, 252, 241, 0.7),
          leading: IconButton(
            icon: Icon(Icons.arrow_back), // Geri dönme ikonu
            onPressed: () {
              Navigator.of(context).pop(); // Geri dönme işlemi
            },
          ),
        ),
        body: Center(
          child: ListView(
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(height: 40),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(0, 0, 0, 80),
                    child: Text(
                      "$leauge_name Stats",
                      style: TextStyle(
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                        color: Colors.black87,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(20, 0, 0, 0),
                    child: Text(
                      "Seasons - Match Number",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.black87,
                      ),
                    ),
                  ),
                  // Bar grafiği widget'ı
                  // Grafikler
                  Padding(
                    padding: const EdgeInsets.fromLTRB(0, 15, 35, 80),
                    child: Container(
                      width: 300,
                      height: 250,
                      child: BarChart(
                        BarChartData(
                          maxY: 500,
                          minY: 100,
                          alignment: BarChartAlignment.center,
                          borderData: FlBorderData(show: true),
                          titlesData: FlTitlesData(
                            topTitles: SideTitles(showTitles: false),
                            rightTitles: SideTitles(showTitles: false),
                            bottomTitles: SideTitles(
                              showTitles: true,
                              getTitles: (value) {
                                // String x eksen değerlerini döndür
                                if (value.toInt() >= 0 &&
                                    value.toInt() < season_list.length) {
                                  return season_list[value.toInt()];
                                }
                                return '';
                              },
                              rotateAngle: 60, // X eksenini 90 derece döndürür
                            ),
                          ),
                          barGroups: List.generate(
                            match_number_list.length,
                            (index) => BarChartGroupData(
                              x: index,
                              barRods: [
                                BarChartRodData(
                                  y: match_number_list[index].toDouble(),
                                  colors: [Colors.black],
                                  width: 24,
                                  borderRadius: BorderRadius.circular(0),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),

                  Padding(
                    padding: const EdgeInsets.fromLTRB(10, 0, 0, 0),
                    child: Text(
                      "Side - Result",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.black87,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(0, 15, 35, 80),
                    child: Container(
                      width: 300,
                      height: 250,
                      child: Container(
                        child: BarChart(
                          BarChartData(
                            maxY: 600,
                            minY: 100,
                            alignment: BarChartAlignment.center,
                            borderData: FlBorderData(
                                show: true), //sınırlar için dikdörtgen
                            titlesData: FlTitlesData(
                              topTitles: SideTitles(showTitles: false),
                              rightTitles: SideTitles(showTitles: false),
                              bottomTitles: SideTitles(
                                showTitles: true,
                                getTitles: (value) {
                                  // String x eksen değerlerini döndür
                                  if (value.toInt() >= 0 &&
                                      value.toInt() < winner_side.length) {
                                    return winner_side[value.toInt()];
                                  }
                                  return '';
                                },
                                rotateAngle:
                                    60, // X eksenini 90 derece döndürür
                              ),
                            ), // Sağdaki değerleri gizle),
                            barGroups: List.generate(
                              winner_side
                                  .length, // side_list in eleman sayısı kadar çubuk
                              (index) => BarChartGroupData(
                                x: index,
                                barRods: [
                                  BarChartRodData(
                                    y: winner_side_count[index].toDouble(),
                                    colors: [Colors.black],
                                    width: 24, // Çubuk genişliği artırıldı
                                    borderRadius: BorderRadius.circular(0),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(10, 0, 0, 0),
                    child: Text(
                      "Match Score - Match Number",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.black87,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(0, 15, 35, 80),
                    child: Container(
                      width: 300,
                      height: 250,
                      child: Container(
                        child: BarChart(
                          BarChartData(
                            maxY: 120,
                            minY: 0,
                            alignment: BarChartAlignment.center,
                            borderData: FlBorderData(
                                show: true), //sınırlar için dikdörtgen
                            titlesData: FlTitlesData(
                              topTitles: SideTitles(showTitles: false),
                              rightTitles: SideTitles(showTitles: false),
                              bottomTitles: SideTitles(
                                showTitles: true,
                                getTitles: (value) {
                                  // String x eksen değerlerini döndür
                                  if (value.toInt() >= 0 &&
                                      value.toInt() < match_score_list.length) {
                                    return match_score_list[value.toInt()];
                                  }
                                  return '';
                                },
                                rotateAngle:
                                    60, // X eksenini 90 derece döndürür
                              ),
                            ), // Sağdaki değerleri gizle),

                            barGroups: List.generate(
                              match_score_list
                                  .length, // side_list in eleman sayısı kadar çubuk
                              (index) => BarChartGroupData(
                                x: index,
                                barRods: [
                                  BarChartRodData(
                                    y: match_score_count[index].toDouble(),
                                    colors: [Colors.black],
                                    width: 8, // Çubuk genişliği artırıldı
                                    borderRadius: BorderRadius.circular(0),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(10, 0, 0, 0),
                    child: Text(
                      "Total Goal - Match Number",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.black87,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(0, 15, 35, 80),
                    child: Container(
                      width: 300,
                      height: 250,
                      child: Container(
                        child: BarChart(
                          BarChartData(
                            maxY: 300,
                            minY: 0,
                            alignment: BarChartAlignment.center,
                            borderData: FlBorderData(
                                show: true), //sınırlar için dikdörtgen
                            titlesData: FlTitlesData(
                                rightTitles: SideTitles(showTitles: false),
                                topTitles: SideTitles(
                                    showTitles:
                                        false)), // Sağdaki değerleri gizle),
                            barGroups: List.generate(
                              total_goal_list
                                  .length, // side_list in eleman sayısı kadar çubuk
                              (index) => BarChartGroupData(
                                x: index,
                                barRods: [
                                  BarChartRodData(
                                    y: total_goal_count[index].toDouble(),
                                    colors: [Colors.black],
                                    width: 8, // Çubuk genişliği artırıldı
                                    borderRadius: BorderRadius.circular(0),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class TeamPage extends StatefulWidget {
  @override
  TeamPageState createState() => TeamPageState();
}

class TeamPageState extends State<TeamPage> {
  String team_name = MainPageState.teamText;
  String team_side = MainPageState.teamsideText;

  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color.fromRGBO(254, 220, 252, 1),
        appBar: AppBar(
          title: Text('Eternal Sucuk'),
          backgroundColor: Color.fromRGBO(175, 252, 241, 0.7),
          leading: IconButton(
            icon: Icon(Icons.arrow_back), // Geri dönme ikonu
            onPressed: () {
              Navigator.of(context).pop(); // Geri dönme işlemi
            },
          ),
        ),
        body: Center(
          child: ListView(
            children: [
              Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.fromLTRB(0, 30, 0, 20),
                    child: Text(
                      "$team_name $team_side Stats",
                      style: TextStyle(
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                        color: Colors.black87,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(20, 30, 0, 0),
                    child: Text(
                      "Side - Winner Count",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.black87,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(0, 15, 35, 80),
                    child: Container(
                      width: 300,
                      height: 250,
                      child: BarChart(
                        BarChartData(
                          maxY: 50,
                          minY: 0,
                          alignment: BarChartAlignment.center,
                          borderData: FlBorderData(show: true),
                          titlesData: FlTitlesData(
                            topTitles: SideTitles(showTitles: false),
                            rightTitles: SideTitles(showTitles: false),
                            bottomTitles: SideTitles(
                              showTitles: true,
                              getTitles: (value) {
                                // String x eksen değerlerini döndür
                                if (value.toInt() >= 0 &&
                                    value.toInt() <
                                        MainPageState.team_win_list.length) {
                                  return MainPageState
                                      .team_win_list[value.toInt()];
                                }
                                return '';
                              },
                              rotateAngle: 60, // X eksenini 90 derece döndürür
                            ),
                          ),
                          barGroups: List.generate(
                            MainPageState.team_win_list_count.length,
                            (index) => BarChartGroupData(
                              x: index,
                              barRods: [
                                BarChartRodData(
                                  y: MainPageState.team_win_list_count[index]
                                      .toDouble(),
                                  colors: [Color.fromARGB(210, 232, 110, 1)],
                                  width: 30,
                                  borderRadius: BorderRadius.circular(0),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(20, 0, 0, 0),
                    child: Text(
                      "First Half  $team_name Scored",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: const Color.fromARGB(221, 0, 0, 0),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(0, 15, 35, 80),
                    child: Container(
                      width: 300,
                      height: 250,
                      child: Container(
                        child: BarChart(
                          BarChartData(
                            maxY: 50,
                            minY: 0,
                            alignment: BarChartAlignment.center,
                            borderData: FlBorderData(
                                show: true), //sınırlar için dikdörtgen
                            titlesData: FlTitlesData(
                                rightTitles: SideTitles(showTitles: false),
                                topTitles: SideTitles(
                                    showTitles:
                                        false)), // Sağdaki değerleri gizle),
                            barGroups: List.generate(
                              MainPageState.team_first_half
                                  .length, // side_list in eleman sayısı kadar çubuk
                              (index) => BarChartGroupData(
                                x: index,
                                barRods: [
                                  BarChartRodData(
                                    y: MainPageState
                                        .team_first_half_count[index]
                                        .toDouble(),
                                    colors: [Color.fromARGB(210, 232, 110, 1)],
                                    width: 20, // Çubuk genişliği artırıldı
                                    borderRadius: BorderRadius.circular(0),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(20, 0, 0, 0),
                    child: Text(
                      "Second Half  $team_name Scored",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Color.fromARGB(255, 0, 0, 0),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(0, 15, 35, 80),
                    child: Container(
                      width: 300,
                      height: 250,
                      child: Container(
                        child: BarChart(
                          BarChartData(
                            maxY: 50,
                            minY: 0,
                            alignment: BarChartAlignment.center,
                            borderData: FlBorderData(
                                show: true), //sınırlar için dikdörtgen
                            titlesData: FlTitlesData(
                                rightTitles: SideTitles(showTitles: false),
                                topTitles: SideTitles(
                                    showTitles:
                                        false)), // Sağdaki değerleri gizle),
                            barGroups: List.generate(
                              MainPageState.team_second_half
                                  .length, // side_list in eleman sayısı kadar çubuk
                              (index) => BarChartGroupData(
                                x: index,
                                barRods: [
                                  BarChartRodData(
                                    y: MainPageState
                                        .team_second_half_count[index]
                                        .toDouble(),
                                    colors: [Color.fromARGB(210, 232, 110, 1)],
                                    width: 20, // Çubuk genişliği artırıldı
                                    borderRadius: BorderRadius.circular(0),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(20, 0, 0, 0),
                    child: Text(
                      "Total  $team_name Scored",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.black87,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(0, 15, 35, 80),
                    child: Container(
                      width: 300,
                      height: 250,
                      child: Container(
                        child: BarChart(
                          BarChartData(
                            maxY: 50,
                            minY: 0,
                            alignment: BarChartAlignment.center,
                            borderData: FlBorderData(
                                show: true), //sınırlar için dikdörtgen
                            titlesData: FlTitlesData(
                                rightTitles: SideTitles(showTitles: false),
                                topTitles: SideTitles(
                                    showTitles:
                                        false)), // Sağdaki değerleri gizle),
                            barGroups: List.generate(
                              MainPageState.team_total
                                  .length, // side_list in eleman sayısı kadar çubuk
                              (index) => BarChartGroupData(
                                x: index,
                                barRods: [
                                  BarChartRodData(
                                    y: MainPageState.team_total_count[index]
                                        .toDouble(),
                                    colors: [Color.fromARGB(210, 232, 110, 1)],
                                    width: 20, // Çubuk genişliği artırıldı
                                    borderRadius: BorderRadius.circular(0),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ));
  }
}
