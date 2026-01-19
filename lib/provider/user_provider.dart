import 'package:flutter_riverpod/legacy.dart';
import '../models/users.dart';


class UserProvider extends StateNotifier<User?> {
  // constructor initializing with default User object
  // purpose: Manage the state of the user object allowing updates
  UserProvider()
      : super(
    User(
      id: '',
      fullName: '',
      email: '',
      state: '',
      city: '',
      locality: '',
      password: '',
      token: '',
    ),
  );

  // Getter method to extract value from an object
  User? get user => state;

// method to set user state from JSON
// purpose: updates the user state based on JSON string representation of user object

  void setUser(String userJson) {
    state = User.fromJson(userJson);
  }

// make the data accessible within the application
  final userProvider =
  StateNotifierProvider<UserProvider, User?>(
        (ref) => UserProvider(),
  );
}
