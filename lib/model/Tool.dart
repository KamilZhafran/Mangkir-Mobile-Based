class Tool {
  final String toolName;

  const Tool({
    required this.toolName,
  });

  factory Tool.fromJson(Map<String, dynamic> json) {
    return Tool(
      toolName: json['nama_alat'],
    );
  }
}