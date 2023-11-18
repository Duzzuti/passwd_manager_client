class User{
  final String name;

  const User({required this.name});

  @override
  String toString(){
    return name;
  }
}

class UserLogin{
  final User user;
  final String password;

  const UserLogin({required this.user, required this.password});
}