import 'package:aaviss_motors/screens/personnel_info.dart';
import 'package:aaviss_motors/screens/search_detail.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../models/storevehicleinfo.dart';

class FinishScreen extends StatefulWidget {
  const FinishScreen({super.key, required this.title});
  final String title;
  @override
  State<FinishScreen> createState() => _FinishScreenState();
}

class _FinishScreenState extends State<FinishScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title,
            style: Theme.of(context).textTheme.headline5),
        // leading: Transform.translate(offset: Offset(-15, 0),),
        titleSpacing: -30,
        centerTitle: false,
        toolbarHeight: 108.0,
        elevation: 0.0,
        backgroundColor: Colors.white,
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 32.0),
            child: IconButton(icon: SvgPicture.asset(
                'assets/search.svg',
                semanticsLabel: 'Search'
            ),
                onPressed: () {Navigator.of(context).push(MaterialPageRoute(builder: (context)=>
                    SearchDetail(title: widget.title)));            }),
          ),
        ],
      ),
      body: SizedBox(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: Padding(
          padding: const EdgeInsets.only(left:27.0,right: 29.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                'Resale Value Calculator ',
                style: Theme.of(context).textTheme.headline6,
              ),
              Padding(
                padding: const EdgeInsets.only(top: 10,bottom: 34),
                child: Text('Fill the form below to know resale\nvalue of your vehicle',
                  style: Theme.of(context).textTheme.subtitle2,
                ),
              ),

              Expanded(
                child: SingleChildScrollView(
                  child: Center(
                    child: Column(
                        children: [
                        Padding(
                        padding: const EdgeInsets.only(top: 35.0,bottom: 35.0),
                          child: SvgPicture.asset(
                              'assets/finish.svg',
                              semanticsLabel: 'Finished'
                          ),),
                           Text('Thank you very much for\nyour inquiry. You will receive\nyour valuation in 3 working days.\nIf you want to receive\nyour valuation within 24 hours,\nplease pay Rs.100 at\nesewa account 9800000000.',
                          textAlign: TextAlign.center,
                             style: Theme.of(context).textTheme.bodyText1!.copyWith(fontSize: 16.0),
                          ),
                          const SizedBox(height: 35.0,),
                          TextButton(
                              onPressed: (){
                                Navigator.of(context).push(MaterialPageRoute(builder: (context)=>MyHomePage(title: widget.title)));
                              },
                              style: ButtonStyle(
                                  backgroundColor: MaterialStateProperty.all(Colors.white),
                                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                                      RoundedRectangleBorder(
                                          borderRadius: BorderRadius.zero,
                                          side: BorderSide(color: Theme.of(context).colorScheme.secondary)
                                      )
                                  )
                              ),
                              child:  Text('Go Home',style: Theme.of(context).textTheme.button)),
                        ],
                ),
                  ),
                ),
              ),
              SizedBox(height: 34.0,width: MediaQuery.of(context).size.width,),

            ],
          ),
        ),
      ),
    );
  }
}

