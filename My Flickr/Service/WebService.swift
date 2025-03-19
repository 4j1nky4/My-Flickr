//
//  WebService.swift
//  My Flickr
//
//  Created by Ajinkya Jagtap on 19/03/25.
//
// Photos provided by Pexels.com and Photos belongs to respected owners.



import Foundation

class WebService {
    
    // API Key for Authentication
    private let apiKey = "7HjopD897z4hzQT58K19Z0oGBReYsNnboWCY07lDa2mcZvOtzPi6PkNu"
    private let apiUrl = "https://api.pexels.com/v1/search?query=sunrise&per_page=40"

    func fetchImages(completion: @escaping ([ImageData]?) -> Void) {
        
        guard let url = URL(string: apiUrl) else { return }
        
        var request = URLRequest(url: url)
        request.setValue(apiKey, forHTTPHeaderField: "Authorization")  // Assigning Header to the requet

        // Access the image data from the url request
        URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data = data, error == nil else {
                completion(nil)
                return
            }
            do {
                let result = try JSONDecoder().decode(ImageResponse.self, from: data)
                DispatchQueue.main.async {
                    completion(result.photos)
                }
            } catch {
                print("Error decoding JSON: \(error)")
                completion(nil)
            }
        }.resume()
    }
    
    
}
