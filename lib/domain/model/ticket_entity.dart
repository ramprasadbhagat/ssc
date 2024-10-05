class TicketEntity {
  final String title;
  final String description;
  final String status;

  final String requestMessage;

  final String customerName;
  final String customerEmail;
  final String customerAddress;
  final String customerMobileNumber;

  TicketEntity(
      {required this.title,
      required this.description,
      required this.status,
      required this.requestMessage,
      required this.customerName,
      required this.customerAddress,
      required this.customerEmail,
      required this.customerMobileNumber});
}
