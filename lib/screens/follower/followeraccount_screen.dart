import 'package:exm_p/datamain.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

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
    debugPrint("ddb Tapped Creator ${firstNames[index]}");
  }

  List<Map<String, dynamic>> pulledSearchData= [];
  final Future<List<Map<String, dynamic>>> searchList = Future<List<Map<String, dynamic>>>(
    () async => await DataMain().getSearchData(),
  );


  @override
  Widget build(BuildContext context){
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
                  return Padding(
                    padding: const EdgeInsets.all(8),
                    child: SearchAnchor(
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
                          final String item = 'Creator $index: ${matchingNames[index]}';
                          return ListTile(
                            title: Text(item),
                            onTap: () {
                              searchItemTapped(index);
                              setState(() {
                                controller.closeView(item);
                              });
                            },
                          );
                        });
                      },
                    )
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