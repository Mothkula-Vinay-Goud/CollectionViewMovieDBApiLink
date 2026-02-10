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
}
class MovieListViewModel: MovieListViewModelProtocol{
    
    private var allMoviesData: [MovieModel] = []
    private var service : NetworkManagerProtocol?
    
    init(service: NetworkManagerProtocol){
        self.service = service
    }
    
    func getDataFromServer() async{
        allMoviesData = await service?.getDataFromServer(url:Server.PostUrl.rawValue) ?? []
    }
    
    func getMoviesCount() -> Int{
        return allMoviesData.count
    }
   func getMovie(_ row: Int) -> MovieModel{
        return allMoviesData[row]
    }
}
