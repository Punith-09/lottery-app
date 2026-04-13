class DrawResult {
  final String id;
  final String drawName;
  final String prizePool;
  final DateTime drawDate;
  final String gameTypeName;
  final List<int> winningNumbers;
  final int specialNumber;
  final int winnersCount;
  final String totalPrizePaid;

  DrawResult({
    required this.id,
    required this.drawName,
    required this.prizePool,
    required this.drawDate,
    required this.gameTypeName,
    required this.winningNumbers,
    required this.specialNumber,
    required this.winnersCount,
    required this.totalPrizePaid,
  });

  factory DrawResult.fromJson(Map<String, dynamic> json) {
    // 1. SAFE STRING SPLIT: Use 'as String?' and provide a fallback "0,0"
    final String rawNumbers = (json['winningNumbers'] as String?) ?? "0,0";
    final List<String> parts = rawNumbers.split(',');

    // 2. SAFE LIST MAPPING: Filter out empty strings before parsing
    final List<int> numbers = parts
        .take(parts.length > 0 ? parts.length - 1 : 0)
        .map((e) => int.tryParse(e.trim()) ?? 0)
        .toList();

    // 3. SAFE SPECIAL NUMBER:
    final int special = int.tryParse(parts.last.trim()) ?? 0;

    return DrawResult(
      // Use .toString() and ?? fallback to handle nulls safely
      id: json['id']?.toString() ?? '',
      drawName: json['drawName']?.toString() ?? 'No Name',
      prizePool: json['prizePool']?.toString() ?? '0.00',

      // Safe Date parsing
      drawDate: json['drawDate'] != null
          ? (DateTime.tryParse(json['drawDate']) ?? DateTime.now())
          : DateTime.now(),

      // FIX: Your API returns 'gameTypeName', but your code looked for 'gameType'
      gameTypeName: json['gameTypeName']?.toString() ?? 'General',

      winningNumbers: numbers,
      specialNumber: special,

      // Ensure winnersCount is an int even if it comes as a string or null
      winnersCount: json['winnersCount'] is int
          ? json['winnersCount']
          : int.tryParse(json['winnersCount']?.toString() ?? '0') ?? 0,

      totalPrizePaid: json['totalPrizePaid']?.toString() ?? '0.00',
    );
  }
}