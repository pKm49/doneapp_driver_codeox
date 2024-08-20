import 'package:doneapp_driver/shared_module/constants/app_route_names.constants.shared.dart';
import 'package:doneapp_driver/shared_module/constants/asset_urls.constants.shared.dart';
import 'package:doneapp_driver/shared_module/constants/style_params.constants.shared.dart';
import 'package:doneapp_driver/shared_module/constants/widget_styles.constants.shared.dart';
import 'package:doneapp_driver/shared_module/services/utility-services/widget_generator.service.shared.dart';
import 'package:doneapp_driver/shared_module/services/utility-services/widget_properties_generator.service.shared.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ionicons/ionicons.dart';


class CustomCurveShapeComponentHome_Shared extends StatelessWidget {

  const CustomCurveShapeComponentHome_Shared({super.key, required this.title, required this.subtitle, required this.color});

  final String title;
  final String subtitle;
  final Color color;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    double screenwidth = MediaQuery.of(context).size.width;
    double screenheight = MediaQuery.of(context).size.height;

    return ClipPath(
clipper: CustomClipPath(),
      child: Container(
        decoration: BoxDecoration(color: color,boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 5,
            blurRadius: 4,
            offset: Offset(4, 8),// changes position of shadow
          ),
        ],),
        height: size.height * 0.2,
        width: size.width,
        child: Container(
          width: screenwidth,
          padding: EdgeInsets.all(APPSTYLE_SpaceMedium),
          child:  Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                  decoration: APPSTYLE_BorderedContainerDarkMediumDecoration.copyWith(
                      borderRadius: BorderRadius.circular(1000),
                      color: APPSTYLE_BackgroundWhite
                  ),
                  padding: APPSTYLE_ExtraSmallPaddingAll,
                  width: screenwidth*.13,
                  child: Image.asset(ASSETS_DEFAULTPROFILEPIC,)),
              addHorizontalSpace(APPSTYLE_SpaceSmall),
              Expanded(
                  child:Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      FittedBox(

                        child: Text('hey_username'.tr.replaceAll('username', "Prasanth K M"),
                          textAlign: TextAlign.start,
                          style: getBodyMediumStyle(context).copyWith(
                              color: APPSTYLE_BackgroundWhite,
                              fontWeight: APPSTYLE_FontWeightBold),
                        ),
                        fit:BoxFit.scaleDown,
                      ),
                      FittedBox(
                        fit:BoxFit.scaleDown,
                        child: Text(getGreetingText().tr,
                          textAlign: TextAlign.start,
                          style: getLabelLargeStyle(context).copyWith(
                            color: APPSTYLE_BackgroundWhite,

                          ),
                        ),
                      ),
                    ],
                  )),
              InkWell(
                onTap:(){
                  Get.toNamed(AppRouteNames.notificationsRoute);
                },
                child: Icon(Ionicons.notifications_outline,
                    color: APPSTYLE_BackgroundWhite,
                    size: APPSTYLE_FontSize24),
              ),
              addHorizontalSpace(APPSTYLE_SpaceMedium),

              InkWell(
                onTap:(){
                  Get.toNamed(AppRouteNames.notificationsRoute);
                },
                child: Icon(Ionicons.call_outline,
                    color: APPSTYLE_BackgroundWhite,
                    size: APPSTYLE_FontSize24),
              ),
            ],
          ),
        ),
      ),
    );
  }

  String getGreetingText() {
    DateTime currentDate = DateTime.now();
    print("currentDate.hour");
    print(currentDate.hour);
    if(currentDate.hour<12){
      return "good_morning";
    }else if(currentDate.hour<16){
      return "good_afternoon";
    }else{
      return "good_evening";
    }
  }



}

class CustomClipPath extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path path_0 = Path();
    path_0.moveTo(0, 0);
    path_0.lineTo(0, size.height * 0.25);
    path_0.quadraticBezierTo(size.width * 0.2680000, size.height * 0.8165000,
        size.width * 0.5000000, size.height * 0.8000000);
    path_0.quadraticBezierTo(size.width * 0.7332500, size.height * 0.8065000,
        size.width, size.height * 0.25);
    path_0.lineTo(size.width, 0);
    path_0.lineTo(0, 0);
    path_0.close();

    return path_0;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) {
    return false;
  }
}
