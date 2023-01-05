import 'package:aaviss_motors/API/API_connection.dart';
import 'package:aaviss_motors/models/searchvehicle.dart';
import 'package:aaviss_motors/screens/personnel_info.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class SearchDetail extends StatefulWidget {
  const SearchDetail({super.key, required this.title});
  final String title;

  @override
  State<SearchDetail> createState() => _SearchDetailState();
}

class _SearchDetailState extends State<SearchDetail> {
  int? val1=1 ,val2=1 ;
  bool _isVisible=false;
  final GlobalKey<FormState> _formkey = GlobalKey<FormState>();
  late SearchRequestModel searchrequestModel;

  Future<SearchResponseModel>? future;

  void initState(){
    searchrequestModel = new SearchRequestModel();
    super.initState();
  }
  Future<SearchResponseModel> getvehicledata(SearchRequestModel searchrequestModel) async {
    APIService  apiService = APIService();
    await apiService.searchvehicle(searchrequestModel).then((value){
      Val = value;
    });
    return Val;
  }
  dynamic Val;
  String? fname;

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
                onPressed: () { Navigator.of(context).push(MaterialPageRoute(builder: (context)=>
                    SearchDetail(title: widget.title)));             }),
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
                'Search Your Detail ',
                style: Theme.of(context).textTheme.headline6,
              ),
              Form(
                key: _formkey,
                  child:  TextFormField(
                    onSaved: (String? value) {
                      searchrequestModel.vehicle_number = value;
                    },
                      keyboardType: TextInputType.number,
                         style: Theme.of(context).textTheme.caption!.copyWith(fontSize:18.0),
                    validator:(val)=> val!.isEmpty ? 'Enter Your Vehicle Number please.': null,
                    decoration: InputDecoration(
                      labelText: 'Enter Your Vehicle Number',
                      labelStyle: Theme.of(context).textTheme.caption,
                      focusedBorder: const UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.grey), //<-- SEE HERE
                      ),
                    ),
                  ),),
              SizedBox(height: 15.0,),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  TextButton(
                      onPressed: ()async{
                        if(_formkey.currentState!.validate()){
                          _formkey.currentState!.save();
                          final snackBar = SnackBar(
                              backgroundColor: Theme.of(context).colorScheme.primary,
                              content:Text('Please Wait.....'));
                          ScaffoldMessenger.of(context).showSnackBar(snackBar);
                            future  = getvehicledata(searchrequestModel);
                            setState(() {
                              _isVisible = true;
                            });
                        }
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
                      child:  Text('Search',style: Theme.of(context).textTheme.button)),
                ],
              ),
              Visibility(
                visible: !_isVisible,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
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


              FutureBuilder(
                future: future,
                builder: (BuildContext ctx, AsyncSnapshot<SearchResponseModel> snapshot) {

                  if (snapshot.hasError) {
                    return Center(
                      child: Text(
                        '${snapshot.error} occurred',
                        style: TextStyle(fontSize: 18),
                      ),
                    );
                  }
                  if (snapshot.hasData) {
                    val1 = snapshot.data!.data!.vehicle!.vehicleType == "private" ?  1 : 2;
                    val2 = snapshot.data!.data!.vehicle!.nidType == "citizenship" ?  1 : 2;
                    return Expanded(
                      child: SingleChildScrollView(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                  vertical: 10.0),
                              child: Text('Vehicle Information',
                                style: Theme
                                    .of(context)
                                    .textTheme
                                    .bodyText2,),
                            ),
                            Container(
                                padding: EdgeInsets.all(8.0),
                                width: MediaQuery
                                    .of(context)
                                    .size
                                    .width,
                                decoration: BoxDecoration(
                                  border: Border(
                                    bottom: BorderSide(
                                        width: 1, color: Colors.grey),
                                  ),
                                ),
                                child: Text(
                                  'Name of Brand : ${snapshot.data!.data!
                                      .vehicle!.fullName}', style: Theme
                                    .of(context)
                                    .textTheme
                                    .caption,)
                            ),
                            const SizedBox(height: 20.0,),
                            Container(
                                padding: EdgeInsets.all(8.0),
                                width: MediaQuery
                                    .of(context)
                                    .size
                                    .width,
                                decoration: BoxDecoration(
                                  border: Border(
                                    bottom: BorderSide(
                                        width: 1, color: Colors.grey),
                                  ),
                                ),
                                // child:Text('${Val!.fullName}',style: Theme.of(context).textTheme.caption,)
                                child: Text(
                                  'Name of Vehicle : ${snapshot.data!.data!
                                      .vehicle!.vehicleName!.vehicleName}',
                                  style: Theme
                                      .of(context)
                                      .textTheme
                                      .subtitle2,)

                            ),
                            const SizedBox(height: 20.0,),
                            Container(
                                padding: EdgeInsets.all(8.0),
                                width: MediaQuery
                                    .of(context)
                                    .size
                                    .width,
                                decoration: BoxDecoration(
                                  border: Border(
                                    bottom: BorderSide(
                                        width: 1, color: Colors.grey),
                                  ),
                                ),
                                // child:Text('${Val!.fullName}',style: Theme.of(context).textTheme.caption,)
                                child: Text(
                                  'Engine NUmber : ${snapshot.data!.data!
                                      .vehicle!.engineNo}', style: Theme
                                    .of(context)
                                    .textTheme
                                    .subtitle2,)

                            ),
                            const SizedBox(height: 20.0,),
                            Container(
                                padding: EdgeInsets.all(8.0),
                                width: MediaQuery
                                    .of(context)
                                    .size
                                    .width,
                                decoration: BoxDecoration(
                                  border: Border(
                                    bottom: BorderSide(
                                        width: 1, color: Colors.grey),
                                  ),
                                ),
                                //child:Text('${Val!.fullName}',style: Theme.of(context).textTheme.caption,)
                                child: Text(
                                  'Manufacture Year : ${snapshot.data!.data!
                                      .vehicle!.manufactureYear}', style: Theme
                                    .of(context)
                                    .textTheme
                                    .subtitle2,)

                            ),
                            const SizedBox(height: 10.0,),
                            Container(
                                padding: EdgeInsets.all(8.0),
                                width: MediaQuery
                                    .of(context)
                                    .size
                                    .width,
                                decoration: BoxDecoration(
                                  border: Border(
                                    bottom: BorderSide(
                                        width: 1, color: Colors.grey),
                                  ),
                                ),
                                // child:Text('${Val!.fullName}',style: Theme.of(context).textTheme.caption,)
                                child: Text(
                                  'Color : ${snapshot.data!.data!.vehicle!
                                      .color}', style: Theme
                                    .of(context)
                                    .textTheme
                                    .subtitle2,)

                            ),
                            const SizedBox(height: 20.0,),
                            Container(
                                padding: EdgeInsets.all(8.0),
                                width: MediaQuery
                                    .of(context)
                                    .size
                                    .width,
                                decoration: BoxDecoration(
                                  border: Border(
                                    bottom: BorderSide(
                                        width: 1, color: Colors.grey),
                                  ),
                                ),
                                // child:Text('${Val!.fullName}',style: Theme.of(context).textTheme.caption,)
                                child: Text(
                                  'No. of Seat : ${snapshot.data!.data!.vehicle!
                                      .noOfSeats}', style: Theme
                                    .of(context)
                                    .textTheme
                                    .subtitle2,)

                            ),
                            const SizedBox(height: 20.0,),
                            Container(
                                padding: EdgeInsets.all(8.0),
                                width: MediaQuery
                                    .of(context)
                                    .size
                                    .width,
                                decoration: BoxDecoration(
                                  border: Border(
                                    bottom: BorderSide(
                                        width: 1, color: Colors.grey),
                                  ),
                                ),
                                // child:Text('${Val!.fullName}',style: Theme.of(context).textTheme.caption,)
                                child: Text(
                                  'Purchase Year : ${snapshot.data!.data!
                                      .vehicle!.purchaseYear}', style: Theme
                                    .of(context)
                                    .textTheme
                                    .subtitle2,)

                            ),
                            const SizedBox(height: 20.0,),
                            Container(
                                padding: EdgeInsets.all(8.0),
                                width: MediaQuery
                                    .of(context)
                                    .size
                                    .width,
                                decoration: BoxDecoration(
                                  border: Border(
                                    bottom: BorderSide(
                                        width: 1, color: Colors.grey),
                                  ),
                                ),
                                // child:Text('${Val!.fullName}',style: Theme.of(context).textTheme.caption,)
                                child: Text(
                                  'No. of Transfers : ${snapshot.data!.data!
                                      .vehicle!.noOfTransfer}', style: Theme
                                    .of(context)
                                    .textTheme
                                    .subtitle2,)

                            ),
                            const SizedBox(height: 20.0,),
                            Text('Vehicle Type',
                              style: Theme
                                  .of(context)
                                  .textTheme
                                  .caption,),
                            Row(
                              children: <Widget>[
                                Radio<int>(
                                    value: 1,
                                    groupValue: val1,
                                    activeColor: Theme
                                        .of(context)
                                        .colorScheme
                                        .secondary,
                                    onChanged: (int? value){}
                                ),
                                Text("Private",
                                    style: Theme
                                        .of(context)
                                        .textTheme
                                        .caption),
                                const SizedBox(width: 70.0,),
                                Radio<int>(
                                    value: 2,
                                    groupValue: val1,
                                    toggleable: true,
                                    activeColor: Theme
                                        .of(context)
                                        .colorScheme
                                        .secondary,
                                    onChanged: (int? value){}
                                ),
                                Text("Public",
                                    style: Theme
                                        .of(context)
                                        .textTheme
                                        .caption),
                              ],
                            ),
                            SizedBox(height: 20.0,
                                child: val1 == null ? Text(
                                  'Please Select one.', style: Theme
                                    .of(context)
                                    .textTheme
                                    .caption!
                                    .copyWith(color: Colors.red),) : const Text(
                                    '')),
                            Text('Number PLate',
                              style: Theme
                                  .of(context)
                                  .textTheme
                                  .caption,),
                            Row(
                              children: <Widget>[
                                Radio<int>(
                                    value: 1,
                                    groupValue: val2,
                                    toggleable: true,
                                    activeColor: Theme
                                        .of(context)
                                        .colorScheme
                                        .secondary,
                                    onChanged: (int? value){}
                                ),
                                Text("Old",
                                    style: Theme
                                        .of(context)
                                        .textTheme
                                        .caption),
                                const SizedBox(width: 91.0,),
                                Radio<int>(
                                    value: 2,
                                    groupValue: val2,
                                    toggleable: true,
                                    activeColor: Theme
                                        .of(context)
                                        .colorScheme
                                        .secondary,
                                    onChanged: (int? value){}
                                ),
                                Text("New",
                                    style: Theme
                                        .of(context)
                                        .textTheme
                                        .caption),
                              ],
                            ),
                            if(val2 == null) ...{
                              Text('Please Select one.', style: Theme
                                  .of(context)
                                  .textTheme
                                  .caption!
                                  .copyWith(color: Colors.red))
                            },
                              Container(
                                  padding: EdgeInsets.all(8.0),
                                  width: MediaQuery
                                      .of(context)
                                      .size
                                      .width,
                                  decoration: BoxDecoration(
                                    border: Border(
                                      bottom: BorderSide(
                                          width: 1, color: Colors.grey),
                                    ),
                                  ),
                                  child: Text(
                                    '${snapshot.data!.data!
                                        .vehicle!.nidNo}', style: Theme
                                      .of(context)
                                      .textTheme
                                      .subtitle2,)

                              ),

                            SizedBox(height: 20.0,),

                            Center(
                              child: TextButton(
                                  onPressed: () {
                                    Navigator.of(context).push(
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                MyHomePage(
                                                    title: widget.title)));
                                  },
                                  style: ButtonStyle(
                                      backgroundColor: MaterialStateProperty
                                          .all(
                                          Colors.white),
                                      shape: MaterialStateProperty.all<
                                          RoundedRectangleBorder>(
                                          RoundedRectangleBorder(
                                              borderRadius: BorderRadius.zero,
                                              side: BorderSide(color: Theme
                                                  .of(context)
                                                  .colorScheme
                                                  .secondary)
                                          )
                                      )
                                  ),
                                  child: Text('Go Home', style: Theme
                                      .of(context)
                                      .textTheme
                                      .button)),
                            ),

                          ],
                        ),
                      ),
                    );
                  }

                  else {
                      return SizedBox();
                    }
                  }
              ),


              SizedBox(height: 34.0,width: MediaQuery.of(context).size.width,),

            ],
          ),
        ),
      ),
    );
  }
}

