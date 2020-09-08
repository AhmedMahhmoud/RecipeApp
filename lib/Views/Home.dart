import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'dart:convert';
import "../Models/RecipeModelProvider.dart";
import 'package:recipe_app/Models/RecipeModel.dart';
import 'package:recipe_app/Widget/gridView.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  TextEditingController textEditingController = new TextEditingController();

  String appID = "1bdca081";
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  List<RecipeModel> recipes = new List<RecipeModel>();

  //String appKEY = "4751f3b69b08388a05d03536b62b0310";
  // var isloading = false;
  // getRecipes(String searchword) async {
  //   recipes.clear();
  //   String url =
  //       "https://api.edamam.com/search?q=$searchword&app_id=1bdca081&app_key=4751f3b69b08388a05d03536b62b0310";
  //   setState(() {
  //     isloading = true;
  //   });
  //   var respone = await http.get(url);
  //   print(respone.statusCode);
  //   setState(() {
  //     isloading = false;
  //   });
  //   Map<String, dynamic> jsonData = jsonDecode(respone.body);
  //   jsonData["hits"].forEach((value) {
  //     RecipeModel recipeModel = new RecipeModel();

  //     recipeModel = RecipeModel.froma7a(value["recipe"]);
  //     recipes.add(recipeModel);
  //   });
  // }
  var isLoading = false;
  Future<void> fetchRecipesOn(BuildContext context, String searchedName) async {
    setState(() {
      isLoading = true;
    });
    await Provider.of<RecipeProvider>(context, listen: false)
        .fetchRecipesOnline(searchedName);
    setState(() {
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    List<RecipeModel> recipemodel =
        Provider.of<RecipeProvider>(context, listen: false).getRecipees;
    return Scaffold(
        key: _scaffoldKey,
        backgroundColor: Colors.transparent,
        body: Stack(children: [
          SingleChildScrollView(
            child: Container(
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.bottomLeft,
                  stops: [0.0, 0.1],
                  end: Alignment.topRight,
                  colors: [Color(0xff071930), Color(0xff213A50)],
                ),
              ),
            ),
          ),
          Container(
              padding: EdgeInsets.only(
                  top: MediaQuery.of(context).size.height * 0.090, left: 10),
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "HomeMade",
                          style: TextStyle(
                              color: Colors.white, fontWeight: FontWeight.bold),
                        ),
                        Text(
                          "Recipes",
                          style: TextStyle(
                              color: Colors.blue[700],
                              fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 25,
                    ),
                    Text(
                      "What will you cook today?",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 15,
                      ),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Text(
                      "Just enter the ingridents you have and we will show you the best recipe for you ",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 12,
                      ),
                    ),
                    SizedBox(
                      height: 6,
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width,
                      child: Row(
                        children: [
                          Expanded(
                            child: TextField(
                              onChanged: (value) {
                                if (value.isEmpty) {
                                  setState(() {
                                    recipemodel.clear();
                                  });
                                }
                              },
                              style: TextStyle(
                                color: Colors.white,
                              ),
                              controller: textEditingController,
                              decoration: InputDecoration(
                                hintText: "Enter your ingrident here!",
                                hintStyle: TextStyle(
                                    color: Colors.white.withOpacity(0.5),
                                    letterSpacing: 1,
                                    fontSize: 12,
                                    fontStyle: FontStyle.italic),
                              ),
                            ),
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Padding(
                            padding: const EdgeInsets.only(right: 10, top: 20),
                            child: InkWell(
                              onTap: () {
                                if (textEditingController.text.isNotEmpty) {
                                  setState(() {
                                    fetchRecipesOn(
                                        context, textEditingController.text);
                                  });
                                } else {
                                  _scaffoldKey.currentState.showSnackBar(SnackBar(
                                      content: Text(
                                          "Please add an ingredient first")));
                                }
                              },
                              child: Container(
                                  height: 30,
                                  width: 30,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(4),
                                      color: Color(0xffB2874E)),
                                  child: Icon(
                                    Icons.search,
                                    color: Colors.white,
                                  )),
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    //GRIDVIEW//
                    Expanded(
                        child: Container(
                            child: isLoading
                                ? Center(
                                    child: CircularProgressIndicator(
                                      backgroundColor: Colors.red,
                                    ),
                                  )
                                : AnimationLimiter(
                                    child: GridView.builder(
                                        physics: ClampingScrollPhysics(),
                                        scrollDirection: Axis.vertical,
                                        shrinkWrap: true,
                                        padding: EdgeInsets.only(right: 12),
                                        itemCount: recipemodel.length,
                                        gridDelegate:
                                            SliverGridDelegateWithFixedCrossAxisCount(
                                                crossAxisCount: 2,
                                                childAspectRatio: 0.9,
                                                crossAxisSpacing: 10,
                                                mainAxisSpacing: 1),
                                        itemBuilder: (context, index) =>
                                            AnimationConfiguration
                                                .staggeredGrid(
                                              position: index,
                                              duration: const Duration(
                                                  milliseconds: 375),
                                              columnCount: 2,
                                              child: SlideAnimation(
                                                horizontalOffset: 50,
                                                child: FlipAnimation(
                                                  child: GridTilee(
                                                    recipeLabel:
                                                        recipemodel[index]
                                                            .label,
                                                    recipleImage:
                                                        recipemodel[index]
                                                            .image,
                                                    url: recipemodel[index].url,
                                                  ),
                                                ),
                                              ),
                                            )),
                                  )))
                  ]))
        ]));
  }
}
