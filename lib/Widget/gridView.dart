import 'package:flutter/material.dart';
import 'package:recipe_app/Views/WebScreen.dart';

class GridTilee extends StatelessWidget {
  String recipeLabel;
  String recipleImage;
  String url;
  GridTilee({this.recipeLabel, this.recipleImage, this.url});
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => WebScreen(url),
            ));
      },
      child: GridTile(
        header: GridTileBar(
          backgroundColor: Colors.white.withOpacity(0.5),
          title: FittedBox(
            child: Text(
              recipeLabel,
              maxLines: 2,
              style: TextStyle(
                  color: Colors.black,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 1,
                  fontFamily: "OverpassRegular",
                  fontStyle: FontStyle.italic),
            ),
          ),
        ),
        child: FittedBox(
          child: Image.network(
            recipleImage,
            fit: BoxFit.fill,
          ),
        ),
      ),
    );
  }
}
