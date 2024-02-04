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

  void pullSearchData(){
    
  }

  @override
  Widget build(BuildContext context){
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        alignment: Alignment.topCenter,
        child: LayoutBuilder(
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
                        setState(() {
                          controller.closeView(item);
                        });
                      },
                    );
                  });
                },
              )
            );
            /* return Container(
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Container(
                      margin: EdgeInsets.only(right: w*0.1, left: w*0.1, top: h*0.05),
                      child: TextField(
                        decoration: InputDecoration(
                          label: Text("Creator Name"),
                          filled: true,
                          prefixIcon: const Icon(Icons.verified_user),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(50.0),
                      )
                        ),
                      )
                    ),
                    Container(
                      color: Colors.amber.shade200,
                      height: h * 0.45,
                      margin: EdgeInsets.only(right: w*0.1, left: w*0.1, top: h*0.025),
                      child: ListView.builder(
                        itemCount: 8,
                        itemBuilder: (BuildContext context, int index){
                          return ListTile(
                            title: Text('Creator ${index+1}'),
                          );
                        }
                      )
                    )
                  ],
                )
              ),
            ); */
          },
        )
      )
    );
  }
}