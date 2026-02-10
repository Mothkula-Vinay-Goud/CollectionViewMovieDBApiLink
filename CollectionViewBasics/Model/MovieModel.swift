//
//  MovieModel.swift
//  CollectionViewBasics
//
//  Created by Vinay Goud Mothkula on 2/3/26.
//

import Foundation


struct MovieResponse: Decodable {
    var page: Int?
    var results: [MovieModel]?
    var total_pages: Int?
    var total_results: Int?
}

struct MovieModel: Decodable {
    var adult: Bool?
    var backdrop_path: String?
    var genre_ids: [Int]?
    var id: Int?
    var original_language: String?
    var original_title: String?
    var overview: String?
    var popularity: Double?
    var poster_path: String?
    var release_date: String?
    var title: String?
    var video: Bool?
    var vote_average: Double?
    var vote_count: Int?
}

