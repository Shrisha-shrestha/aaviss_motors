import 'package:aaviss_motors/screens/personnel_info.dart';
import 'package:aaviss_motors/screens/search_detail.dart';
import 'package:aaviss_motors/screens/vehicle_info.dart';
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
    // return Scaffold(
    //   body: Center(
    //     child: Container(
    //       height: 15.0,
    //       width: 15.0,
    //       child: Padding(
    //         padding: EdgeInsets.all(2.0),
    //         child: Container(
    //           decoration: BoxDecoration(
    //             color: Colors.white,
    //             borderRadius: BorderRadius.circular(10.0),
    //           ),
    //           padding: EdgeInsets.all(1.0),
    //           child: Container(
    //             decoration: BoxDecoration(
    //               color: Colors.blue,
    //               borderRadius: BorderRadius.circular(10.0),
    //             ),
    //           ),
    //         ),
    //       ),
    //       decoration: BoxDecoration(
    //         color: Colors.blue,
    //         borderRadius: BorderRadius.circular(20.0),
    //       ),
    //     ),
    //   ),
    // );
    return Scaffold(
      appBar: AppBar(
        title: GestureDetector(
            onTap: () {
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => VehicleInfo(
                        title: widget.title,
                      )));
            },
            child: Text(widget.title,
                style: Theme.of(context).textTheme.headline5)),
        // leading: Transform.translate(offset: Offset(-15, 0),),
        titleSpacing: -30,
        centerTitle: false,
        toolbarHeight: 108.0,
        elevation: 0.0,
        backgroundColor: Colors.white,
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 32.0),
            child: IconButton(
                icon: SvgPicture.asset('assets/search.svg',
                    semanticsLabel: 'Search'),
                onPressed: () {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => SearchDetail(title: widget.title)));
                }),
          ),
        ],
      ),
      body: SizedBox(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: Padding(
          padding: const EdgeInsets.only(left: 27.0, right: 29.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                'Resale Value Calculator ',
                style: Theme.of(context).textTheme.headline6,
              ),
              Padding(
                padding: const EdgeInsets.only(top: 10, bottom: 34),
                child: Text(
                  'Fill the form below to know resale\nvalue of your vehicle',
                  style: Theme.of(context).textTheme.subtitle2,
                ),
              ),
              Expanded(
                child: SingleChildScrollView(
                  child: Center(
                    child: SizedBox(
                      width: MediaQuery.of(context).size.width * 0.7,
                      child: Column(
                        children: [
                          SizedBox(
                            height: MediaQuery.of(context).size.height * 0.04,
                          ),
                          Text(
                            'Thank you very much for your inquiry.',
                            textAlign: TextAlign.center,
                            style: Theme.of(context)
                                .textTheme
                                .bodyText1!
                                .copyWith(fontSize: 16.0),
                          ),
                          Padding(
                            padding:
                                const EdgeInsets.only(top: 35.0, bottom: 35.0),
                            child: SvgPicture.asset('assets/finish.svg',
                                semanticsLabel: 'Finished'),
                          ),
                          Text(
                            'You will receive your valuation in 24 hours.\n',
                            textAlign: TextAlign.justify,
                            style: Theme.of(context)
                                .textTheme
                                .bodyText1!
                                .copyWith(fontSize: 16.0),
                          ),
                          Text(
                            'If you want to receive your valuation within instantly, please pay Rs.100 at esewa account 9800000000.',
                            textAlign: TextAlign.justify,
                            style: Theme.of(context)
                                .textTheme
                                .bodyText1!
                                .copyWith(fontSize: 16.0),
                          ),
                          const SizedBox(
                            height: 35.0,
                          ),
                          TextButton(
                              onPressed: () {
                                Navigator.of(context).push(MaterialPageRoute(
                                    builder: (context) =>
                                        VehicleInfo(title: widget.title)));
                              },
                              style: ButtonStyle(
                                  backgroundColor:
                                      MaterialStateProperty.all(Colors.white),
                                  shape: MaterialStateProperty.all<
                                          RoundedRectangleBorder>(
                                      RoundedRectangleBorder(
                                          borderRadius: BorderRadius.zero,
                                          side: BorderSide(
                                              color: Theme.of(context)
                                                  .colorScheme
                                                  .secondary)))),
                              child: Text('Go Home',
                                  style: Theme.of(context).textTheme.button)),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 34.0,
                width: MediaQuery.of(context).size.width,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
