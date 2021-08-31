//
//  DetailsMovieController.swift
//  MoviesDB
//
//  Created by Gabriel on 31/08/21.
//

import UIKit


class DetailsMovieController: UIViewController {
    
    @IBOutlet weak var MoviePoster: UIImageView!
    
    @IBOutlet weak var MovieTitle: UILabel!
    @IBOutlet weak var MovieLike: UILabel!
    @IBOutlet weak var MovieWatch: UILabel!
    
    private var viewModel = MovieViewModel()
    private var urlString: String = ""
    
    override func viewDidLoad() {
        func setValue(_ movie:Movie)  {
            updateUI(title: movie.title, vote_count: movie.vote_count, popularity: movie.popularity, poster: movie.posterImage)
            
        }
    }
    
    

    
    private func updateUI(title: String?,vote_count: Int?, popularity: Double? ,poster: String?){
        self.MovieTitle.text = title
        guard let popularity = popularity else {return}
        self.MovieWatch.text = String(popularity)
        guard let vote_count = vote_count else {return}
        self.MovieLike.text = String(vote_count)

        
        guard let posterString = poster else{return}
        urlString = "https://image.tmdb.org/t/p/w300" + posterString
        
        guard let posterImage = URL(string: urlString) else {
            self.MoviePoster.image = UIImage(named: "no-image-icon-15")
            return
        }
        //limpar imagem antes de download
        self.MoviePoster.image = nil
        getImageDataFrom(url: posterImage)
        
        //download/
         func getImageDataFrom(url: URL){
            URLSession.shared.dataTask(with: url){ (data,response,error) in
                if let error = error {
                    print("dataTask error: \(error.localizedDescription)")
                    return
                }
                guard let data = data else {
                    print("empty data")
                    return
                }
                DispatchQueue.main.async {
                    if let image = UIImage(data: data){
                        self.MoviePoster.image = image
                    }
                }
            }.resume()
         }
        
    }
}


