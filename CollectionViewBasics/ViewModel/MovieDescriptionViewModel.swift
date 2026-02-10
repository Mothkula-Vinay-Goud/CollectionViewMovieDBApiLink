//
//  MovieDescriptionViewModel.swift
//  CollectionViewBasics
//
//  Created by Vinay Goud Mothkula on 2/3/26.
//

import Foundation
class MovieDescriptionViewModel{
    
    private var selectedMovie: MovieModel?
    
    init(selectedMovie: MovieModel) {
        self.selectedMovie = selectedMovie
    }
    
    func getTitle() -> String? {
        return selectedMovie?.title
    }
    func getScore() -> Double?{
        return selectedMovie?.popularity
    }
    func getYear() -> String?{
        return selectedMovie?.release_date
    }
    func getImage() -> String? {
        return selectedMovie?.poster_path
    }
    func getRating() -> Double?{
        return selectedMovie?.vote_average
    }
    func getDescription() -> String? {
        return selectedMovie?.overview
    }
   
}
