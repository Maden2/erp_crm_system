class ApiConstants {
  static const String baseUrl = "https://backend-crm-pivot-zdth.vercel.app";

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

  // ================== INVENTORY ENDPOINTS ==================
  static const String inventorySummary = "/api/inventory/summary";
  static const String inventoryReport = "/api/inventory/report";
  static const String inventoryWarehouses = "/api/inventory/warehouses";
  static const String stockMoves = "/api/inventory/stock-moves";
  static const String stockAdjustments = "/api/inventory/stock-adjustments";

  static String warehouseDetails(String id) => "/api/inventory/warehouses/$id";
  static String productStockDetails(String productId) => "/api/inventory/products/$productId/stock";

  // ================== CUSTOMERS ENDPOINTS ==================
  static const String customerStats = "/api/customers/stats";
  static const String customersList = "/api/customers";
  static const String topCustomers = "/api/customers/top";
  static String customerDetails(String id) => "/api/customers/$id";

  // ================== COMPLAINTS (TICKETS) ENDPOINTS  ==================
  static const String complaintsListAndStats = "/api/complaints";
  static const String createTestimonial = "/api/complaints/testimonials";
  static String complaintDetails(String id) => "/api/complaints/$id";
  static String updateComplaintStatus(String id) => "/api/complaints/$id";

  // ================== NOTIFICATIONS (NOTICES) ENDPOINTS  ==================
  static const String notifications = "/api/notifications";
  static const String markAllNotificationsRead = "/api/notifications/read-all";
  static String markNotificationAsRead(String id) => "/api/notifications/$id/read";
  static String deleteNotification(String id) => "/api/notifications/$id";

  // ================== AI INSIGHTS ENDPOINTS (NEW MODULE) ==================
  static const String aiInsights = "/api/ai/insights";
  static const String generateAiInsights = "/api/ai/insights/generate";
  static const String aiInsightsFeedback = "/api/ai/insights/feedback";
  static String markAiInsightSeen(String id) => "/api/ai/insights/$id/seen";
  static const String getAdminFeedback = "/api/ai/insights/admin/feedback";
}