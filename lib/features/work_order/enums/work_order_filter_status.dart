enum WorkOrderFilterStatus {
  all('all'),
  assigned('assigned'),
  inProgress('in_progress'),
  completed('completed');

  const WorkOrderFilterStatus(this.value);

  final String value;
}
