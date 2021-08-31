//
//  Network.swift
//  tt
//
//  Created by Diana Princess on 25.08.2021.
//

import UIKit
class Network: Web {
    
    func getData(from helper3: URL, completion: @escaping (Data?, URLResponse?, Error?) -> ()) {
        URLSession.shared.dataTask(with: helper3, completionHandler: completion).resume()
    }
    
    var screen: NewViewController!
    
    var helper3: URL!
    
    struct Joke: Codable {
        var categories: Array<String>
        var created_at: String
        var icon_url: String
        var id: String
        var updated_at: String
        var url: String
        var value: String
    }
    
    func retrieveRandomJokes() {
        var request = URLRequest(url: URL(string: "https://api.chucknorris.io/jokes/random")!)
        request.httpMethod = "GET"
        request.allHTTPHeaderFields = ["AuthToken": "null"]
        let task = URLSession.shared.dataTask(with: request) {data, response, error in
            print(String(decoding: data!, as: UTF8.self))
            let joke: Joke = try! JSONDecoder().decode(Joke.self, from: data!)
            print("Begin of code")
            self.helper3 = URL(string: joke.icon_url)
            print("End of code. The image will continue downloading in the background and it will be loaded when it ends.")
            DispatchQueue.main.async { [weak self] in
                self?.screen.jokeLabel.text = joke.value
                self?.screen.activityView.stopAnimating()
             }
        }
        task.resume()
    }
    
    
    func downloadImage() {
        print("Download Started")
        getData(from: helper3) { [self] data, response, error in
            guard let data = data, error == nil else { return }
            print(response?.suggestedFilename ?? helper3.lastPathComponent)
            print("Download Finished")
            // always update the UI from the main thread
            DispatchQueue.main.async() { [weak self] in
                self?.screen.imageView.image = UIImage(data: data)
    }
    




}
}
    }
