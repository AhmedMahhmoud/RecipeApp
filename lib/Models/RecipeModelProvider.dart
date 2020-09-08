import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:recipe_app/Models/RecipeModel.dart';

import 'package:http/http.dart' as http;
import 'dart:convert';

class RecipeProvider with ChangeNotifier {
  List<RecipeModel> recipess = [];

  List<RecipeModel> get getRecipees {
    return recipess;
  }

  Future<void> fetchRecipesOnline(String searchedName) async {
    final url =
        "https://api.edamam.com/search?q=$searchedName&app_id=1bdca081&app_key=4751f3b69b08388a05d03536b62b0310";
    final response = await http.get(url);
    //Map<String, dynamic> decodeResponse = jsonDecode(response.body);
    //print(json.decode(response.body))
    final decodeResponse = jsonDecode(response.body);
    final List<RecipeModel> loadedRecipes = [];

    decodeResponse['hits'].forEach((value) {
      loadedRecipes.add(
        RecipeModel(
          image: value['recipe']["image"],
          label: value['recipe']["label"],
          source: value['recipe']["source"],
          url: value['recipe']["url"],
        ),
      );
    });

    recipess = loadedRecipes;
    // notifyListeners();
  }
}
