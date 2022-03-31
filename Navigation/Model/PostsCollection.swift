//
//  PostsCollection.swift
//  Navigation
//
//  Created by Алексей Моторин on 26.03.2022.
//

import Foundation

struct PostCollection {
    let posts = [
        Post(author: "Motorin A.", description: "Мат в один ход, ход белых...", image: "OneMoveWhite", likes: 0, views: 0),
        Post(author: "Motorin A.", description: "Мат в два хода, ход белых", image: "twoMovesWhite", likes: 0, views: 0),
        Post(author: "Motorin A.", description: "Снова задача на мат в два хода, ход белых...", image: "twoMoves2White", likes: 0, views: 0),
        Post(author: "Motorin A.", description: "Простенькая задача на мат в три хода, ход белых... еще мне надо кое что проверить, а именно: если будет много текста то label будет увеличиваться, а не появится вдруг что-то типа ... надеюсь все работает", image: "twoMovesWhite", likes: 0, views: 0)
    ]
}

