import 'package:flutter/material.dart';
import 'package:testing/db/database_helper.dart';
import 'package:testing/utils/constants.dart';
class DeleteCard extends StatefulWidget {
  final int id;

  DeleteCard(this.id);

  @override
  _DeleteCardState createState() => _DeleteCardState();
}

class _DeleteCardState extends State<DeleteCard> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
        body: Center(
          child:
            Card(
              elevation: 8,
              color: Colors.blueGrey,
              child: SizedBox(
                height: 160,
                width: 260,
                child: Padding(
                  padding: const EdgeInsets.only(top: 20.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        'Would you like to delete?',
                        style: TextStyle(color: COLOR_WHITE,
                      fontSize: 20),
                      ),
                      Container(
                        child: SizedBox(
                          height: 16,
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            TextButton(style: ButtonStyle(
                              backgroundColor: MaterialStateProperty.all(COLOR_LIGHTGREY),
                              shape: MaterialStateProperty.all(RoundedRectangleBorder(borderRadius: BorderRadius.circular(6))),
                              padding: MaterialStateProperty.all(const EdgeInsets.symmetric(horizontal: 9, vertical: 12),),
                            ),
                                onPressed: (){
                              setState(() {Navigator.pop(context);});
                            }, child: Text('Cancel',
                                style: TextStyle(color: COLOR_WHITE,
                                    fontSize: 16),),
                            ),
                            Container(
                              child: SizedBox(
                                width: 16,
                              ),
                            ),
                            TextButton(style: ButtonStyle(
                              backgroundColor: MaterialStateProperty.all(COLOR_LIGHTGREY),
                              shape: MaterialStateProperty.all(RoundedRectangleBorder(borderRadius: BorderRadius.circular(6))),
                              padding: MaterialStateProperty.all(const EdgeInsets.symmetric(horizontal: 9, vertical: 12),),
                            ),
                                onPressed: () async {
                              print('Successfully deleted id: + ${widget.id}');
                              await LocalDatabase.instance.delete(widget.id);
                              setState(() {Navigator.pop(context);});
                            }, child: Text('Confirm',
                                  style: TextStyle(color: COLOR_WHITE,
                                      fontSize: 16),))
                          ],
                        ),
                    ],
                  ),
                ),
              ),
            ),
        ),

      ));
  }
}
