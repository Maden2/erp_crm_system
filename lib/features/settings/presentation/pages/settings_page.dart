import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pivot/core/utils/app_colors.dart';
import 'package:pivot/core/utils/app_styles.dart';
import '../../../../core/widgets/custom_app_bar.dart';
import '../widgets/account_info_card.dart';
import '../widgets/language_currency_card.dart';
import '../widgets/system_connection_card.dart';
import '../widgets/payment_shipping_card.dart';
import '../widgets/notification_settings_card.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.homeBg,
      appBar: CustomAppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          "الإعدادات",
          style: TextStyles.font20WhiteMedium.copyWith(fontFamily: 'Cairo'),
        ),
      ),
      body: const SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 16, vertical: 14),
          child: Column(
            children: [
              AccountInfoCard(),
              SizedBox(height: 12),
              LanguageCurrencyCard(),
              SizedBox(height: 12),
              SystemConnectionCard(),
              SizedBox(height: 12),
              PaymentShippingCard(),
              SizedBox(height: 12),
              NotificationSettingsCard(),
              SizedBox(height: 24),
            ],
          ),
        ),
      ),
    );
  }
}