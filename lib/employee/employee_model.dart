class Employee {
  final int id;
  final String name;
  final String role;
  final String department;
  final String email;
  final String phone;
  final String avatar;
  final double salary;
  final String joinDate;
  final String status; // Active, On Leave, Remote
  final int performanceScore; // 0-100
  final int attendancePercent;
  final int leavesUsed;
  final int leavesTotal;

  const Employee({
    required this.id,
    required this.name,
    required this.role,
    required this.department,
    required this.email,
    required this.phone,
    required this.avatar,
    required this.salary,
    required this.joinDate,
    required this.status,
    required this.performanceScore,
    required this.attendancePercent,
    required this.leavesUsed,
    required this.leavesTotal,
  });
}

final List<Employee> employees = [
  Employee(id: 1, name: 'Alice Johnson', role: 'Senior Developer', department: 'Engineering', email: 'alice@company.com', phone: '+1 555-0101', avatar: 'https://images.unsplash.com/photo-1494790108377-be9c29b29330?w=100&h=100&fit=crop', salary: 95000, joinDate: 'Jan 2020', status: 'Active', performanceScore: 92, attendancePercent: 97, leavesUsed: 5, leavesTotal: 20),
  Employee(id: 2, name: 'Bob Martinez', role: 'Product Manager', department: 'Product', email: 'bob@company.com', phone: '+1 555-0102', avatar: 'https://images.unsplash.com/photo-1507003211169-0a1dd7228f2d?w=100&h=100&fit=crop', salary: 105000, joinDate: 'Mar 2019', status: 'Active', performanceScore: 88, attendancePercent: 95, leavesUsed: 8, leavesTotal: 20),
  Employee(id: 3, name: 'Carol White', role: 'UI/UX Designer', department: 'Design', email: 'carol@company.com', phone: '+1 555-0103', avatar: 'https://images.unsplash.com/photo-1438761681033-6461ffad8d80?w=100&h=100&fit=crop', salary: 82000, joinDate: 'Jun 2021', status: 'Remote', performanceScore: 95, attendancePercent: 99, leavesUsed: 3, leavesTotal: 20),
  Employee(id: 4, name: 'David Lee', role: 'DevOps Engineer', department: 'Engineering', email: 'david@company.com', phone: '+1 555-0104', avatar: 'https://images.unsplash.com/photo-1500648767791-00dcc994a43e?w=100&h=100&fit=crop', salary: 98000, joinDate: 'Sep 2018', status: 'Active', performanceScore: 85, attendancePercent: 93, leavesUsed: 10, leavesTotal: 20),
  Employee(id: 5, name: 'Emma Davis', role: 'HR Manager', department: 'Human Resources', email: 'emma@company.com', phone: '+1 555-0105', avatar: 'https://images.unsplash.com/photo-1544005313-94ddf0286df2?w=100&h=100&fit=crop', salary: 78000, joinDate: 'Feb 2020', status: 'Active', performanceScore: 90, attendancePercent: 96, leavesUsed: 6, leavesTotal: 20),
  Employee(id: 6, name: 'Frank Wilson', role: 'Data Analyst', department: 'Analytics', email: 'frank@company.com', phone: '+1 555-0106', avatar: 'https://images.unsplash.com/photo-1472099645785-5658abf4ff4e?w=100&h=100&fit=crop', salary: 87000, joinDate: 'Nov 2021', status: 'On Leave', performanceScore: 78, attendancePercent: 88, leavesUsed: 15, leavesTotal: 20),
  Employee(id: 7, name: 'Grace Kim', role: 'Marketing Lead', department: 'Marketing', email: 'grace@company.com', phone: '+1 555-0107', avatar: 'https://images.unsplash.com/photo-1487412720507-e7ab37603c6f?w=100&h=100&fit=crop', salary: 80000, joinDate: 'Apr 2022', status: 'Active', performanceScore: 87, attendancePercent: 94, leavesUsed: 4, leavesTotal: 20),
  Employee(id: 8, name: 'Henry Brown', role: 'Backend Developer', department: 'Engineering', email: 'henry@company.com', phone: '+1 555-0108', avatar: 'https://images.unsplash.com/photo-1519085360753-af0119f7cbe7?w=100&h=100&fit=crop', salary: 91000, joinDate: 'Jul 2020', status: 'Active', performanceScore: 83, attendancePercent: 91, leavesUsed: 7, leavesTotal: 20),
  Employee(id: 9, name: 'Isla Thompson', role: 'Finance Analyst', department: 'Finance', email: 'isla@company.com', phone: '+1 555-0109', avatar: 'https://images.unsplash.com/photo-1534528741775-53994a69daeb?w=100&h=100&fit=crop', salary: 84000, joinDate: 'Jan 2021', status: 'Remote', performanceScore: 91, attendancePercent: 98, leavesUsed: 2, leavesTotal: 20),
  Employee(id: 10, name: 'Jake Anderson', role: 'QA Engineer', department: 'Engineering', email: 'jake@company.com', phone: '+1 555-0110', avatar: 'https://images.unsplash.com/photo-1506794778202-cad84cf45f1d?w=100&h=100&fit=crop', salary: 76000, joinDate: 'Oct 2022', status: 'Active', performanceScore: 80, attendancePercent: 92, leavesUsed: 9, leavesTotal: 20),
];
