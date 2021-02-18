import 'package:flutter/material.dart';
import 'package:helios_test_app/constant/app_constant.dart';
import 'package:helios_test_app/model/recipe_model.dart';
import 'package:helios_test_app/screen/recipe_details.dart';
import 'package:expandable/expandable.dart';



class BuildRecipeSingleItem extends StatelessWidget {
  final Result _result;
  BuildRecipeSingleItem(this._result);
  bool FavorisColorChange = false;

  @override
  Widget build(BuildContext context) {

    return Container(
      width: 300,
      padding: EdgeInsets.symmetric(horizontal: 0.0, vertical: 5.0),
      child: Column(
        children: <Widget>[
          Container(
            width: MediaQuery.of(context).size.width,
            height: 250,
            child: Card(
                clipBehavior: Clip.antiAlias,
                child: InkWell(
                  onTap: (){
                    Navigator.push(context, MaterialPageRoute(builder:
                        (context){
                      return RecipeDetails(this._result);
                    }
                    )
                    );
                  },
                  child: ExpandableNotifier(
                    child: Column(
                      children: <Widget>[
                        Expanded(

                          child: Container(
                            decoration: BoxDecoration(
                              color: Colors.grey,
                              shape: BoxShape.rectangle,
                              image: DecorationImage(
                                  image: Image.network(_result.thumbnail.isEmpty
                                      ? noImageUrl
                                      : _result.thumbnail,
                                  ).image,
                                  fit: BoxFit.cover),
                            ),
                          ),
                        ),
                        ExpandablePanel(
                          header: Padding(
                            padding: EdgeInsets.only(top: 10.0, left: 10),
                            child:
                            Text(
                              _result.title,
                              softWrap: false,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.bold,

                              ),
                            ),
                          ),
                          collapsed: Text(
                            _result.ingredients,
                            style: Theme.of(context).textTheme.body2,
                          ),
                          expanded: Column(
                            children: [
                              Row(
                                children: <Widget>[
                                  Text(
                                    _result.ingredients,
                                    style: TextStyle(
                                        fontSize: 15,
                                        fontWeight: FontWeight.bold
                                    ),
                                  ),
                                ],
                              ),

                              Padding(
                                  padding: EdgeInsets.only(left: 250),
                                  child: Column(
                                    children: [
                                      Visibility(
                                        visible: (FavorisColorChange == false),
                                        child: IconButton(
                                            icon: Icon(
                                              Icons.star_border,
                                              color: Theme.of(context).primaryColor,
                                              size: 40,
                                            ),
                                            onPressed: (){
                                            }
                                        ),
                                      ),

                                    ],
                                  )
                              )
                            ],
                          ),
                          builder: (_, collapsed, expanded) {
                            return Padding(
                              padding:
                              EdgeInsets.only(left: 10.0, right: 10.0, bottom: 10.0),
                              child: Expandable(
                                collapsed: collapsed,
                                expanded: expanded,
                              ),
                            );
                          },
                        ),
                      ],
                    ),
                  ),
                )),
          ),
        ],
      ),

    );
   /* return
       ListTile(
        title:  Text(_result.title),
        subtitle: Text(_result.ingredients),
        leading: Image.network(
          _result.thumbnail.isEmpty
              ? noImageUrl
              : _result.thumbnail,
          height: 80,
          width: 80,
          fit: BoxFit.fitHeight,
        ),
        contentPadding: EdgeInsets.only(top: 16, left: 16, right: 16),
        onTap: (){
          FocusScope.of(context).requestFocus(new FocusNode() );
          Navigator.push(context, MaterialPageRoute(builder:
              (context){
            return RecipeDetails(this._result);
          }
          )
          );
        },


    );*/
  }
}