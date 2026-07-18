class SettingsEntity {
  final AccountInfoEntity accountInfo;
  final LanguageCurrencyEntity languageCurrency;
  final SystemConnectionEntity systemConnection;
  final PaymentInfoEntity paymentInfo;
  final NotificationPreferencesEntity notificationPreferences;
  final String lastUpdated;

  const SettingsEntity({
    required this.accountInfo,
    required this.languageCurrency,
    required this.systemConnection,
    required this.paymentInfo,
    required this.notificationPreferences,
    required this.lastUpdated,
  });
}

class AccountInfoEntity {
  final String fullName;
  final String email;
  final String phoneNumber;

  const AccountInfoEntity({
    required this.fullName,
    required this.email,
    required this.phoneNumber,
  });
}

class LanguageCurrencyEntity {
  final String language;
  final String currency;

  const LanguageCurrencyEntity({
    required this.language,
    required this.currency,
  });
}

class SystemConnectionEntity {
  final String tenantName;
  final String planName;
  final int subscriptionStatus;
  final String currentPeriodEnd;
  final bool isConnected;

  const SystemConnectionEntity({
    required this.tenantName,
    required this.planName,
    required this.subscriptionStatus,
    required this.currentPeriodEnd,
    required this.isConnected,
  });
}

class PaymentInfoEntity {
  final int paymentGatewaysCount;
  final int shippingCompaniesCount;

  const PaymentInfoEntity({
    required this.paymentGatewaysCount,
    required this.shippingCompaniesCount,
  });
}

class NotificationPreferencesEntity {
  final bool newOrders;
  final bool lowStock;
  final bool techSupport;
  final bool systemUpdates;
  final String updatedAt;

  const NotificationPreferencesEntity({
    required this.newOrders,
    required this.lowStock,
    required this.techSupport,
    required this.systemUpdates,
    required this.updatedAt,
  });
}