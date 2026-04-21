import 'package:flutter/material.dart';

class TicketWidget extends StatelessWidget {
  final List<Map<String,String>> tickets;
  const TicketWidget({super.key,required this.tickets});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(
        top: 16,
        left: 16,
        right: 16,
      ),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border:Border.all(color: Colors.grey.shade300),
      ),
      child: Column(
        children: [
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child:Row(
             children: const [
               SizedBox(width: 120,child: Text("TICKET NUMBER",style: TextStyle(color: Colors.black54),)),
               SizedBox(width: 150,child: Text("PICKED NUMBERS",style: TextStyle(color: Colors.black54))),
               SizedBox(width: 150, child: Text("USER NAME",style: TextStyle(color: Colors.black54))),
               SizedBox(width: 100, child: Text("PRICE",style: TextStyle(color: Colors.black54))),
               SizedBox(width: 100, child: Text("STATUS",style: TextStyle(color: Colors.black54))),
               SizedBox(width: 120, child: Text("DATE",style: TextStyle(color: Colors.black54))),
             ],
      ),
          ),
          const Divider(height: 30),
          ///DATA
          Expanded(
              child: tickets.isEmpty
                  ? const Center(child:Text("No tickets found"))
                  :ListView.builder(
                itemCount: tickets.length,
                  itemBuilder:(context,index){
                    final ticket=tickets[index];
                    return SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        children: [
                          SizedBox(
                            width: 120,
                            child: Text(ticket["ticket"]!)),
                          SizedBox(
                            width: 150,
                            child: Text(ticket["numbers"]!),
                          ),
                          SizedBox(
                              width: 150,
                              child: Text(ticket["user"]!)),
                          SizedBox(
                              width: 100,
                              child: Text(ticket["price"]!)),
                          SizedBox(
                              width: 100,
                              child: Text(ticket["status"]!)),
                          SizedBox(
                              width: 120,
                              child: Text(ticket["date"]?? "")),
                        ],
                      ),
                    );
                  },

              )
          )

        ],
      ),
    );
  }
}
