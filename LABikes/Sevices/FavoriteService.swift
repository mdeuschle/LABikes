//
//  FavoriteService.swift
//  LABikes
//
//  Created by Matt Deuschle on 2/10/18.
//  Copyright © 2018 Matt Deuschle. All rights reserved.
//

import Foundation

struct FavoritesService {

    static let shared = FavoritesService()
    func updateFavorites(bike: Bike) {
        var favorites = Dao.shared.unarchiveFavorites()
        if bike.isFavorite {
            favorites.append(bike)
            Dao.shared.acrchiveFavorites(favoriteBikes: favorites)
        } else {
            if let index = bike.getFavoriteIndex(favorites: favorites) {
                favorites.remove(at: index)
                Dao.shared.acrchiveFavorites(favoriteBikes: favorites)
            }
        }
    }
}


