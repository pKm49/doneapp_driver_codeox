class MyOrder {
  final int id;
  final String image;
  final String name;
  final String arabicName;
  final String area;
  final String areaArabic;
  final String street;
  final String jedha;
  final String houseNumber;
  final String floorNumber;
  final String status;
  final String mobile;

  MyOrder({
    required this.id,
    required this.image,
    required this.name,
    required this.arabicName,
    required this.area,
    required this.areaArabic,
    required this.street,
    required this.jedha,
    required this.houseNumber,
    required this.floorNumber,
    required this.status,
    required this.mobile,
  });
}

MyOrder mapMyOrder(dynamic payload) {
  return MyOrder(
    name: payload["name"] != null ? payload["name"].toString() : "",
    arabicName:
        payload["arabic_name"] != null ? payload["arabic_name"].toString() : "",
    image: payload["image"] != null ? payload["image"].toString() : "",
    id: payload["id"] != null ? payload["id"] : -1,
    street: payload["street"] ?? "",
    area: payload["area"] != null
        ? payload["area"].toString() == 'false'
            ? ''
            : payload["area"].toString()
        : "",
    areaArabic: payload["area_arabic"] != null
        ? payload["area_arabic"].toString() == 'false'
            ? ''
            : payload["area_arabic"].toString()
        : "",
    jedha: payload["jedha"] != null ? payload["jedha"].toString() : "",
    houseNumber: payload["house_number"] != null
        ? payload["house_number"].toString()
        : "",
    floorNumber: payload["floor_number"] != null
        ? payload["floor_number"].toString()
        : "",
    status: payload["status"] != null ? payload["status"].toString() : "",
    mobile: payload["phone"] != null ? payload["phone"].toString() : "",
  );
}
