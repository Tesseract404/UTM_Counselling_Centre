import 'package:flutter/material.dart';
import 'package:utm_counselling_centre/Widgets/Buttons/ConfirmButton.dart';

class SlotCard extends StatelessWidget {
  const SlotCard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        print('tapped');
        Navigator.pop(context);
        showDialog<void>(
          context: context,
          //barrierDismissible: false,
          builder: (BuildContext context) {
            return AlertDialog(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),
              contentPadding: EdgeInsets.fromLTRB(12, 0, 12, 0),
              title: const Center(
                child: Text(
                  'Confirm Your Appointment',
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 18,
                    color: Colors.black87,
                  ),
                ),
              ),
              content: Padding(
                padding: const EdgeInsets.fromLTRB(0, 0, 0, 10),
                child: SingleChildScrollView(
                  child: ListBody(
                    children: [
                      Center(
                        child: Padding(
                          padding: EdgeInsets.fromLTRB(0, 18, 0, 20),
                          child: Text(
                            'Sunday - 10am-1pm',
                            style: TextStyle(color: Colors.grey),
                          ),
                        ),
                      ),
                      Row(
                        children: const [
                          Expanded(
                              child: ConfirmButton(
                            title: 'Confirm Booking',

                                color:Color(0xff5D3392 ) ,
                          )),
                          Expanded(
                            child: ConfirmButton(
                              title: 'Cancel',

                              color:Color(0xff9F9F9F ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        );
      },
      child: Padding(
        padding: EdgeInsets.fromLTRB(10, 6, 10, 0),
        child: Container(
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: Color(0xffD9D9D9)),
          child: Center(
            child: Padding(
              padding: EdgeInsets.fromLTRB(0, 12, 0, 12),
              child: Row(
                children: const [
                  Padding(
                    padding: EdgeInsets.fromLTRB(20, 0, 0, 0),
                    child: Text(
                      'Sunday',
                      style: TextStyle(
                        fontWeight: FontWeight.w400,
                        fontSize: 15,
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.fromLTRB(20, 0, 0, 0),
                    child: Text(
                      '10am - 1pm',
                      style: TextStyle(
                        color: Color(0xff4F75FF),
                        fontWeight: FontWeight.w400,
                        fontSize: 15,
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.fromLTRB(20, 0, 10, 0),
                    child: Text(
                      'available slots : 2',
                      style: TextStyle(
                        fontWeight: FontWeight.w400,
                        fontSize: 10,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
