class MyOrder {
  final int id;
  final String customerId;
  final String image;
  final String name;
  final String arabicName;
  final String area;
  final String blockArabic;
  final String block;
  final String areaArabic;
  final String street;
  final String jedha;
  final String houseNumber;
  final String floorNumber;
  final String status;
  final String mobile;
  final int queue;

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
    required this.queue,
    required this.customerId,
    required this.block,
    required this.blockArabic,
  });
}

MyOrder mapMyOrder(dynamic payload) {
  return MyOrder(
    name: (payload["name"] != null  && payload["name"] != false)?  payload["name"].toString() : "",
    arabicName: (payload["arabic_name"] != null  && payload["arabic_name"] != false)  ? payload["arabic_name"].toString() : "",
    image: payload["image"] != null ? payload["image"].toString() : "",
    queue: (payload["queue_no"] != null && payload["queue_no"] != '')? payload["queue_no"]: -1,
    id: (payload["id"] != null && payload["id"] != '')? payload["id"]: -1,
    customerId: (payload["customer_id"] != null && payload["customer_id"] != '')? payload["customer_id"].toString(): "",
    street: payload["street"] ?? "",
    block: payload["block"] != null
        ? payload["block"].toString() == 'false'
        ? ''
        : payload["block"].toString()
        : "",
    blockArabic: payload["block_arabic"] != null
        ? payload["block_arabic"].toString() == 'false'
        ? ''
        : payload["block_arabic"].toString()
        : "",
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
    mobile: (payload["phone"] != null  && payload["phone"] != false)? payload["phone"].toString() : "",
  );
}
