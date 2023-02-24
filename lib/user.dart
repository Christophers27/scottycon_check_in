import 'dart:convert';

class UserFields {
  static const String id = 'Order_';
  static const String date = 'Date';
  static const String firstName = 'ShippingFirstName';
  static const String lastName = 'ShippingLastName';
  static const String email = 'ShippingEmail';
  static const String phone = 'ShippingPhone';
  static const String ticketName = 'ProductName';
  static const String isStudent = 'ProductOptions';
  static const String ticketNum = 'ProductQuantity';
  static const String ticketCost = 'ProductPrice';
  static const String ticketSaleCost = 'ProductSalePrice';
  static const String totalTicketSaleCost = 'ProductTotalPrice';
  static const String coupon = 'Coupon';
  static const String giftCard = "Dunkin' Gift Card";

  static List<String> getFields() => [
        id,
        date,
        firstName,
        lastName,
        email,
        phone,
        ticketName,
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
  final String date;
  final String firstName;
  final String lastName;
  final String email;
  final String phone;
  final String ticketName;
  final bool isStudent;
  final int ticketNum;
  final int ticketCost;
  final int ticketSaleCost;
  final int totalTicketSaleCost;
  final String coupon;
  final bool giftCard;

  const User({
    required this.id,
    required this.date,
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.phone,
    required this.ticketName,
    required this.isStudent,
    required this.ticketNum,
    required this.ticketCost,
    required this.ticketSaleCost,
    required this.totalTicketSaleCost,
    required this.coupon,
    required this.giftCard,
  });

  User copy(
          {int? id,
          String? date,
          String? firstName,
          String? lastName,
          String? email,
          String? phone,
          String? ticketName,
          bool? isStudent,
          int? ticketNum,
          int? ticketCost,
          int? ticketSaleCost,
          int? totalTicketSaleCost,
          String? coupon,
          bool? isTrue}) =>
      User(
          id: id ?? this.id,
          date: date ?? this.date,
          firstName: firstName ?? this.firstName,
          lastName: lastName ?? this.lastName,
          email: email ?? this.email,
          phone: phone ?? this.phone,
          ticketName: ticketName ?? this.ticketName,
          isStudent: isStudent ?? this.isStudent,
          ticketNum: ticketNum ?? this.ticketNum,
          ticketCost: ticketCost ?? this.ticketCost,
          ticketSaleCost: ticketSaleCost ?? this.ticketSaleCost,
          totalTicketSaleCost: totalTicketSaleCost ?? this.totalTicketSaleCost,
          coupon: coupon ?? this.coupon,
          giftCard: isTrue ?? this.giftCard);

  static User fromJson(Map<String, dynamic> json) => User(
        id: jsonDecode(json[UserFields.id]),
        date: json[UserFields.date],
        firstName: json[UserFields.firstName],
        lastName: json[UserFields.lastName],
        email: json[UserFields.email],
        phone: json[UserFields.phone],
        ticketName: json[UserFields.ticketName],
        isStudent: (json[UserFields.isStudent] == "Type : CMU Student Pass (Limit 1 per order)"),
        ticketNum: jsonDecode(json[UserFields.ticketNum]),
        ticketCost: jsonDecode(json[UserFields.ticketCost]),
        ticketSaleCost: jsonDecode(json[UserFields.ticketSaleCost]),
        totalTicketSaleCost: jsonDecode(json[UserFields.totalTicketSaleCost]),
        coupon: json[UserFields.coupon],
        giftCard: (json[UserFields.giftCard] == "Y"),
      );

  Map<String, dynamic> toJson() => {
        UserFields.id: id,
        UserFields.date: date,
        UserFields.firstName: firstName,
        UserFields.lastName: lastName,
        UserFields.email: email,
        UserFields.phone: phone,
        UserFields.ticketName: ticketName,
        UserFields.isStudent: isStudent,
        UserFields.ticketNum: ticketNum,
        UserFields.ticketCost: ticketCost,
        UserFields.ticketSaleCost: ticketSaleCost,
        UserFields.totalTicketSaleCost: totalTicketSaleCost,
        UserFields.coupon: coupon,
        UserFields.giftCard: giftCard
      };
}
