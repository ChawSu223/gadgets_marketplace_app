class CartItemRepositories {
  double getUnitItemTotalPrice(double unitPrice, int qty) {
    return unitPrice * qty;
  }

  double getSubTotalPrice(List<Map<String, dynamic>> items) {
    double subTotal = 0;
    for (var item in items) {
      double unitPrice = item['product'].price;
      int qty = item['quantity'];
      subTotal += unitPrice * qty;
    }
    return subTotal;
  }

  double getShippingEstimate(List<Map<String, dynamic>> items) {
    int totalQuantity = 0;
    double shipEstimate = 1000;

    for (var item in items) {
      totalQuantity = totalQuantity + item['quantity'] as int;
    }

    if (totalQuantity == 1) {
      return shipEstimate;
    } else {
      shipEstimate = shipEstimate + (totalQuantity - 1) * 100;
      return shipEstimate;
    }
  }

  double getTaxForCartItems(double totalPrice) {
    double tax = 0;
    tax = totalPrice * 0.02;
    return tax;
  }

  double getGrandTotalPrice(double subTotal, double shipCost, double tax) {
    return subTotal + shipCost + tax;
  }
}
