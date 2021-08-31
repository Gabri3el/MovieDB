//
//  ViewController.swift
//  MoviesDB
//
//  Created by Gabriel on 30/08/21.
//

import UIKit

class MovieViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    private var viewModel = MovieViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
       
        loadPopularMovies()
        }
        
    private func loadPopularMovies(){
        viewModel.fetchPopularMovieData {[weak self] in
            self?.tableView.dataSource = self
            self?.tableView.reloadData()
        }
    }
    
}

extension MovieViewController: UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.numberOfRowsInSection(section: section)
    }
    
    //setando tableView
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! MovieTableViewCell
        
        let movie = viewModel.cellForRowAt(indexPath: indexPath)
        cell.setCellWithValuesOf(movie)
        
        return cell
    }
    
    
}




