import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // Widget racine de l'application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Menu du Restaurant',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MenuRestaurantPage(),
    );
  }
}

// Modèle pour représenter un plat.
class Dish {
  final String name;
  final String category;
  final String imageUrl;
  final double price;
  final String description;

  Dish({
    required this.name,
    required this.category,
    required this.imageUrl,
    required this.price,
    required this.description,
  });
}

class MenuRestaurantPage extends StatefulWidget {
  @override
  _MenuRestaurantPageState createState() => _MenuRestaurantPageState();
}

class _MenuRestaurantPageState extends State<MenuRestaurantPage> {
  // Liste des catégories proposées.
  final List<String> categories = ['Entrées', 'Plats', 'Desserts'];

  // Données codées en dur pour les plats.
  final List<Dish> dishes = [
    Dish(
      name: 'Salade César',
      category: 'Entrées',
      imageUrl: 'assets/images/salade_cesar.jpeg',
      price: 8.50,
      description: 'Salade fraîche avec poulet grillé et sauce César.',
    ),
    Dish(
      name: 'Soupe à l\'oignon',
      category: 'Entrées',
      imageUrl: 'assets/images/soupe.jpg',
      price: 7.00,
      description: 'Traditionnelle soupe gratinée à l\'oignon.',
    ),
    Dish(
      name: 'Steak Frites',
      category: 'Plats',
      imageUrl: 'assets/images/steak.jpg',
      price: 15.00,
      description: 'Steak juteux accompagné de frites croustillantes.',
    ),
    Dish(
      name: 'Poulet rôti',
      category: 'Plats',
      imageUrl: 'assets/images/poulet.jpg',
      price: 13.50,
      description: 'Poulet rôti avec herbes de Provence.',
    ),
    Dish(
      name: 'Crème brûlée',
      category: 'Desserts',
      imageUrl: 'assets/images/creme.jpg',
      price: 6.50,
      description: 'Dessert classique avec une croûte caramélisée.',
    ),
    Dish(
      name: 'Tarte aux pommes',
      category: 'Desserts',
      imageUrl: 'assets/images/tarte.jpg',
      price: 5.50,
      description: 'Tarte aux pommes maison avec une pointe de cannelle.',
    ),
  ];

  // Catégorie actuellement sélectionnée.
  String selectedCategory = 'Entrées';

  @override
  Widget build(BuildContext context) {
    // Filtrer les plats selon la catégorie sélectionnée.
    List<Dish> filteredDishes =
    dishes.where((dish) => dish.category == selectedCategory).toList();

    return Scaffold(
      appBar: AppBar(
        title: Text('Menu du Restaurant'),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Barre de catégories défilable horizontalement.
          Container(
            height: 60,
            padding: EdgeInsets.symmetric(vertical: 8),
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: categories.length,
              itemBuilder: (context, index) {
                String category = categories[index];
                bool isSelected = category == selectedCategory;
                return GestureDetector(
                  onTap: () {
                    setState(() {
                      selectedCategory = category;
                    });
                  },
                  child: Container(
                    alignment: Alignment.center,
                    margin: EdgeInsets.symmetric(horizontal: 8),
                    padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    decoration: BoxDecoration(
                      color: isSelected ? Colors.blue : Colors.grey[300],
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Text(
                      category,
                      style: TextStyle(
                        color: isSelected ? Colors.white : Colors.black,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
          // Liste verticale des plats correspondant à la catégorie sélectionnée.
          Expanded(
            child: ListView.builder(
              itemCount: filteredDishes.length,
              itemBuilder: (context, index) {
                Dish dish = filteredDishes[index];
                return DishCard(dish: dish);
              },
            ),
          ),
        ],
      ),
    );
  }
}

// Widget réutilisable pour afficher un plat dans une carte.
class DishCard extends StatelessWidget {
  final Dish dish;

  const DishCard({Key? key, required this.dish}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.all(8),
      elevation: 3,
      child: Padding(
        padding: EdgeInsets.all(12),
        child: Row(
          children: [
            // Affichage de l'image illustrant le plat.
            Container(
              width: 80,
              height: 80,
              child: Image.asset(
                dish.imageUrl,
                fit: BoxFit.cover,
              ),
            ),
            SizedBox(width: 16),
            // Détails du plat : nom, description et prix.
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    dish.name,
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 4),
                  Text(
                    dish.description,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  SizedBox(height: 8),
                  Text(
                    '${dish.price.toStringAsFixed(2)} €',
                    style: TextStyle(fontSize: 16, color: Colors.green),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
