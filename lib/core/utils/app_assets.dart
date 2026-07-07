class AppAssets {
  // (Base Paths)
  static const String _imagesPath = "assets/images/";
  static const String _navIconsPath = "assets/images/nav_icons/";
  static const String _bannersPath = "assets/images/banners/";
  static const String _statsPath = "assets/images/statistics/";
  static const String _iconsPath = "assets/images/icons/";
  static const String _ordersIconsPath = "assets/images/icons/orders/";
  static const String _moreIconsPath = "assets/images/icons/more/";

  // --- Navigation Icons (Bottom NavBar) ---
  static const String homeSelected = "${_navIconsPath}home_selected.png";
  static const String homeUnselected = "${_navIconsPath}home_unselected.png";
  static const String productsSelected =
      "${_navIconsPath}products_selected.png";
  static const String productsUnselected =
      "${_navIconsPath}products_unselected.png";
  static const String ordersSelected = "${_navIconsPath}orders_selected.png";
  static const String ordersUnselected =
      "${_navIconsPath}orders_unselected.png";
  static const String analyticsSelected =
      "${_navIconsPath}analytics_selected.png";
  static const String analyticsUnselected =
      "${_navIconsPath}analytics_unselected.png";
  static const String moreSelected = "${_navIconsPath}more_selected.png";
  static const String moreUnselected = "${_navIconsPath}more_unselected.png";

  // --- Home Banners ---
  static const String welcomeBannerBg = "${_bannersPath}welcome_banner_bg.png";
  static const String ordersBannerBg = "${_bannersPath}orders_banner_bg.png";
  static const String paymentsBannerBg =
      "${_bannersPath}payments_banner_bg.png";
  static const String alarmIcon = "${_bannersPath}alarm_icon.png";
  static const String walletIcon = "${_bannersPath}wallet_icon.png";

  // --- Statistics Icons ---
  static const String salesIcon = "${_statsPath}sales_icon.png";
  static const String profitsIcon = "${_statsPath}profits_icon.png";
  static const String ordersIcon = "${_statsPath}orders_icon.png";
  static const String reportsIcon = "${_statsPath}reports_icon.png";

  // --- General Images & Logos ---
  static const String logo = "${_imagesPath}logo.png";
  static const String signupImg = "${_imagesPath}signup.png";
  static const String successImg = "${_imagesPath}success.png";
  static const String analyticsHeaderBg =
      "${_imagesPath}analytics_header_bg.png";

  // --- Products & Categories Icons ---
  static const String categoryIcon = "${_iconsPath}category_icon.png";
  static const String emptyOrdersIcon = "${_iconsPath}empty_orders_icon.png";
  static const String supportTicketIcon =
      "${_imagesPath}support_ticket_icon.png";
  static const String emptyProductsIcon = "${_iconsPath}empty_products_icon.svg";


  // --- Order Details Icons (SVG) ---
  static const String dateIcon = "${_ordersIconsPath}date_icon.svg";
  static const String profileIcon = "${_ordersIconsPath}profile_icon.svg";
  static const String phoneIcon = "${_ordersIconsPath}phone_icon.svg";
  static const String mailIcon = "${_ordersIconsPath}mail_icon.svg";
  static const String mapIcon = "${_ordersIconsPath}map_icon.svg";
  static const String noteIcon = "${_ordersIconsPath}note_icon.svg";
  static const String paymentIcon = "${_ordersIconsPath}payment_icon.svg";
  static const String successIcon = "${_ordersIconsPath}success_icon.svg";
  static const String invoiceIcon = "${_ordersIconsPath}invoice_icon.svg";
  static const String trackingIcon = "${_ordersIconsPath}tracking_icon.svg";
  static const String shippingIcon = "${_ordersIconsPath}shipping_icon.svg";
  static const String printIcon = "${_ordersIconsPath}print_icon.svg";

  // --- More Tab Icons (SVG) --- 💡 التعديل الجديد بـ _icon
  // 1. الإدارة المالية
  static const String invoicesIcon = "${_moreIconsPath}invoices_icon.svg";
  static const String profitsMoreIcon = "${_moreIconsPath}profits_icon.svg";

  // 2. العمليات
  static const String inventoryIcon = "${_moreIconsPath}inventory_icon.svg";
  static const String customersIcon = "${_moreIconsPath}customers_icon.svg";

  // 3. الدعم والجودة
  static const String supportIcon = "${_moreIconsPath}support_icon.svg";
  static const String complaintsIcon = "${_moreIconsPath}complaints_icon.svg";

  // 4. التخصيص والنظام
  static const String customizationIcon =
      "${_moreIconsPath}customization_icon.svg";
  static const String notificationsIcon =
      "${_moreIconsPath}notifications_icon.svg";

  // 5. الإعدادات
  static const String settingsIcon = "${_moreIconsPath}settings_icon.svg";
  static const String logoutIcon = "${_moreIconsPath}logout_icon.svg";
  static const String companyIcon = "${_moreIconsPath}company_info_icon.svg";

  // ================== Invoices & Payment Methods ==================
  static const String emptyInvoicesIcon =
      '${_iconsPath}empty_invoices_icon.svg';
  static const String bankTransferIcon = '${_iconsPath}bank_transfer_icon.svg';
  static const String cashPaymentIcon = '${_iconsPath}cash_payment_icon.svg';
  static const String downloadPdfIcon = '${_iconsPath}download_pdf_icon.svg';
  static const String shareInvoiceIcon = '${_iconsPath}share_invoice_icon.svg';
  static const String logoWhite = '${_iconsPath}logo_white.png';
  static const String logoColored = '${_iconsPath}logo_colored.png';
}
