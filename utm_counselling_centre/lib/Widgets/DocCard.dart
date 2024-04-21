import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class DocCard extends StatelessWidget {
  final docName;
  final image;
  const DocCard({Key? key, this.docName, this.image}) : super(key: key);

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
                    child: Image(
                      image: AssetImage(
                        image,
                      ),
                    ),
                  ),
                ),
                Expanded(
                  flex: 8,
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(14, 25, 0, 20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children:   [
                        Text(
                          docName,
                          style: const TextStyle(
                            fontWeight: FontWeight.w700,
                            fontSize: 19,
                          ),
                        ),
                        const Text(
                          'degree he/she got',
                          style: TextStyle(
                            fontWeight: FontWeight.w500,
                            fontSize: 13,
                          ),
                        ),
                        const Text(
                          'clinic name',
                          style: TextStyle(
                            fontWeight: FontWeight.w500,
                            fontSize: 13,
                          ),
                        ),
                        const Text(
                          'doc@email.com',
                          style: TextStyle(
                            fontWeight: FontWeight.w500,
                            fontSize: 13,
                          ),
                        ),
                      ],
                    ),
                  ),
                )
              ],
            ),
            GestureDetector(
              onTap: () {
                Navigator.pushNamed(context, '/dash');
              },
              child: Padding(
                padding: const EdgeInsets.fromLTRB(0, 0, 10, 10),
                child: Align(
                  alignment: Alignment.centerRight,
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(6),
                      color: const Color(0xff5D3392 ),
                    ),
                    child: Padding(
                      padding:   const EdgeInsets.fromLTRB(22, 5, 22, 5),
                      child: Text(
                        'Check Schedules',
                        style:   TextStyle(
                          color: Colors.white,
                          fontSize: 13,
                          fontFamily: GoogleFonts.inter().fontFamily ,
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
