import 'package:doneapp_driver/feature_modules/auth/ui/login.page.auth.dart';
import 'package:doneapp_driver/feature_modules/auth/ui/reset-password/reset_password.page.auth.dart';
import 'package:doneapp_driver/order_details.page.core.dart';
import 'package:doneapp_driver/orders.page.core.dart';
 import 'package:doneapp_driver/shared_module/ui/pages/settings.page.profile.dart';
import 'package:doneapp_driver/gif_splash.page.core.dart';
import 'package:doneapp_driver/landing.page.core.dart';
import 'package:doneapp_driver/notifications.page.core.dart';
import 'package:doneapp_driver/privacy.page.core.dart';
import 'package:doneapp_driver/shared_module/constants/app_route_names.constants.shared.dart';
import 'package:doneapp_driver/shared_module/ui/pages/otp_verification_mobile_input.page.shared.dart';
import 'package:doneapp_driver/shared_module/ui/pages/otp_verification_otp_input.page.shared.dart';
import 'package:doneapp_driver/shared_module/ui/pages/success_confirmation.page.shared.dart';
import 'package:doneapp_driver/terms.page.core.dart';
import 'package:get/get.dart';

AppPages() => [
      GetPage(
        name: AppRouteNames.splashScreenRoute,
        page: () => const GifSplashPage_Core(),
      ),
      GetPage(
        name: AppRouteNames.loginRoute,
        page: () => const LoginPage_Auth(),
      ),
      GetPage(
        name: AppRouteNames.otpVerificationMobileInputRoute,
        page: () => OtpVerificationMobileInputPage_Shared(),
      ),
      GetPage(
        name: AppRouteNames.otpVerificationOtpInputRoute,
        page: () => OtpVerificationOtpInputPage_Shared(),
      ),
      GetPage(
        name: AppRouteNames.otpVerificationSuccessRoute,
        page: () => SuccessConfirmationPage_Shared(),
      ),
      GetPage(
        name: AppRouteNames.resetPasswordNewpasswordRoute,
        page: () => ResetPasswordPage_auth(),
      ),
      GetPage(
        name: AppRouteNames.homeRoute,
        page: () => LandingPage_Core(),
      ),
      GetPage(
        name: AppRouteNames.notificationsRoute,
        page: () => NotificationsPage_Core(),
      ),

      GetPage(
        name: AppRouteNames.settingsPageRoute,
        page: () => SettingsPage_Profile(),
      ),
      GetPage(
        name: AppRouteNames.termsRoute,
        page: () => TermsPage_Core(),
      ),
      GetPage(
        name: AppRouteNames.privacyRoute,
        page: () => PrivacyPage_Core(),
      ),
      GetPage(
        name: AppRouteNames.ordersList,
        page: () => OrdersPage_Core(isBackbuttonVisible: true),
      ),
      GetPage(
        name: AppRouteNames.ordersDetails,
        page: () => OrderDetailsPage_Core(),
      ),
    ];
