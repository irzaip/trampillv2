import 'package:flutter/material.dart';
import 'package:trampillv2/api/api_message.dart';
import 'package:trampillv2/api/class_message.dart';
import 'package:trampillv2/values/fontstyle.dart';

class MessageScreen extends StatefulWidget {
  const MessageScreen({Key? key}) : super(key: key);

  static const String routeName = "/message";

  @override
  State<MessageScreen> createState() => _MessageScreenState();
}

class _MessageScreenState extends State<MessageScreen> {
  late Future<List<Message>> messages;

  @override
  void initState() {
    super.initState();
    messages = getMessages();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Pesan"),
      ),
      body: FutureBuilder(
          future: messages,
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            if (snapshot.data != null) {
              return ListView.builder(
                  itemCount: snapshot.data.length,
                  itemBuilder: (context, int index) {
                    return Card(
                      child: Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            const SizedBox(
                              height: 10,
                            ),
                            Text(
                              snapshot.data[index].createdAt,
                              style: kategorifont,
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            Text("Dari :" + snapshot.data[index].sender,
                                style: mediumfontbold),
                            const SizedBox(
                              height: 10,
                            ),
                            Text(
                              "Pesan :" + snapshot.data[index].messageContent,
                              style: mediumfont,
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                          ],
                        ),
                      ),
                      elevation: 10,
                    );
                  });
            } else if (snapshot.hasError) {
              return Center(child: Text(snapshot.error.toString()));
            } else {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
          }),
    );
  }
}
