//
//  MovieTableViewCell.swift
//  MoviesDB
//
//  Created by Gabriel on 31/08/21.
//

import UIKit

class MovieTableViewCell: UITableViewCell {

  
    @IBOutlet weak var MoviePoster: UIImageView!
    
    @IBOutlet weak var MovieTitle: UILabel!
    @IBOutlet weak var MovieYear: UILabel!
    @IBOutlet weak var MovieOverview: UILabel!
    @IBOutlet weak var MovieRate: UILabel!
    
    
    private var urlString: String = ""
    
    //setando valores
    func setCellWithValuesOf(_ movie:Movie){
        updateUI(title: movie.title, release_date: movie.year,rating: movie.rate, overview: movie.overview, poster: movie.posterImage)
    }
    
    
    private func updateUI(title: String?,release_date: String?, rating: Double? , overview: String?, poster: String?){
        self.MovieTitle.text = title
        self.MovieYear.text = convertDateFormater(release_date)
        guard let rate = rating else {return}
        self.MovieRate.text = String(rate)
        self.MovieOverview.text = overview

        
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
        
        //converter data
        func convertDateFormater(_ date: String?) -> String {
                var fixDate = ""
                let dateFormatter = DateFormatter()
                dateFormatter.dateFormat = "yyyy-MM-dd"
                if let originalDate = date {
                    if let newDate = dateFormatter.date(from: originalDate) {
                        dateFormatter.dateFormat = "dd.MM.yyyy"
                        fixDate = dateFormatter.string(from: newDate)
                    }
                }
                return fixDate
            }
    }
}
