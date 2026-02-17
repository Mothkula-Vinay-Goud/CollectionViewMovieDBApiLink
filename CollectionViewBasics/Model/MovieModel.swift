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
    var posterpath: String?
    var release_date: String?
    var title: String?
    var video: Bool?
    var rating: Double?
    var vote_count: Int?
    
    enum CodingKeys: String, CodingKey {
            case adult
            case backdrop_path
            case genre_ids
            case id
            case original_language
            case original_title
            case overview
            case popularity
            case posterpath = "poster_path"
            case release_date
            case title
            case video
            case rating = "vote_average"
            case vote_count
        }
}

