

import 'package:profile_card/Card/models/card_models.dart';
import '../../Core/utils/database.dart';


class CardService {
  final DatabaseHelper _databaseHelper = DatabaseHelper.instance;


  //create
  Future<int> createTask(CardModels cardModels) async {
    final db = await _databaseHelper.database;
    print(cardModels.toMap());
    final id = await db.insert('card', cardModels.toMap());
    print(id);
    return id;
  }

  //read tasks and convert to objects
  Future<List<CardModels>> getCards() async {
    final db = await _databaseHelper.database;
    final List<Map<String, dynamic>> maps = await db.query('card'); //list of maps
    print(maps);
    return maps.map((map) => CardModels.fromMap(map)).toList();
  }

  Future<int> updateCard(CardModels cardModels) async {
    final db = await _databaseHelper.database;

    return await db.update(
      'card',
      cardModels.toMap(),
      where: 'id = ?',
      whereArgs: [cardModels.id],
    );
  }

  //delete
  Future<int> deleteCard(CardModels cardModels) async {
    final db = await _databaseHelper.database;
    final id = await db.delete('card', where: 'id = ?', whereArgs: [cardModels.id]);
    return id;
  }
}

