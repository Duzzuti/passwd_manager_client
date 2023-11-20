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

class AddUserStruct{
  final String username;
  final String password1;
  final String password2;

  const AddUserStruct({required this.username, required this.password1, required this.password2});
}