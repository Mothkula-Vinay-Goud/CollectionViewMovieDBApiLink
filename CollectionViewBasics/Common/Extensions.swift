//
//  Extensions.swift
//  CollectionViewBasics
//
//  Created by Vinay Goud Mothkula on 2/10/26.
//

import Foundation
import UIKit

extension UIImageView {
    func loadImage(url: String) async {
        
        /// check for valid server url
        guard let serverURL = URL(string: url) else {
            print("Log: Invalid URL")
            return self.image = UIImage(systemName: "photo")
        }
        
        /// Handling the exception
        do {
            /// fetching the data from the server
            let (data, response) = try await URLSession.shared.data(from: serverURL)
            
            /// checking for valid server status code : 200 - successful , any other - not sucessful
            if let serverResponse = response as? HTTPURLResponse, serverResponse.statusCode != 200 {
                print("Log: No data received from server")
                return self.image = UIImage(systemName: "photo")
            }
            
            /// data is of DATA , which is serialized Object , it contains data in machine readable format
            /// To get the swift post array , we need to convert data object to model
            DispatchQueue.main.async {
                self.image = UIImage(data: data)
            }
            
        } catch {
            print("Log: Error fetching data from server")
            self.image = UIImage(systemName: "photo")
        }
    }
}
