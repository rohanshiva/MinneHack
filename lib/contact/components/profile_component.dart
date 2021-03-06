import "package:flutter/material.dart";
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:minne_hack/contact/bloc/bloc.dart';
import 'package:minne_hack/utility/color_scheme.dart';
import "package:url_launcher/url_launcher.dart";

class ProfileComponent extends StatelessWidget{
  final Map _data;

  ProfileComponent(this._data);

  Widget build(BuildContext context){
    final contactBloc = BlocProvider.of<ContactBloc>(context);
    double sH  = MediaQuery.of(context).size.height;
    double sW = MediaQuery.of(context).size.width;
    return Column(
      children: <Widget>[
        Container(
            height: sH * 0.2,
            child: Row(
              children: <Widget>[
                Container(
                  width: sW * 0.2,
                  child: IconButton(
                    icon: Icon(Icons.keyboard_arrow_left),
                    onPressed: () => contactBloc.add(SearchEvent("")),
                  ),
                ),
              ],
            ),
          ),
          Container(
            height: sH * 0.6,
            width: sW * 0.8,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(18),
              color: ColorSchemeUI.glowingRed
            ),
            child: Column(
              children: <Widget>[
                Container(
                  height: sH * 0.15,
                  child: Align(

                    alignment: Alignment(-0.7, 0.6),
                        child: Text(this._data["firstName"], style: TextStyle(
                      fontFamily: "Montserrat",
                      fontSize: 36,
                      color: Colors.white
                    ),),
                  ),
                  ),
                  Container(
                  height: sH * 0.15,
                  child: Align(
                      alignment: Alignment(-0.7,-1),
                      child: Text(this._data["lastName"], style: TextStyle(
                      fontFamily: "Montserrat",
                      fontSize: 36,
                      color: Colors.white
                    ),),
                  ),
                  ),
                  MediaRow(
                    this._data
                  )
              ],
            ),
          )
      ],
    );
  }

}

class MediaRow extends StatelessWidget{
  Map _data;
  MediaRow(this._data);
  Widget build(BuildContext context){
    return Container(
      child: Row(children: buildMediaRow(context)));
  }

  List<Widget> buildMediaRow(BuildContext context){
    double sH = MediaQuery.of(context).size.width;
    double sW = MediaQuery.of(context).size.height;

    Map rowLinks = {"INSTAGRAM": "https://instagram.com/", "GITHUB": "https://github.com/", "EMAIL": "https://gmail.com"};
    Map rowImages = {"INSTAGRAM": "instagram_1.png", "GITHUB": "github.png", "EMAIL": "gmail_1.png"};
    List<Widget> mediaRow = [];
    this._data.forEach((k,v){

      String field = k.toUpperCase();
      if(rowLinks.containsKey(field)){
        String url = rowLinks[field];
        if(field != "EMAIL"){
          url += v;
        }
        mediaRow.add(Container(
          height: sH * 0.2,
          child: InkWell(

            child: Image.asset("images/${rowImages[field]}"),
            onTap: () async {
              if(await canLaunch(url)){
                await launch(url);
              }
              else{
                print("Could not launch");
              }
            },
        )));

      }
    });

    return mediaRow;
  }
}