class Box {
  final int length;
  final int width;
  final int height;
  final int weight;
  final int quantity;
  final bool isStackable;

  Box({
    required this.length,
    required this.width,
    required this.height,
    required this.weight,
    required this.quantity,
    required this.isStackable,
  });

  Map<String, dynamic> toJson() {
    return {
      'boxLength': length,
      'boxWidth': width,
      'boxHeight': height,
      'boxWeight': weight,
      'boxQuantity': quantity,
      'isStackable': isStackable,
    };
  }
}
