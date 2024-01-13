import 'package:memory_game/injection_container.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

void registerFirebaseAuth() {
  sl.registerLazySingleton<FirebaseAuth>(() => FirebaseAuth.instance);
}

void registerFirestore() {
  sl.registerLazySingleton<FirebaseFirestore>(() => FirebaseFirestore.instance);
}
