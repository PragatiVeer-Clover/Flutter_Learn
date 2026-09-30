import 'package:flutter/material.dart';
import 'recipe_data.dart';
import 'recipe_detail.dart';
import 'orders_page.dart';

class RecipesPage extends StatefulWidget {
  const RecipesPage({super.key});

  @override
  State<RecipesPage> createState() => _RecipesPageState();
}

class _RecipesPageState extends State<RecipesPage> {
  String _search = '';
  String _selectedCategory = 'All';

  List<String> get categories => [
        'All',
        ...recipes.map((r) => r.category).toSet().toList()
      ];

  List<Recipe> get filtered => recipes.where((r) {
        final matchSearch =
            r.title.toLowerCase().contains(_search.toLowerCase());
        final matchCategory =
            _selectedCategory == 'All' || r.category == _selectedCategory;
        return matchSearch && matchCategory;
      }).toList();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF121212),
      appBar: AppBar(
        backgroundColor: Color(0xFF1E1E1E),
        title: Row(
          children: [
            Icon(Icons.restaurant_menu, color: Colors.orangeAccent),
            SizedBox(width: 8),
            Text('Recipes', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
          ],
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.receipt_long, color: Colors.white),
            onPressed: () => Navigator.push(context,
                MaterialPageRoute(builder: (_) => OrdersPage())),
          ),
        ],
      ),
      body: Center(
        child: ConstrainedBox(
          constraints: BoxConstraints(maxWidth: 1100),
          child: Column(
            children: [
              // Search bar
              Padding(
                padding: EdgeInsets.all(16),
                child: TextField(
                  style: TextStyle(color: Colors.white),
                  onChanged: (v) => setState(() => _search = v),
                  decoration: InputDecoration(
                    hintText: 'Search recipes...',
                    hintStyle: TextStyle(color: Colors.grey),
                    prefixIcon: Icon(Icons.search, color: Colors.grey),
                    filled: true,
                    fillColor: Color(0xFF1E1E1E),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30),
                      borderSide: BorderSide.none,
                    ),
                  ),
                ),
              ),

              // Category chips
              SizedBox(
                height: 45,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  padding: EdgeInsets.symmetric(horizontal: 16),
                  itemCount: categories.length,
                  itemBuilder: (context, i) {
                    final cat = categories[i];
                    final selected = cat == _selectedCategory;
                    return Padding(
                      padding: EdgeInsets.only(right: 8),
                      child: ChoiceChip(
                        label: Text(cat),
                        selected: selected,
                        onSelected: (_) => setState(() => _selectedCategory = cat),
                        selectedColor: Colors.orangeAccent,
                        backgroundColor: Color(0xFF1E1E1E),
                        labelStyle: TextStyle(
                          color: selected ? Colors.black : Colors.white,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    );
                  },
                ),
              ),
              SizedBox(height: 16),

              // Recipe grid
              Expanded(
                child: filtered.isEmpty
                    ? Center(
                        child: Text('No recipes found',
                            style: TextStyle(color: Colors.grey)))
                    : GridView.builder(
                        padding: EdgeInsets.symmetric(horizontal: 16),
                        gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                          maxCrossAxisExtent: 320,
                          crossAxisSpacing: 16,
                          mainAxisSpacing: 16,
                          childAspectRatio: 0.78,
                        ),
                        itemCount: filtered.length,
                        itemBuilder: (context, i) =>
                            _RecipeCard(recipe: filtered[i]),
                      ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _RecipeCard extends StatelessWidget {
  final Recipe recipe;
  const _RecipeCard({required this.recipe});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Navigator.push(
        context,
        MaterialPageRoute(builder: (_) => RecipeDetailPage(recipe: recipe)),
      ),
      child: Container(
        decoration: BoxDecoration(
          color: Color(0xFF1E1E1E),
          borderRadius: BorderRadius.circular(16),
        ),
        clipBehavior: Clip.hardEdge,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Image
            Expanded(
              child: Image.network(
                recipe.image,
                width: double.infinity,
                fit: BoxFit.cover,
                loadingBuilder: (context, child, progress) {
                  if (progress == null) return child;
                  return Container(
                    color: Colors.grey[900],
                    child: Center(
                      child: CircularProgressIndicator(
                        color: Colors.orangeAccent,
                        strokeWidth: 2,
                      ),
                    ),
                  );
                },
                errorBuilder: (_, __, ___) => Container(
                  color: Colors.grey[800],
                  child: Icon(Icons.image, color: Colors.grey, size: 50),
                ),
              ),
            ),

            // Info
            Padding(
              padding: EdgeInsets.all(12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(recipe.title,
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.bold)),
                  SizedBox(height: 6),
                  Row(
                    children: [
                      Icon(Icons.timer, color: Colors.orangeAccent, size: 14),
                      SizedBox(width: 4),
                      Text('${recipe.time} min',
                          style: TextStyle(color: Colors.grey, fontSize: 12)),
                      SizedBox(width: 12),
                      Icon(Icons.people, color: Colors.orangeAccent, size: 14),
                      SizedBox(width: 4),
                      Text('${recipe.servings} servings',
                          style: TextStyle(color: Colors.grey, fontSize: 12)),
                    ],
                  ),
                  SizedBox(height: 8),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                    decoration: BoxDecoration(
                      color: Colors.orangeAccent.withOpacity(0.2),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Text(recipe.difficulty,
                        style: TextStyle(
                            color: Colors.orangeAccent, fontSize: 11)),
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
