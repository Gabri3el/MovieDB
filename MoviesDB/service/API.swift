//
//  API.swift
//  MoviesDB
//
//  Created by Gabriel on 30/08/21.
//

import UIKit

class API {
    
    var dataTask: URLSessionTask?
    
    func getMovieDetail(completion: @escaping (Result<MoviesData , Error>) -> Void){
        let movieDetails =
            "https://api.themoviedb.org/3/movie/550?api_key=eeb1311dddad05bb571f83b48af03e50&language=en-US"
        guard let url = URL(string: movieDetails) else{return}
        dataTask = URLSession.shared.dataTask(with: url){ (data,response,error) in
        
            if let error = error {
                completion(.failure(error))
                print("data not found \(error.localizedDescription)")
            }
            
        guard let response = response as? HTTPURLResponse else{
            
            print("Empty Response ")
            return
            
        }
            
        print("response Code: \(response.statusCode)")
    
        guard let data = data else{
            print("empty data")
            return
        }
        
            do{
                let jsonData = try JSONDecoder().decode(MoviesData.self, from: data)
                    DispatchQueue.main.async {
                    completion(.success(jsonData))
                }
            }catch  let error{
                completion(.failure(error))
            }
    }
    dataTask?.resume()
}
    
    
    
    
    func getPopularMoviesData(completion: @escaping (Result<MoviesData , Error>) -> Void){
        let popularMoviesURL =
            "https://api.themoviedb.org/3/movie/popular?api_key=eeb1311dddad05bb571f83b48af03e50&language=en-US&page=1"
        
            guard let url = URL(string: popularMoviesURL) else{return}
            dataTask = URLSession.shared.dataTask(with: url){ (data,response,error) in
            
                if let error = error {
                    completion(.failure(error))
                    print("data not found \(error.localizedDescription)")
                }
                
            guard let response = response as? HTTPURLResponse else{
                
                print("Empty Response ")
                return
                
            }
                
            print("response Code: \(response.statusCode)")
        
            guard let data = data else{
                print("empty data")
                return
            }
            
                do{
                    let jsonData = try JSONDecoder().decode(MoviesData.self, from: data)
                        DispatchQueue.main.async {
                        completion(.success(jsonData))
                    }
                }catch  let error{
                    completion(.failure(error))
                }
        }
        dataTask?.resume()
    }
}
    

    
    


    


