enum StatusType {
  Todo,
  InProgress,
  Pending,
  Done,
  Rejected,
}

String getStatusValue(StatusType status) {
  switch (status) {
    case StatusType.Todo:
      return 'Todo';
    case StatusType.InProgress:
      return 'In Progress';
    case StatusType.Pending:
      return 'Pending';
    case StatusType.Done:
      return 'Done';
    case StatusType.Rejected:
      return 'Rejected';
      
    default:
      return 'Todo';
  }
}
