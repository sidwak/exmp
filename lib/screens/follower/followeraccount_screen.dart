import 'package:exm_p/datamain.dart';
import 'package:exm_p/main.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

final GlobalKey<_FollowerAccountScreen> foAcGlobalKey = GlobalKey<_FollowerAccountScreen>();

class FollowerAccountScreen extends StatefulWidget{
  const FollowerAccountScreen({super.key});

  @override
  State<FollowerAccountScreen> createState() => _FollowerAccountScreen();
}

class _FollowerAccountScreen extends State<FollowerAccountScreen>{
  List<String> firstNames = [
    'Anna',
    'Annabelle',
    'Annie',
    'Antonio',
    'Andrew',
    'Angela',
    'Alex',
    'Alice',
    'Albert',
    'Benjamin',
    'Benedict',
    'Bella',
    'Bethany',
    'Beatrice',
    'Brandon',
    'Brian',
    'Barbara',
    'Bianca'
  ];
  List<String> matchingNames = [];

  List<String> filterNames(List<String> names, String searchString) {
    List<String> filteredNames = [];
    for (String name in names) {
      if (name.toLowerCase().startsWith(searchString.toLowerCase())) {
        filteredNames.add(name);
      }
    }
    return filteredNames;
  }

  void onSearchChanged(String searchString){
    matchingNames = filterNames(firstNames, searchString);
  }

  void searchItemTapped(int index){
    debugPrint("ddb Tapped Creator ${pulledSearchData[index]["email"]}");
    debugPrint("ddb Tapped Creator ${pulledSearchData[index]["name"]}");
    dialogBuilder(mainCtx, index);
  }

  Future<void> dialogBuilder (BuildContext cont, int index){
    return showDialog<void>(
      context: cont,
      builder: (BuildContext context) => AlertDialog(
        title: Text('Follow ${pulledSearchData[index]["name"]}?', 
          style: GoogleFonts.nunito(
            fontSize: 22,
            fontWeight: FontWeight.bold,
            color: Theme.of(context).colorScheme.inversePrimary
          ),
        ),
        content: Text('You will start following ${pulledSearchData[index]["name"]}', 
          style: GoogleFonts.nunito(
            fontSize: 17,
            fontWeight: FontWeight.normal,
            color: Theme.of(context).colorScheme.inversePrimary
          ),
        ),
        actions: <Widget>[
          TextButton(
            onPressed: (){
              Navigator.of(context).pop();
              debugPrint("ddb dialogcancel");
            },
            child: Text("Cancel", 
              style: GoogleFonts.nunito(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: Theme.of(context).colorScheme.inversePrimary
              ),
            ),
          ),
          TextButton(
            onPressed: (){             
              DataMain().setFollowerFoData(pulledSearchData[index]["name"], pulledSearchData[index]["name"]);
              Navigator.of(context).pop();
            }, 
            child: Text("Ok", 
              style: GoogleFonts.nunito(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: Theme.of(context).colorScheme.inversePrimary
              ),
            ),
          ),
        ],
      ),
    );
  }

  List<Map<String, dynamic>> pulledSearchData= [];
  final Future<List<Map<String, dynamic>>> searchList = Future<List<Map<String, dynamic>>>(
    () async => await DataMain().getSearchData(),
  );


  late BuildContext mainCtx;

  @override
  Widget build(BuildContext context){
    mainCtx = context;
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        alignment: Alignment.topCenter,
        child: FutureBuilder<List<Map<String, dynamic>>>(
          future: searchList,
          builder: (BuildContext context, AsyncSnapshot<List<Map<String, dynamic>>> snapshot){
            Widget children;
            if (snapshot.hasData){
              firstNames = [];
              pulledSearchData = snapshot.data!;
              for (var each in pulledSearchData){
                firstNames.add(each["name"]);
              }
              children = LayoutBuilder(
                builder: (BuildContext ctx, BoxConstraints constraints){
                  double w = constraints.maxWidth;
                  double h = constraints.maxHeight;
                  return Container(
                    margin: const EdgeInsets.only(top: 100),
                    child: Center(
                      child: Column(
                        children: <Widget>[
                          Container(
                            margin: const EdgeInsets.only(bottom: 20),
                            child: Text("Find Creators", 
                              style: GoogleFonts.nunito(
                                fontSize: 25,
                                fontWeight: FontWeight.bold,
                                color: Theme.of(context).colorScheme.inversePrimary
                              ),
                            )
                          ),
                          Padding(
                            padding: const EdgeInsets.all(20),
                            child: SearchAnchor(
                              //dividerColor: Theme.of(context).colorScheme.background,
                              viewBackgroundColor: Theme.of(context).colorScheme.background,
                              builder: (BuildContext context, SearchController controller){
                                return SearchBar(
                                  controller: controller,
                                  padding: const MaterialStatePropertyAll<EdgeInsets>(
                                    EdgeInsets.symmetric(horizontal: 16.0)),
                                  onTap: (){
                                    controller.openView();
                                  },
                                  onChanged: (_){
                                    controller.openView();
                                  },
                                  leading: const Icon(Icons.search),
                                );
                              },
                              suggestionsBuilder: (BuildContext context, SearchController controller){
                                onSearchChanged(controller.text);
                                int seSize = matchingNames.length;
                                return List<ListTile>.generate(seSize, (int index) {
                                  final String item = matchingNames[index];
                                  return ListTile(
                                      leading: const Icon(Icons.verified, color: Colors.white,),
                                      title: Text(item, 
                                        style: GoogleFonts.nunito(
                                          fontSize: 20,
                                          fontWeight: FontWeight.normal,
                                          color: Theme.of(context).colorScheme.inversePrimary
                                        ),
                                      ),
                                      /* onTap: (){
                                        searchItemTapped(firstNames.indexOf(item));
                                        setState(() {
                                          controller.closeView(item);
                                        });
                                      }, */
                                      onTap: () => dialogBuilder(context, firstNames.indexOf(item)),
                                      tileColor: Theme.of(context).colorScheme.primary,
                                      shape: const Border(
                                          bottom: BorderSide(width: 2),
                                      ),
                                    ); 
                                });
                              },
                            )
                          ),
                        ],
                      ),
                    ),
                  ); 
                },
              );
            }
            else {
              children = const Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                        SizedBox(
                      width: 60,
                      height: 60,
                      child: CircularProgressIndicator(),
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: 16),
                      child: Text('Loading SearchData...'),
                    ),
                  ],
                ),
              );
            }
            return Center(
              child: children,
            );
          }
        )
      )
    );
  }
}