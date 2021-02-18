
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../constant/app_constant.dart';
import '../model/recipe_model.dart';
import 'package:url_launcher/url_launcher.dart';

class RecipeDetails extends StatefulWidget {
  final Result _result;

  RecipeDetails(this._result);

  @override
  State<StatefulWidget> createState() {
      return _RecipeDetails(this._result);
  }

}

class _RecipeDetails extends State<RecipeDetails> {
  PageController Controller = PageController();
  final Result _result;

  _RecipeDetails(this._result);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: PreferredSize(
            child: AppBar(
              brightness: Brightness.light,
              backgroundColor: Colors.white,
              centerTitle: false,
              automaticallyImplyLeading: false,
              flexibleSpace: Padding(
                padding: EdgeInsets.only(left: 31, right: 33, top: 38),
                child: Column(
                  children: <Widget>[

                    Row(
                      children: <Widget>[
                        IconButton(
                            icon: (
                                Icon(
                                  Icons.arrow_back_ios,
                                  color: Theme.of(context).primaryColor,
                                )
                            ),
                            onPressed: (){
                              Navigator.pop(context);
                            }),

                        Expanded(
                          flex: 5,
                          child: Text(
                            _result.title,
                            style: TextStyle(
                                fontSize: 20,
                                fontFamily: "Kanit",
                                fontWeight: FontWeight.w700,
                                fontStyle: FontStyle.italic),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),

              ),


            ),
            preferredSize: Size.fromHeight(100.0)),

        body: PageView(
          controller: Controller,
          scrollDirection: Axis.horizontal,
          children: [
            SingleChildScrollView(
              child: Column(
                children: [
                  Container(
                    width: MediaQuery.of(context).size.width,
                    height: 207,
                    decoration: BoxDecoration(
                        image: DecorationImage(
                            image: Image.network(
                              _result.thumbnail.isEmpty
                                  ? noImageUrl
                                  : _result.thumbnail,
                              height: 80,
                              width: 300,
                            ).image,
                            fit: BoxFit.cover
                        )
                    ),
                  ),
                  SizedBox(height: 29,),
                  Container(
                    padding: EdgeInsets.only(left: 30 , right: 230),
                    width: MediaQuery.of(context).size.width,
                    child: Text(
                      "Les Ingrédients",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  SizedBox(height: 30,),
                  Container(
                      padding: EdgeInsets.only(left: 30 ,right: 15),
                      child: Text(_result.ingredients)
                  ),
                  SizedBox(height: 35,),
                  Padding(
                    padding: EdgeInsets.only(left: 100,right: 100),
                    child:  InkWell(
                          onTap: ()=> _launchURL(_result.href) ,
                      child: Container(
                        width: MediaQuery.of(context).size.width,
                        child: Container(

                          width: 106,
                          height: 20,
                          decoration: BoxDecoration(
                              color: Colors.blue
                          ),
                          child: Text(
                            "plus de détails",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                                fontSize: 14
                            ),

                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 50,)
                ],
              ),
            ),
          ],
        )
    );
  }


}

_launchURL(String url) async {
  if (await canLaunch(url)) {
    await launch(url);
  } else {
    throw 'Could not launch $url';
  }
}