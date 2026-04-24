class TranscationModel {
  final String id;
  final String userName;
  final double amount;
  final String type;
  final String status;
  final String date;

  TranscationModel({
    required this.id,
    required this.userName,
    required this.amount,
    required this.type,
    required this.status,
    required this.date,
  });

  factory TranscationModel.fromJson(Map<String, dynamic> json) {
    return TranscationModel(
      id: json['id'] ?? '',
      userName: json['userName'] ?? 'User',
      // Fixed key name
      // ✅ FIX: Convert String amount to double safely
      amount: double.tryParse(json['amount'].toString()) ?? 0.0,
      type: json['type'] ?? '',
      status: json['status'] ?? '',
      date: json['datetime'] ?? '',
    );
  }
}