import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../../../models/transcation_model.dart';

class TransactionTile extends StatelessWidget {
  final TranscationModel transaction;
  const TransactionTile({super.key, required this.transaction});

  @override
  Widget build(BuildContext context) {
    bool isCredit = transaction.type == "credit";
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 16),
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(color: Color(0xFF1F3D32)),
        )
      ),
      child: Row(
        children: [
          CircleAvatar(
            radius: 22,
            backgroundColor:isCredit ? const Color(0xFF0E3B2F):const Color(0xFF1C2B26),
            child: Icon(
              isCredit ? Icons.arrow_downward : Icons.arrow_upward,
              color: isCredit? Colors.green : Colors.white,
            ),
          ),
          const SizedBox(width: 14),
          Expanded(child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                transaction.type,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.w600),
                ),
            const SizedBox(height: 4),
            Text(
              transaction.date,
              style: TextStyle(
                color: Colors.grey,
                fontSize: 13,
              ),
            ),
            ],
          )),
          //RIGHT AMOUNT
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                "${isCredit ? "+" : "-"}₹${transaction.amount.toStringAsFixed(2)}",
                style: TextStyle(
                  color: isCredit ? Colors.green : Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),),
              Text(
                transaction.status,
                style: const TextStyle(
                  color: Colors.grey,
                  fontSize: 12,
                ),)
            ],

          )
        ],
      ),
    );
  }
}
