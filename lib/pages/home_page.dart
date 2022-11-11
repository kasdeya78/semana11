import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  CollectionReference tasksReference =
      FirebaseFirestore.instance.collection("tasks");

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Firebase App"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () {
                tasksReference.get().then(
                  (value) {
                    QuerySnapshot collection = value;

                    // List<QueryDocumentSnapshot> docs = collection.docs;
                    // QueryDocumentSnapshot doc = docs[1];
                    // print(doc.id);
                    // print(doc.data());

                    collection.docs.forEach(
                      (QueryDocumentSnapshot element) {
                        Map<String, dynamic> myMap =
                            element.data() as Map<String, dynamic>;
                        print(myMap["title"]);
                      },
                    );
                  },
                );
              },
              child: Text("Obtener la data"),
            ),
            ElevatedButton(
              onPressed: () {
                tasksReference.add(
                  {
                    "title": "Ir al super 3",
                    "description": "Debemos comprar comida para le mes",
                  },
                ).then(
                  (DocumentReference value) {
                    print(value.id);
                  },
                ).catchError((error) {
                  print("Ocurrio un error en el registro");
                }).whenComplete(() {
                  print("El registro ha terminado");
                });
              },
              child: Text("Agregar documento"),
            ),
            ElevatedButton(
              onPressed: () {
                tasksReference.doc("hqyRTgAVS5zf3DiHCxDa").update(
                  {
                    "title": "Ir de paseo",
                    "description": "Limpiar el auto y salir a pasear",
                  },
                ).catchError(
                  (error) {
                    print(error);
                  },
                ).whenComplete(
                  () {
                    print("Actualizacion terminada");
                  },
                );
              },
              child: Text("Actualizar documento"),
            ),
          ],
        ),
      ),
    );
  }
}
