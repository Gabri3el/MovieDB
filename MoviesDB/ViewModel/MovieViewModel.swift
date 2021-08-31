//
//  MovieViewModel.swift
//  MoviesDB
//
//  Created by Gabriel on 31/08/21.
//

import UIKit

class MovieViewModel{
    private var ApiService = API()
    private var popularMovie = [Movie]()
    
    func fetchPopularMovieData(completion: @escaping () ->()){
        ApiService.getPopularMoviesData { [weak self ](result) in
            switch result{
            case.success(let listOf):
                self?.popularMovie = listOf.movies
                completion()
            case .failure(let error):
                print("error data \(error)")
            
            }
        }
    }
    
    func fetchMovieDetails(completion: @escaping () ->()){
        ApiService.getPopularMoviesData { [weak self ](result) in
            switch result{
            case.success(let listOf):
                self?.popularMovie = listOf.movies
                completion()
            case .failure(let error):
                print("error data \(error)")
            
            }
        }
    }
    
    
    func numberOfRowsInSection(section:Int) -> Int {
            if (popularMovie.count != 0) {
                return popularMovie.count
            }
            return 0
        }
        
        func cellForRowAt(indexPath: IndexPath) -> Movie{
            return popularMovie[indexPath.row]
        }
    
}
