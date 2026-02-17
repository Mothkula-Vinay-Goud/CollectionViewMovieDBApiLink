//
//  MovieListViewModel.swift
//  CollectionViewBasics
//
//  Created by Vinay Goud Mothkula on 2/3/26.
//

import Foundation

protocol MovieListViewModelProtocol{
    func getMoviesCount() -> Int
    func getMovie(_ row: Int) -> MovieModel
    func getDataFromServer() async
    func filteredCountries(searchText: String)
}
class MovieListViewModel: MovieListViewModelProtocol{
    
    private var allMoviesData: [MovieModel] = []
    private var filteredMoviesData: [MovieModel] = []
    private var service : NetworkManagerProtocol?
    
    init(service: NetworkManagerProtocol? = nil){
        self.service = service
    }
    func filteredCountries(searchText: String){
       if searchText.isEmpty{
            filteredMoviesData = allMoviesData
           return
        }
        filteredMoviesData.removeAll()
        let lowercasedSearchText = searchText.lowercased()
        for movie in allMoviesData{
            if movie.title?.lowercased().contains(lowercasedSearchText) == true ||
                String(movie.popularity ?? 0.00).lowercased().contains(lowercasedSearchText) == true ||
                movie.release_date?.lowercased().contains(lowercasedSearchText) == true || String(movie.rating ?? 0.00).lowercased().contains(lowercasedSearchText) == true{
                filteredMoviesData.append(movie)
            }
        }
    }
    
    func getDataFromServer() async{
        sleep(1)
        allMoviesData = await service?.getDataFromServer(url:Server.PostUrl.rawValue) ?? []
        filteredMoviesData = allMoviesData
    }
    
    func getMoviesCount() -> Int{
        return filteredMoviesData.count
    }
   func getMovie(_ row: Int) -> MovieModel{
        return filteredMoviesData[row]
    }
}
