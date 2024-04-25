import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class PaitientDetails extends StatefulWidget {
  const PaitientDetails({super.key});

  @override
  State<PaitientDetails> createState() => _PaitientDetailsState();
}

class _PaitientDetailsState extends State<PaitientDetails> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            "Paitient History",
            style: TextStyle(color: Colors.white),
            textAlign: TextAlign.center,
          ),
        ),
        iconTheme: IconThemeData(color: Colors.white),
        backgroundColor: Color(0xff006f76),
      ),
      body: StreamBuilder(
        stream: getContactsStream(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          if (snapshot.data!.docs.isEmpty) {
            return const Center(
              child: Text(
                "No Paitient Details Available",
                style: TextStyle(color: Colors.black),
              ),
            );
          }
          return ListView.builder(
            itemCount: snapshot.data!.docs.length,
            itemBuilder: (BuildContext context, int index) {
              final List<DocumentSnapshot> documents = snapshot.data!.docs;
              final Map<String, dynamic> data =
                  documents[index].data() as Map<String, dynamic>;
              DateTime timeStamp = (data['timeStamp'] as Timestamp).toDate();
              return Card(
                elevation: 1,
                color: Colors.white,
                child: Column(
                  children: [
                    ListTile(
                      leading: Image.network(data['imageUrl']),
                      title: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Total Brightness',
                            style: GoogleFonts.plusJakartaSans(
                              color: Colors.black,
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            data['brightness'].toString(),
                            style: GoogleFonts.plusJakartaSans(
                              color: Colors.black,
                              fontSize: 12,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Date",
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            "${timeStamp.year}-${_formatTwoDigits(timeStamp.month)}-${_formatTwoDigits(timeStamp.day)}",
                          ),
                          const SizedBox(height: 5),
                          Text(
                            "Time",
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            "${_formatTwoDigits(timeStamp.hour)}:${_formatTwoDigits(timeStamp.minute)}:${_formatTwoDigits(timeStamp.second)}",
                          ),
                        ],
                      ),
                      // Add more fields as needed
                      trailing: IconButton(
                          onPressed: () {
                            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                                content: Text("Picture Shared Successfully")));
                          },
                          icon: Icon(Icons.share)),
                    ),
                  ],
                ),
              );
            },
          );
        },
      ),
    );
  }

  Stream<QuerySnapshot> getContactsStream() {
    return FirebaseFirestore.instance
        .collection("images")
        .where("uid", isEqualTo: FirebaseAuth.instance.currentUser!.uid)
        .snapshots();
  }

  String _formatTwoDigits(int number) {
    return number.toString().padLeft(2, '0');
  }
}
