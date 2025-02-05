class SPricingCalculator {
  //Calculator price based on tax and shipping
  static double calculateTotalPrice(double productPrice, String location) {
    double taxRate = getTaxRateForLocation(location);
    double taxAmount = productPrice * taxRate;

    double shippingCost = getShippingCost(location);
    double totalPrice = productPrice + taxAmount + shippingCost;
    return totalPrice;
  }
  //Calculate shipping cost
  static String calculateShippingCost(double productPrice, String location) {
    double shippingCost = getShippingCost(location);
    return shippingCost.toStringAsFixed(2);
  }
  //Calculate tax
  static String calculateTax(double productPrice, String location) {
    double taxRate = getTaxRateForLocation(location);
    double taxAmount = productPrice * taxRate;
    return taxAmount.toStringAsFixed(2);
  }

  static double getTaxRateForLocation(String location) {
    //Looking the tax rate for a given location fro  a tax rate database or API
    //Return the appropriate tax rate
    return 0.10; // example of tax rate of 10%
  }

  static double getShippingCost(String location) {
    //Looking the shipping cost for a given location from  a tax rate database or API
    //Calculate the shipping costs based on various factors like distance, weight e.t.c
    return 5.00; //example of $5 shipping costs
  }
}