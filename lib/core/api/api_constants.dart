class ApiConstants {
  static const String baseUrl = "https://backend-crm-pivot.vercel.app";

  // ================== AUTH ENDPOINTS ==================
  static const String login = "/api/auth/login";
  static const String getCurrentUser = "/api/auth/me";
  static const String logout = "/api/auth/logout";
  static const String permissions = "/api/auth/permissions";

  // Forgot Password Flow
  static const String forgotPasswordRequest = "/api/auth/forgot-password/request";
  static const String forgotPasswordVerify = "/api/auth/forgot-password/verify";
  static const String forgotPasswordReset = "/api/auth/forgot-password/reset";

  // ================== DASHBOARD ENDPOINTS ==================
  static const String dashboardHome = "/api/dashboard/home";
  static const String salesChart = "/api/dashboard/sales-chart";

  // ================== ORDERS ENDPOINTS ==================
  static const String orders = "/api/orders";
  static const String orderStatuses = "/api/orders/statuses";
  static const String orderSummary = "/api/orders/summary";
  static String updateOrderStatus(String id) => "/api/orders/$id/status";
  static String orderDetails(String id) => "/api/orders/$id";

  // ================== ANALYTICS ENDPOINTS ==================
  static const String analytics = "/api/analytics";

  // ================== INVOICES ENDPOINTS ==================
  static const String invoiceStatuses = "/api/invoices/statuses";
  static const String invoiceStats = "/api/invoices/stats";
  static const String invoices = "/api/invoices";
  static String invoiceDetails(String id) => "/api/invoices/$id";

  // ================== WEBSITE PRODUCTS ENDPOINTS ==================
  static const String websiteProducts = "/api/website-products";
  static const String websiteCategories = "/api/website-products/categories";
  static const String websiteInventoryCategories = "/api/website-products/inventory-categories";
  static const String websiteUnpublishedProducts = "/api/website-products/unpublished";
  static const String publishFromInventory = "/api/website-products/publish-from-inventory";

  // دوال الـ Endpoints اللّي بتستقبل ID متغير بالملي
  static String websiteProductDetails(String id) => "/api/website-products/$id";
  static String updateWebsiteProduct(String id) => "/api/website-products/$id";
  static String deleteWebsiteProduct(String id) => "/api/website-products/$id";
  static String toggleWebsiteProductPublish(String id) => "/api/website-products/$id/publish";
}