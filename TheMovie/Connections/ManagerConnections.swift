//
//  ManagerConnections.swift
//  TheMovie
//
//  Created by Nicolas Chavez on 30/05/21.
//

import Foundation
import RxSwift

enum APIError: Error {
    case errorConnection(String)
}

class ManagerConnection {
    
    func getMovies(type:String) -> Observable<[Movie]>{
        return Observable.create{ observer in
            let session = URLSession.shared
            var request = URLRequest(url:URL(string:Constants.URL.urlmain+Constants.Movie.urlListMovie+type+Constants.apiKey)!)
            request.httpMethod = "GET"
            request.addValue("application/json", forHTTPHeaderField:
                "Content-Type")
            session.dataTask(with: request) { (data, response, error) in
                guard let data = data, error == nil, let response = response as? HTTPURLResponse else { return }
                if response.statusCode == 200 {
                    do {
                        let decoder = JSONDecoder()
                        let movies = try decoder.decode(Movies.self, from: data)
                        observer.onNext(movies.listOfmovies)
                    } catch {
                        //MARK: observer onNext event
                      observer.onError(APIError.errorConnection("Server code: \(response.statusCode)"))
                    }
                }
                //MARK: observer onCompleted event
                observer.onCompleted()
            }.resume()
            //MARK: return our disposable
            return Disposables.create {
                session.finishTasksAndInvalidate()
            }
        }
    }
    
    func getSearch(search:String) -> Observable<[Movie]>{
        return Observable.create{ observer in
            let session = URLSession.shared
            let newSearch = search.lowercased().replacingOccurrences(of: " ", with: "%20", options: .literal, range: nil)
            var request = URLRequest(url:URL(string:Constants.URL.urlmain+Constants.Movie.urlSearch+Constants.apiKey+"&query=\(newSearch)")!)
            request.httpMethod = "GET"
            request.addValue("application/json", forHTTPHeaderField:
                "Content-Type")
            session.dataTask(with: request) { (data, response, error) in
                guard let data = data, error == nil, let response = response as? HTTPURLResponse else { return }
                if response.statusCode == 200 {
                    do {
                        let decoder = JSONDecoder()
                        let movies = try decoder.decode(Movies.self, from: data)
                        observer.onNext(movies.listOfmovies)
                    } catch {
                        //MARK: observer onNext event
                      observer.onError(APIError.errorConnection("Server code: \(response.statusCode)"))
                    }
                }
                //MARK: observer onCompleted event
                observer.onCompleted()
            }.resume()
            //MARK: return our disposable
            return Disposables.create {
                session.finishTasksAndInvalidate()
            }
        }
    }
    
    func getGenres() -> Observable<[Genre]>{
        return Observable.create{ observer in
            let session = URLSession.shared
            print(Constants.URL.urlmain+Constants.Movie.urlGenre+Constants.apiKey)
            var request = URLRequest(url:URL(string:Constants.URL.urlmain+Constants.Movie.urlGenre+Constants.apiKey)!)
            request.httpMethod = "GET"
            request.addValue("application/json", forHTTPHeaderField:
                "Content-Type")
            session.dataTask(with: request) { (data, response, error) in
                guard let data = data, error == nil, let response = response as? HTTPURLResponse else { return }
                if response.statusCode == 200 {
                    do {
                        let decoder = JSONDecoder()
                        let listgenres = try decoder.decode(ListGenres.self, from: data)
                        observer.onNext(listgenres.genres)
                    } catch {
                        //MARK: observer onNext event
                      observer.onError(APIError.errorConnection("Server code: \(response.statusCode)"))
                    }
                }
                //MARK: observer onCompleted event
                observer.onCompleted()
            }.resume()
            //MARK: return our disposable
            return Disposables.create {
                session.finishTasksAndInvalidate()
            }
        }
    }
    
    
    func getLanguage() -> Observable<[Language]>{
        return Observable.create{ observer in
            let session = URLSession.shared
            print(Constants.URL.urlmain+Constants.Movie.urlLanguage+Constants.apiKey)
            var request = URLRequest(url:URL(string:Constants.URL.urlmain+Constants.Movie.urlLanguage+Constants.apiKey)!)
            request.httpMethod = "GET"
            request.addValue("application/json", forHTTPHeaderField:
                "Content-Type")
            session.dataTask(with: request) { (data, response, error) in
                guard let data = data, error == nil, let response = response as? HTTPURLResponse else { return }
                if response.statusCode == 200 {
                    do {
                        let decoder = JSONDecoder()
                        let languages = try decoder.decode([Language].self, from: data)
                        observer.onNext(languages)
                    } catch {
                        //MARK: observer onNext event
                      observer.onError(APIError.errorConnection("Server code: \(response.statusCode)"))
                    }
                }
                //MARK: observer onCompleted event
                observer.onCompleted()
            }.resume()
            //MARK: return our disposable
            return Disposables.create {
                session.finishTasksAndInvalidate()
            }
        }
    }
    
    func getDiscover(language:String,voteAverageMin:Int,voteAverageMax:Int,includeAdult:Bool) -> Observable<[Movie]>{
        return Observable.create{ observer in
            let session = URLSession.shared
            var request = URLRequest(url:URL(string:Constants.URL.urlmain+Constants.Movie.urlDiscover+Constants.apiKey+"&language="+language+"&vote_average.gte="+"\(voteAverageMin)"+"&vote_average.lte="+"\(voteAverageMax)"+"&include_adult="+"\(includeAdult)")!)
            print(Constants.URL.urlmain+Constants.Movie.urlDiscover+Constants.apiKey+"&language="+language+"&vote_average.gte="+"\(voteAverageMin)"+"&vote_average.lte="+"\(voteAverageMax)"+"&include_adult="+"\(includeAdult)")
            request.httpMethod = "GET"
            request.addValue("application/json", forHTTPHeaderField:
                "Content-Type")
            session.dataTask(with: request) { (data, response, error) in
                guard let data = data, error == nil, let response = response as? HTTPURLResponse else { return }
                if response.statusCode == 200 {
                    do {
                        let decoder = JSONDecoder()
                        let movies = try decoder.decode(Movies.self, from: data)
                        observer.onNext(movies.listOfmovies)
                    } catch {
                        //MARK: observer onNext event
                      observer.onError(APIError.errorConnection("Server code: \(response.statusCode)"))
                    }
                }
                //MARK: observer onCompleted event
                observer.onCompleted()
            }.resume()
            //MARK: return our disposable
            return Disposables.create {
                session.finishTasksAndInvalidate()
            }
        }
    }
}
