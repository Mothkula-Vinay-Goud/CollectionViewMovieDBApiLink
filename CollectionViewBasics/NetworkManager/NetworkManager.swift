//
//  NetworkManager.swift
//  CollectionViewBasics
//
//  Created by Vinay Goud Mothkula on 2/9/26.
//
import Foundation

protocol NetworkManagerProtocol {
    func getDataFromServer(url: String) async -> [MovieModel]
}

class NetworkManager: NetworkManagerProtocol {
    func getDataFromServer(url: String) async ->  [MovieModel] {
        
        guard let serverURL = URL(string: url) else {
            print("Log: Invalid URL")
            return []
        }
        
        /// Handling the exception
        do {
            /// fetching the data from the server
            let (data, response) = try await URLSession.shared.data(from: serverURL)
            
            /// checking for valid server status code : 200 - successful , any other - not sucessful
            if let serverResponse = response as? HTTPURLResponse, serverResponse.statusCode != 200 {
                print("Log: No data received from server")
                return []
            }
            
            /// data is of DATA , which is serialized Object , it contains data in machine readable format
            /// To get the swift post array , we need to convert data object to model
            let postList = try? JSONDecoder().decode(MovieResponse.self, from: data)
            return postList?.results ?? []
            
        } catch {
            print("Log: Error fetching data from server")
            return []
        }
                
        
    }
}




//var allMoviesData: [MovieModel] = []
//allMoviesData.append(MovieModel(title: "Ad Astra", score: 176.614, year: 2019, imageView: "adastra", rating: "5.0", description: """
//In a near-future solar system, astronaut Roy McBride embarks on a perilous mission across the galaxy to uncover the truth about his missing father, Clifford McBride, whose secretive experiment threatens the stability of the entire universe. As Roy travels from Earth to the Moon, Mars, and the outer edges of the solar system, he confronts the vast isolation of space, the fragility of human connection, and the existential weight of human ambition. Along the way, he encounters rogue space missions, encounters that challenge his mental and physical limits, and the haunting specter of his father’s obsession with pushing beyond the boundaries of human knowledge. "Ad Astra" is a deeply introspective journey that explores the nature of fatherhood, the search for meaning in the face of cosmic indifference, and the psychological toll of isolation. The film combines breathtaking visual effects of space with a slow-burning narrative that delves into the human psyche, portraying the loneliness, determination, and resilience of a man confronting both the unknown of the universe and the unknown within himself. With an atmospheric score and thought-provoking storytelling, it is a meditation on what it means to traverse the infinite void, both literally and metaphorically, in pursuit of truth, reconciliation, and the ultimate understanding of humanity’s place among the stars.
//"""))
//allMoviesData.append(MovieModel(title: "Hamilton", score: 143.114, year: 2020, imageView: "hamilton",rating: "4.8", description: "The true story of Alexander Hamilton, from his early days as a sickly but brilliant boy in New York City to his historic role as the Founding Father of the United States." ))
//allMoviesData.append(MovieModel(title: "Zathura", score: 143.114, year: 2020, imageView: "zathura", rating: "4.7", description: "A young girl discovers a hidden world of magic and adventure, where she is drawn into a battle for the fate of her people."))
//allMoviesData.append(MovieModel(title: "Eurovision", score: 143.114, year: 2020, imageView: "eurovision", rating: "4.5", description: "A group of teenagers embark on a road trip to the legendary Eurovision Song Contest, where they must compete in a singing competition against some of the world's greatest artists."))
//                     allMoviesData.append(MovieModel(title: "Eurovision", score: 143.114, year: 2020, imageView: "eurovision", rating: "4.5", description: "A group of teenagers embark on a road trip to the legendary Eurovision Song Contest, where they must compete in a singing competition against some of the world's greatest artists."))
//allMoviesData.append(MovieModel(title: "Eurovision", score: 143.114, year: 2020, imageView: "eurovision", rating: "4.5", description: "A group of teenagers embark on a road trip to the legendary Eurovision Song Contest, where they must compete in a singing competition against some of the world's greatest artists."))
//allMoviesData.append(MovieModel(title: "Eurovision", score: 143.114, year: 2020, imageView: "eurovision", rating: "4.5", description: "A group of teenagers embark on a road trip to the legendary Eurovision Song Contest, where they must compete in a singing competition against some of the world's greatest artists."))
//return allMoviesData
