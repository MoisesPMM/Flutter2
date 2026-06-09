

import 'package:flutter/material.dart';
import '../components/inputComponent.dart';



class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String city = '';
  String? uf = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: ListView(
            children: [
              InputComponent(
                label: 'Cidade',
                hint: 'Cascavel PR',
                icon: Icons.location_city,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor, insira o nome da cidade';
                  }
                  return null;
                },
                onChanged: (value) {
                  setState(() {
                    city = value ?? '';
                  });
                },
              ),
              const SizedBox(height: 20),
              InputComponent(
                label: 'Estado',
                hint: 'PR',
                icon: Icons.location_history,
                keyboard: TextInputType.text,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor, insira o nome do estado';
                  }
                  return null;
                },
                onChanged: (value) {
                  setState(() {
                    uf = value;
                  });
                  
                },
              ),
            ],
          ),
        )
      )
    );
}
}