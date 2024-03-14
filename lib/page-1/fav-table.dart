import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/widgets.dart';
import 'dart:ui';
import 'package:supabase_flutter/supabase_flutter.dart';

class FavTableModal extends StatefulWidget {
  @override
  _FavTableModalState createState() => _FavTableModalState();
}

class _FavTableModalState extends State<FavTableModal> {
  DateTime selectedDate = DateTime.now();
  Future<List<Map<String, dynamic>>> getFavData() async {
    var data = await Supabase.instance.client
        .from('favorite')
        .select('fav_name');
    debugPrint(data.toString());
    return data;
  }

  

  @override
  Widget build(BuildContext context) {
    double baseWidth = MediaQuery.of(context).size.width;
    double baseHeight = MediaQuery.of(context).size.height;
    double modalWidth = baseWidth / 2;
    double modalHeight = baseHeight / 1.2;
    double widthUnit = MediaQuery.of(context).size.width / 1440;
    double heightUnit = MediaQuery.of(context).size.height / 775;
    double widthUnit2 = widthUnit * 0.97;

    TextStyle customTextStyle({
      FontWeight fontWeight = FontWeight.w400,
      double fontSize = 20,
      Color color = Colors.black,
    }) {
      return TextStyle(
        fontWeight: fontWeight,
        fontSize: fontSize * widthUnit,
        color: color,
      );
    }

    void _showEditModal(String text, String column, int id) async {
      TextEditingController _textEditingController =
          TextEditingController(text: text);
      var result = await showModalBottomSheet(
        context: context,
        builder: (BuildContext context) {
          return Container(
            padding: EdgeInsets.all(20 * widthUnit),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextField(controller: _textEditingController),
                SizedBox(height: 20 * widthUnit),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    ElevatedButton(
                      onPressed: () {
                        Navigator.pop(context, _textEditingController.text);
                      },
                      child: Text('Confirm'),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: Text('Cancel'),
                    ),
                  ],
                ),
              ],
            ),
          );
        },
      );
      var updateData = await Supabase.instance.client
          .from("activity")
          .update({column: result}).eq("id", id);
      debugPrint(updateData.toString());
      Navigator.pushReplacementNamed(context, '/home');
    }

    return Scaffold(
      body: FutureBuilder(
          future: getFavData(),
          builder: (context, snapshot) {
            if (snapshot.hasError) {
              return Center(child: Text(snapshot.error.toString()));
            } else if (snapshot.hasData) {
              var data = snapshot.data!;
              return Container(
                // addnewtablePZX (31:117)
                width: modalWidth,
                height: modalHeight,
                padding: EdgeInsets.fromLTRB(20 * widthUnit, 20 * widthUnit,
                    20 * widthUnit, 20 * widthUnit),
                decoration: BoxDecoration(
                  color: const Color.fromARGB(255, 210, 208, 208),
                  borderRadius: BorderRadius.circular(10 * widthUnit),
                ),

                child: Column(
                  children: [
                    Container(
                      width: 228 * widthUnit,
                      height: 30 * heightUnit,
                      margin: EdgeInsets.fromLTRB(
                          0, 20 * heightUnit, 0, 10 * heightUnit),
                      child: Text(
                        'Favorite table',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 30 * widthUnit2,
                          fontWeight: FontWeight.w700,
                          height: 1.155 * widthUnit2 / widthUnit,
                          color: Color(0xff000000),
                        ),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.fromLTRB(10 * widthUnit,
                          50 * widthUnit, 30 * widthUnit, 52 * widthUnit),
                      padding: EdgeInsets.all(20 * widthUnit),
                      width: double.infinity,
                      height: 360 * heightUnit,
                      decoration: BoxDecoration(
                        border: Border.all(color: Color(0xff000000)),
                        color: Color(0xffffffff),
                        borderRadius: BorderRadius.circular(5 * widthUnit),
                      ),
                      child: Text(
                        (data![0] as List<Map<String, dynamic>>)
                            .map((e) => e["favorite"])
                            .join("\n\n"),
                        style: TextStyle(
                          fontSize: 20 * widthUnit2,
                          fontWeight: FontWeight.w400,
                          height: 1.155 * widthUnit2 / widthUnit,
                          color: Color(0xff000000),
                        ),
                      ),
                    ),
                  ],
                ),
              );
            }
            return const Center(
              child: CircularProgressIndicator(),
            );
          }),
    );
  }
}
