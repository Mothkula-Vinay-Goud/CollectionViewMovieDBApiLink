//
//  MockNetworkManager.swift
//  CollectionViewBasics
//
//  Created by Vinay Goud Mothkula on 2/17/26.
//

import Foundation
class MockNetworkManager: NetworkManagerProtocol {
    func getDataFromServer(url: String) async ->  [MovieModel] {
        
        guard let _ = URL(string: url) else {
            print("Log: Invalid URL")
            return []
        }
        var allMoviesData: [MovieModel] = []
        allMoviesData.append(MovieModel(overview: "A group of astronauts on a mission to find a new habitable planet discover a long-lost civilization.",popularity: 176.614,posterpath: "/haFDZfpKszHq7DXvuQd5Zz7shQW.jpg",release_date: "2019",title: "Ad Astra",    rating: 5.0, ))
        allMoviesData.append(MovieModel(overview: "The true story of Alexander Hamilton, from his early days as a sickly but brilliant boy in New York City to his historic role as the Founding Father of the United States.",popularity: 143.114,posterpath: "/eZo31Dhl5BQ6GfbMNf3oU0tUvPZ.jpg",release_date: "2020",title: "Hamilton",  rating: 4.8, ))
        
        return allMoviesData

    }
}
