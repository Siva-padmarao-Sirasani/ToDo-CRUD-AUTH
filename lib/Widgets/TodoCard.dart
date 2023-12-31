import 'package:flutter/material.dart';
class TodoCard extends StatelessWidget {
  TodoCard({
    Key? key,
    this.title,
    this.time,
    this.iconData,
    this.iconColor,
    this.check,
    this.iconBgColor,
    this.index,
    this.onChange,
}):super(key:key);
  String? title;
  String? time;
  final IconData? iconData;
  final Color? iconColor;
  final bool? check;
  final Color? iconBgColor;
  final Function(int)? onChange;
  final int? index;
  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      child: Row(
        children: [
          Theme(
              data: ThemeData(
                primarySwatch: Colors.blue,
                unselectedWidgetColor: Color(0xff5e616a)
              ),
              child: Transform.scale(
                scale: 1.5,
                child: Checkbox(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(6.0),
                  ),
                  activeColor: Color(0xff6cf8a9),
                  checkColor: Color(0xff0e3e26),
                  value: check,
                  onChanged: (bool? value) {
                    if (value != null) {
                      onChange!(index!);
                    }
                  },


                ),
              ),

          ),
          Expanded(
              child: Container(
                height:75,
                child: Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8.0),

                  ),
                  color: Color(0xff2a2e34),
                  child: Row(
                    children: [
                      SizedBox(width: 15.0,),
                      Container(
                        height: 30.0,
                          width: 30.0,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8.0),
                          color: iconBgColor,
                        ),
                        child: Icon(iconData,size: 25.0,color: iconColor,),
                      ),
                      SizedBox(
                        width: 20.0,
                        
                      ),
                      Expanded(child: Text(title!,style: TextStyle(fontSize: 18.0,letterSpacing:1,fontWeight: FontWeight.bold,color: Colors.white),)),
                      Text(time!,style: TextStyle(fontSize: 15.0,color: Colors.white),),
                      SizedBox(width: 15.0,),
                    ],
                  ),
                ),
          ),
          ),
        ],
      ),
    );
  }
}
