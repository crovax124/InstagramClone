class User {
  final String email;
  final String uid;
  final String photoUrl;
  final String userName;
  final String bio;
  final List followers;
  final List following;

  const User(
      {required this.email,
      required this.uid,
      required this.photoUrl,
      required this.userName,
      required this.bio,
      required this.followers,
      required this.following});

  Map<String, dynamic> toJson() => {
        'username': userName,
        'uid': uid,
        'email': email,
        'photoUrl': photoUrl,
        'bio': bio,
        'followers': followers,
        'following': following,
      };
}
