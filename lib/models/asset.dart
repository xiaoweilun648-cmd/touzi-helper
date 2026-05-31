class Asset {
  final String name;
  final double amount;
  final double position; // 仓位百分比

  Asset({required this.name, required this.amount, required this.position});

  factory Asset.fromJson(Map<String, dynamic> json) => Asset(
        name: json['name'],
        amount: json['amount'],
        position: json['position'],
      );

  Map<String, dynamic> toJson() => {
        'name': name,
        'amount': amount,
        'position': position,
      };
}
