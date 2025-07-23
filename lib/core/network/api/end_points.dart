class EndPoints {
  static const String baseUrl = 'https://FIG.com/';

  static const String getAllProductsFilteredByFeaturedAndorderby = 'products';
  static const String registerEndPoint = 'customers';
  static const String allCategoriesListEndPoint = 'products/categories';
  static const String categoriesListEndPoint = 'products/categories';
  static const String productsListPerCategoryIdEndPoint = 'products';
  static const String getProductDetailsEndPoint = 'products/';
  static const String searchInProductsEndPoint = 'products';
  static const String getCartProductsEndPoint = 'wp-json/wc/store/cart';
  static const String addToCartProductsEndPoint =
      '/wp-json/wc/store/cart/items';
  static const String editProductQuantityEndPoint =
      'wp-json/wc/store/v1/cart/items/';
  static const String deleteAllProductsInCartEndPoint =
      'wp-json/wc/store/v1/cart/items/';

  static const String paymentEndpoint =
      'https://api.stripe.com/v1/payment_intents';

  static const String creatOrderEndpoint = 'wp-json/wc/v3/orders';
}
