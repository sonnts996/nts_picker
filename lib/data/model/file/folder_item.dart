class FolderItem {
  const FolderItem({required this.path, required this.name});

  factory FolderItem.all(){
    return const FolderItem(path: '/', name: 'All');
  }

  final String name;
  final String path;
}
