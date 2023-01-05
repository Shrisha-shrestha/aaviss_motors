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
      print(value);
      Val = value!.data!.vehicle!;
      print(Val.fullName);

    });
    print(Val.fullName);
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
                builder: (BuildContext ctx, AsyncSnapshot<SearchResponseModel> snapshot) =>
                snapshot.hasData
                    ? SizedBox(
                  height: 20.0,
                  width: 30.0,
                  child: Text('abcd'),
                ) :Expanded(
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children:  <Widget>[
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 10.0),
                          child: Text('Vehicle Information',
                            style:Theme.of(context).textTheme.bodyText2 ,),
                        ),
                        Container(
                            padding: EdgeInsets.all(8.0),
                            width:MediaQuery.of(context).size.width,
                            decoration: BoxDecoration(
                              border: Border(
                                bottom: BorderSide(width: 1, color: Colors.grey),
                              ),
                            ),
                            child:Text('Name of Brand : ',style: Theme.of(context).textTheme.caption,)
                        ),
                        const SizedBox(height: 20.0,),
                        Container(
                            padding: EdgeInsets.all(8.0),
                            width:MediaQuery.of(context).size.width,
                            decoration: BoxDecoration(
                              border: Border(
                                bottom: BorderSide(width: 1, color: Colors.grey),
                              ),
                            ),
                            // child:Text('${Val!.fullName}',style: Theme.of(context).textTheme.caption,)
                            child:Text('Name of Vehicle : ',style: Theme.of(context).textTheme.subtitle2,)

                        ),
                        const SizedBox(height: 20.0,),
                        Container(
                            padding: EdgeInsets.all(8.0),
                            width:MediaQuery.of(context).size.width,
                            decoration: BoxDecoration(
                              border: Border(
                                bottom: BorderSide(width: 1, color: Colors.grey),
                              ),
                            ),
                            // child:Text('${Val!.fullName}',style: Theme.of(context).textTheme.caption,)
                            child:Text('Engine NUmber : ',style: Theme.of(context).textTheme.subtitle2,)

                        ),
                        const SizedBox(height: 20.0,),
                        Container(
                            padding: EdgeInsets.all(8.0),
                            width:MediaQuery.of(context).size.width,
                            decoration: BoxDecoration(
                              border: Border(
                                bottom: BorderSide(width: 1, color: Colors.grey),
                              ),
                            ),
                            //child:Text('${Val!.fullName}',style: Theme.of(context).textTheme.caption,)
                            child:Text('Manufacture Year : ',style: Theme.of(context).textTheme.subtitle2,)

                        ),
                        const SizedBox(height: 10.0,),
                        Container(
                            padding: EdgeInsets.all(8.0),
                            width:MediaQuery.of(context).size.width,
                            decoration: BoxDecoration(
                              border: Border(
                                bottom: BorderSide(width: 1, color: Colors.grey),
                              ),
                            ),
                            // child:Text('${Val!.fullName}',style: Theme.of(context).textTheme.caption,)
                            child:Text('Color : ',style: Theme.of(context).textTheme.subtitle2,)

                        ),
                        const SizedBox(height: 20.0,),
                        Container(
                            padding: EdgeInsets.all(8.0),
                            width:MediaQuery.of(context).size.width,
                            decoration: BoxDecoration(
                              border: Border(
                                bottom: BorderSide(width: 1, color: Colors.grey),
                              ),
                            ),
                            // child:Text('${Val!.fullName}',style: Theme.of(context).textTheme.caption,)
                            child:Text('No. of Seat : ',style: Theme.of(context).textTheme.subtitle2,)

                        ),
                        const SizedBox(height: 20.0,),
                        Container(
                            padding: EdgeInsets.all(8.0),
                            width:MediaQuery.of(context).size.width,
                            decoration: BoxDecoration(
                              border: Border(
                                bottom: BorderSide(width: 1, color: Colors.grey),
                              ),
                            ),
                            // child:Text('${Val!.fullName}',style: Theme.of(context).textTheme.caption,)
                            child:Text('Purchase Year : ',style: Theme.of(context).textTheme.subtitle2,)

                        ),
                        const SizedBox(height: 20.0,),
                        Container(
                            padding: EdgeInsets.all(8.0),
                            width:MediaQuery.of(context).size.width,
                            decoration: BoxDecoration(
                              border: Border(
                                bottom: BorderSide(width: 1, color: Colors.grey),
                              ),
                            ),
                            // child:Text('${Val!.fullName}',style: Theme.of(context).textTheme.caption,)
                            child:Text('No. of Transfers : ',style: Theme.of(context).textTheme.subtitle2,)

                        ),
                        const SizedBox(height: 20.0,),
                        Text('Vehicle Type',
                          style: Theme.of(context).textTheme.caption,),
                        Row(
                          children: <Widget>[
                            Radio<int>(
                                value: 1,
                                groupValue: val1,
                                activeColor: Theme.of(context).colorScheme.secondary,
                                onChanged: (int? value){
                                  setState(() {
                                    val1 = value;
                                  });
                                }),
                            Text("Private",
                                style: Theme.of(context).textTheme.caption),
                            const SizedBox(width: 70.0,),
                            Radio<int>(
                                value: 2,
                                groupValue: val1,
                                toggleable: true,
                                activeColor: Theme.of(context).colorScheme.secondary,
                                onChanged: (int? value){
                                  setState(() {
                                    val1 = value;
                                  });
                                }),
                            Text("Public",
                                style: Theme.of(context).textTheme.caption),
                          ],
                        ),
                        SizedBox(height: 20.0,
                            child: val1 == null ? Text('Please Select one.',style: Theme.of(context).textTheme.caption!.copyWith(color: Colors.red),):const Text('')),
                        Text('Number PLate',
                          style: Theme.of(context).textTheme.caption,),
                        Row(
                          children: <Widget>[
                            Radio<int>(
                                value: 1,
                                groupValue: val2,
                                toggleable: true,
                                activeColor: Theme.of(context).colorScheme.secondary,
                                onChanged: (int? value){
                                  setState(() {
                                    val2 = value;
                                  });
                                }),
                            Text("Old",
                                style: Theme.of(context).textTheme.caption),
                            const SizedBox(width: 91.0,),
                            Radio<int>(
                                value: 2,
                                groupValue: val2,
                                toggleable: true,
                                activeColor: Theme.of(context).colorScheme.secondary,
                                onChanged: (int? value){
                                  setState(() {
                                    val2 = value;
                                  });
                                }),
                            Text("New",
                                style: Theme.of(context).textTheme.caption),
                          ],
                        ),
                        if(val2 == null) ...{ Text('Please Select one.',style: Theme.of(context).textTheme.caption!.copyWith(color: Colors.red))},
                        if (val2 == 1) ... [
                          Column(
                            //crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row( mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  SizedBox(
                                    width: 91.0,
                                    child: TextFormField(
                                      textAlign: TextAlign.center,
                                      style: Theme.of(context).textTheme.caption!.copyWith(fontSize:18.0),
                                      validator:(val)=> val!.isEmpty ? 'Required!': null,
                                      decoration: InputDecoration(
                                        labelText: 'Zonal Code',
                                        labelStyle: Theme.of(context).textTheme.caption,
                                        focusedBorder: const UnderlineInputBorder(
                                          borderSide: BorderSide(color: Colors.grey), //<-- SEE HERE
                                        ),
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    width: 91.0,
                                    child: TextFormField(
                                      textAlign: TextAlign.center,
                                      style: Theme.of(context).textTheme.caption!.copyWith(fontSize:18.0),
                                      validator:(val)=> val!.isEmpty ? 'Required!': null,
                                      decoration: InputDecoration(
                                        labelText: 'Lot Number',
                                        labelStyle: Theme.of(context).textTheme.caption,
                                        focusedBorder: const UnderlineInputBorder(
                                          borderSide: BorderSide(color: Colors.grey), //<-- SEE HERE
                                        ),
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    width: 91.0,
                                    child: TextFormField(
                                      textAlign: TextAlign.center,
                                      style: Theme.of(context).textTheme.caption!.copyWith(fontSize:18.0),
                                      validator:(val)=> val!.isEmpty ? 'Required!': null,
                                      decoration: InputDecoration(
                                        labelText: 'Vehicle Type',
                                        labelStyle: Theme.of(context).textTheme.caption,
                                        focusedBorder: const UnderlineInputBorder(
                                          borderSide: BorderSide(color: Colors.grey), //<-- SEE HERE
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(height: 10.0,),
                              SizedBox(
                                width: 91.0,
                                child: TextFormField(
                                  textAlign: TextAlign.center,
                                  style: Theme.of(context).textTheme.caption!.copyWith(fontSize:18.0),
                                  validator:(val)=> val!.isEmpty ? 'Required!': null,
                                  decoration: InputDecoration(
                                    labelText: 'Vehicle Number',
                                    labelStyle: Theme.of(context).textTheme.caption,
                                    focusedBorder: const UnderlineInputBorder(
                                      borderSide: BorderSide(color: Colors.grey), //<-- SEE HERE
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          )
                        ] else if(val2 == 2)...[
                          Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  SizedBox(
                                    width: 91.0,
                                    child: TextFormField(
                                      textAlign: TextAlign.center,
                                      style: Theme.of(context).textTheme.caption!.copyWith(fontSize:18.0),
                                      validator:(val)=> val!.isEmpty ? 'Required!': null,
                                      decoration: InputDecoration(
                                        labelText: 'Province',
                                        labelStyle: Theme.of(context).textTheme.caption,
                                        focusedBorder: const UnderlineInputBorder(
                                          borderSide: BorderSide(color: Colors.grey), //<-- SEE HERE
                                        ),
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    width: 91.0,
                                    child: TextFormField(
                                      textAlign: TextAlign.center,
                                      style: Theme.of(context).textTheme.caption!.copyWith(fontSize:18.0),
                                      validator:(val)=> val!.isEmpty ? 'Required!': null,
                                      decoration: InputDecoration(
                                        labelText: 'Office Code',
                                        labelStyle: Theme.of(context).textTheme.caption,
                                        focusedBorder: const UnderlineInputBorder(
                                          borderSide: BorderSide(color: Colors.grey), //<-- SEE HERE
                                        ),
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    width: 91.0,
                                    child: TextFormField(
                                      textAlign: TextAlign.center,
                                      style: Theme.of(context).textTheme.caption!.copyWith(fontSize:18.0),
                                      validator:(val)=> val!.isEmpty ? 'Required!': null,
                                      decoration: InputDecoration(
                                        labelText: 'Lot Number',
                                        labelStyle: Theme.of(context).textTheme.caption,
                                        focusedBorder: const UnderlineInputBorder(
                                          borderSide: BorderSide(color: Colors.grey), //<-- SEE HERE
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(height: 10.0,),
                              Row(
                                children: <Widget>[
                                  SizedBox(
                                    width: 91.0,
                                    child: TextFormField(
                                      textAlign: TextAlign.center,
                                      style: Theme.of(context).textTheme.caption!.copyWith(fontSize:18.0),
                                      validator:(val)=> val!.isEmpty ? 'Required!': null,
                                      decoration: InputDecoration(
                                        labelText: 'Symbol',
                                        labelStyle: Theme.of(context).textTheme.caption,
                                        focusedBorder: const UnderlineInputBorder(
                                          borderSide: BorderSide(color: Colors.grey), //<-- SEE HERE
                                        ),
                                      ),
                                    ),
                                  ),
                                  SizedBox(width: MediaQuery.of(context).size.width * 0.1,),
                                  SizedBox(
                                    width: 91.0,
                                    child: TextFormField(
                                      textAlign: TextAlign.center,
                                      style: Theme.of(context).textTheme.caption!.copyWith(fontSize:18.0),
                                      validator:(val)=> val!.isEmpty ? 'Required!': null,
                                      decoration: InputDecoration(
                                        labelText: 'Vehicle Number',
                                        labelStyle: Theme.of(context).textTheme.caption,
                                        focusedBorder: const UnderlineInputBorder(
                                          borderSide: BorderSide(color: Colors.grey), //<-- SEE HERE
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          )
                        ],
                        SizedBox(height:20.0 ,),

                        Center(
                          child: TextButton(
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
                        ),

                      ],
                    ),
                  ),
                )

                   ),


              SizedBox(height: 34.0,width: MediaQuery.of(context).size.width,),

            ],
          ),
        ),
      ),
    );
  }
}

