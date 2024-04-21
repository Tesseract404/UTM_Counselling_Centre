import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter/services.dart';
import 'package:utm_counselling_centre/Constants/AppColors.dart';
import 'SlotCard.dart';

class DocCard extends StatelessWidget {
  final String docName;
  final String image;
  final String degree;
  final String clinic;
  final String email;

  const DocCard(
      {Key? key,
      required this.docName,
      required this.image,
      required this.degree,
      required this.clinic,
      required this.email})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(15, 15, 15, 0),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: const Color(0xffECDDFF),
        ),
        child: Column(
          children: [
            Row(
              children: [
                Expanded(
                  flex: 2,
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(9, 8, 0, 0),
                    child: image.isNotEmpty
                        ? Image.network(
                            image,
                            loadingBuilder: (context, child, loadingProgress) {
                              if (loadingProgress == null) return child;
                              return Center(
                                child: CircularProgressIndicator(
                                  value: loadingProgress.expectedTotalBytes !=
                                          null
                                      ? loadingProgress.cumulativeBytesLoaded /
                                          loadingProgress.expectedTotalBytes!
                                      : null,
                                ),
                              );
                            },
                            errorBuilder: (context, error, stackTrace) {
                              return Icon(Icons.person);
                            },
                          )
                        : Icon(Icons
                            .error), // Show an error icon if the URL is empty
                  ),
                ),
                Expanded(
                  flex: 8,
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(14, 25, 0, 20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          docName,
                          style: const TextStyle(
                            fontWeight: FontWeight.w700,
                            fontSize: 19,
                          ),
                        ),
                        Text(
                          degree,
                          style: TextStyle(
                            fontWeight: FontWeight.w500,
                            fontSize: 12,
                            color: AppColors.secondaryTextColor,
                          ),
                        ),
                        Text(
                          clinic,
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 13,
                          ),
                        ),
                        Row(
                          children: [
                            Padding(
                              padding: const EdgeInsets.fromLTRB(0, 0, 5, 0),
                              child: Text(
                                email,
                                style: const TextStyle(
                                  fontWeight: FontWeight.w500,
                                  fontSize: 13,
                                  color: AppColors.primaryColor,
                                ),
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),

                            GestureDetector(
                              onTap: () {
                                Clipboard.setData(ClipboardData(text: email));
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                    content: Text('Email copied to clipboard'),
                                    duration: Duration(seconds: 2),
                                  ),
                                );
                              },
                              child: const Icon(
                                Icons.copy,
                                size: 16,
                                color: AppColors.secondaryTextColor,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                )
              ],
            ),
            GestureDetector(
              onTap: () {
                print('tapped');
                showDialog<void>(
                  context: context,
                  //barrierDismissible: false,  user must tap button!
                  builder: (BuildContext context) {
                    return AlertDialog(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      contentPadding: EdgeInsets.zero,
                      title: Center(
                        child: Text(
                          'All Schedule of $docName',
                          style: TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: 19,
                            color: Colors.black87,
                          ),
                        ),
                      ),
                      content: Padding(
                        padding: EdgeInsets.fromLTRB(0, 0, 0, 10),
                        child: SingleChildScrollView(
                          child: ListBody(
                            children: [
                              Padding(
                                padding: EdgeInsets.fromLTRB(0, 18, 0, 0),
                                child: SlotCard(),
                              ),
                              SlotCard(counsellor: docName),
                              SlotCard(counsellor: docName),
                              SlotCard(counsellor: docName),
                              SlotCard(counsellor: docName),
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                );
              },
              child: Padding(
                padding: const EdgeInsets.fromLTRB(0, 0, 10, 10),
                child: Align(
                  alignment: Alignment.centerRight,
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(6),
                      color: const Color(0xff5D3392),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(22, 5, 22, 5),
                      child: Text(
                        'Check Schedules',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 13,
                          fontFamily: GoogleFonts.inter().fontFamily,
                          fontWeight: FontWeight.w200,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
