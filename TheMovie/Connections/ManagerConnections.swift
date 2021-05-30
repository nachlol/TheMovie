//
//  ManagerConnections.swift
//  TheMovie
//
//  Created by Nicolas Chavez on 30/05/21.
//

import Foundation

class ManagerConnection {
    
    func getPopularMovies() -> [Movie]{
        let session = URLSession.shared
        var request = URLRequest(url:URL(string:Constants.URL.urlListMovie+Constants.apiKey)!)
        request.httpMethod = "GET"
        request.addValue("application/json", forHTTPHeaderField:
            "Content-Type")
        session.dataTask(with: request) { (data, response, error) in
            guard let data = data, error == nil, let response = response as? HTTPURLResponse else { return }
            if response.statusCode == 200 {
                do {
                    let decoder = JSONDecoder()
                    let movies = try decoder.decode(Movies.self, from: data)
                    print(movies.listOfmovies)
                  //  observer.onNext(movies.listOfmovies)
                    return movies.listOfmovies
                } catch {
                    //MARK: observer onNext event
                  //  observer.onError(APIError.errorConnection("Server code: \(response.statusCode)"))
                }
            }
            //MARK: observer onCompleted event
           // observer.onCompleted()
        }.resume()
        //MARK: return our disposable
//        return Disposables.create {
//            session.finishTasksAndInvalidate()
//        }
    }
}
