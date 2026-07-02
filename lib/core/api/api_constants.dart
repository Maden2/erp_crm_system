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
}