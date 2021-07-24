class Post {
  final String? post;
  final String? uploadUrl;
  final String? imageName;

  Post({this.uploadUrl, this.imageName, this.post});

  factory Post.fromJson(Map<String, dynamic> json) => Post(
      post: json['post'],
      imageName: json['imageName'],
      uploadUrl: json['uploadUrl']);

  Map<String, dynamic> toJson() {
    return {'post': post, 'imageName': imageName, 'uploadUrl': uploadUrl};
  }
}
