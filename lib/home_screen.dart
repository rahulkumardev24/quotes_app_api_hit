import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:quotes_api_intragation/model/quote_model.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();
    getQuotes();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Quotes"),
          centerTitle: true,
          backgroundColor: Colors.orangeAccent,
        ),
        body: FutureBuilder<QuoteDataModel?>(
          future: getQuotes(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else if (snapshot.hasError) {
              return Center(
                child: Text("Error : ${snapshot.error.toString()}"),
              );
            } else if (snapshot.hasData) {
              return ListView.builder(
                  itemCount: snapshot.data!.quotes.length,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: ListTile(
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(9) , side: const BorderSide(color: Colors.black54 , width: 1) ),
                        title: Text(snapshot.data!.quotes[index].quote),
                        subtitle: Text(
                          "- ${snapshot.data!.quotes[index].author} ",
                          style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 20,
                              color: Colors.red),
                        ),
                      ),
                    );
                  });
            }
            return Container();
          },
        )

        /// simple method --> use set state
        ///mData != null ? mData!.quotes.isNotEmpty ? ListView.builder(
        //         itemCount: mData!.quotes.length,
        //           itemBuilder: (_, index){
        //           return ListTile(
        //             title: Text(mData!.quotes[index].quote),
        //             subtitle: Text('- ${mData!.quotes[index].author}'),
        //           );
        //       }) : Center(
        //         child: Text('No Quotes Found!!'),
        //       ) : Center(child: Text('Unable to load Quotes'),)

        );
  }

  /// ----------------------- getQuotes function ---------------------------

  Future<QuoteDataModel?> getQuotes() async {
    /// from your api get or post
    String url = "https://dummyjson.com/quotes";
    Uri uri = Uri.parse(url);
    http.Response res = await http.get(uri);

    /// exception handling
    if (res.statusCode == 200) {
      print("Response body : ${res.body}");
      var resData = jsonDecode(res.body);
      return QuoteDataModel.fromJson(resData);
    } else {
      return null;
    }
  }
}
