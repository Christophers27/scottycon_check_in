import 'dart:convert';

class UserFields {
  static const String id = 'Order_';
  static const String firstName = 'ShippingFirstName';
  static const String lastName = 'ShippingLastName';
  static const String isStudent = 'ProductOptions';
  static const String ticketNum = 'ProductQuantity';
  static const String ticketCost = 'ProductPrice';
  static const String ticketSaleCost = 'ProductSalePrice';
  static const String totalTicketSaleCost = 'ProductTotalPrice';
  static const String coupon = 'Coupon';
  static const String giftCard = "Dunkin' Gift Card";

  static List<String> getFields() => [
        id,
        firstName,
        lastName,
        isStudent,
        ticketNum,
        ticketCost,
        ticketSaleCost,
        totalTicketSaleCost,
        coupon,
        giftCard
      ];
}

class User {
  final int id;
  final String firstName;
  final String lastName;
  final bool isStudent;
  final int ticketNum;
  final int ticketCost;
  final int ticketSaleCost;
  final int totalTicketSaleCost;
  final String coupon;
  final bool giftCard;

  const User({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.isStudent,
    required this.ticketNum,
    required this.ticketCost,
    required this.ticketSaleCost,
    required this.totalTicketSaleCost,
    required this.coupon,
    required this.giftCard,
  });

  User copy({int? id, String? firstName, String? lastName, bool? isStudent,
  int? ticketNum, int? ticketCost, int? ticketSaleCost, int? totalTicketSaleCost,
  String? coupon, bool? isTrue}) => User(
      id: id ?? this.id,
      firstName: firstName ?? this.firstName,
      lastName: lastName ?? this.lastName,
      isStudent: isStudent ?? this.isStudent,
      ticketNum: ticketNum ?? this.ticketNum,
      ticketCost: ticketCost ?? this.ticketCost,
      ticketSaleCost: ticketSaleCost ?? this.ticketSaleCost,
      totalTicketSaleCost: totalTicketSaleCost ?? this.totalTicketSaleCost,
      coupon: coupon ?? this.coupon,
      giftCard: isTrue ?? this.giftCard);

  static User fromJson(Map<String, dynamic> json) => User(
        id: jsonDecode(json[UserFields.id]),
        firstName: json[UserFields.firstName],
        lastName: json[UserFields.lastName],
        isStudent: jsonDecode(json[UserFields.isStudent]),
        ticketNum: jsonDecode(json[UserFields.ticketNum]),
        ticketCost: jsonDecode(json[UserFields.ticketCost]),
        ticketSaleCost: jsonDecode(json[UserFields.ticketSaleCost]),
        totalTicketSaleCost: jsonDecode(json[UserFields.totalTicketSaleCost]),
        coupon: json[UserFields.coupon],
        giftCard: jsonDecode(json[UserFields.giftCard]),
      );

  Map<String, dynamic> toJson() => {
        UserFields.id: id,
        UserFields.firstName: firstName,
        UserFields.lastName: lastName,
        UserFields.isStudent: isStudent,
        UserFields.ticketNum: ticketNum,
        UserFields.ticketCost: ticketCost,
        UserFields.ticketSaleCost: ticketSaleCost,
        UserFields.totalTicketSaleCost: totalTicketSaleCost,
        UserFields.coupon: coupon,
        UserFields.giftCard: giftCard
      };
}
