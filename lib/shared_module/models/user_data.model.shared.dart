import 'package:doneapp_driver/shared_module/models/general_item.model.shared.dart';
import 'package:intl/intl.dart';

class UserData {
  final String name;
  final String code;
  final String image;
  final String mobile;
  final int totalOrders;
  final int deliveredOrders;
  final int pendingOrders;
  final List<GeneralItem> shifts;

  UserData({
    required this.name,
    required this.code,
    required this.mobile,
    required this.image,
    required this.totalOrders,
    required this.deliveredOrders,
    required this.pendingOrders,
    required this.shifts,
  });

}

UserData mapUserData(dynamic payload) {
  print("mapUserData");
  print(payload["bmi"]);

  List<GeneralItem> shifts = [];
  shifts.add(GeneralItem.GeneralItem(id: -1, name: "Select Shift", arabicName: "حدد التحول"));
  if(payload["shifts"] != null && payload["shifts"] is! String ){
    payload["shifts"].forEach((element) {
      if(element != null){
        shifts.add(mapGeneralItem(element));
      }
    });
  }
  return UserData(
    image: payload["image"] != null ? payload["image"].toString() : "",
    totalOrders: payload["totalOrders"] ?? 0,
    deliveredOrders: payload["deliveredOrders"] ?? 0,
    pendingOrders: payload["pendingOrders"] ?? 0,
    name: payload["name"] != null ? payload["name"].toString() : "",
    mobile: payload["mobile"] != null ? payload["mobile"].toString() : "",
    code: payload["code"] != null ? payload["code"].toString() : "",
    shifts: shifts,
  );
}
