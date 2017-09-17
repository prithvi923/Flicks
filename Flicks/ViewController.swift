//
//  ViewController.swift
//  Flicks
//
//  Created by Prithvi Prabahar on 9/11/17.
//  Copyright © 2017 Prithvi Prabahar. All rights reserved.
//

import UIKit
import AFNetworking
import CircularSpinner


class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, UISearchResultsUpdating {

    var movies: [Movie] = []
    var filteredMovies: [Movie] = []
    var refreshControl: UIRefreshControl!
    var searchController: UISearchController!
    let apiKey = "b138fd7bdb72c3c86f8ad32f0d1ce8e4"
    var path: String!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var networkErrorLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        tableView.dataSource = self
        tableView.delegate = self
        networkErrorLabel.text = "Unable to connect to network"
        
        refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(refreshControlAction(_:)), for: .valueChanged)
        tableView.insertSubview(refreshControl, at: 0)
        
        searchController = UISearchController(searchResultsController: nil)
        searchController.dimsBackgroundDuringPresentation = false
        searchController.searchResultsUpdater = self
        tableView.tableHeaderView = searchController.searchBar
        searchController.searchBar.sizeToFit()
        definesPresentationContext = true
        
        CircularSpinner.show("Loading...", animated: true, type: .indeterminate)
        loadMovies(#selector(hideCircularSpinner))
    }
    
    func filterContentForSearchText(searchText: String) {
        filteredMovies = movies.filter { movie in
            return movie.title.lowercased().contains(searchText.lowercased())
        }
        tableView.reloadData()
    }
    
    func refreshControlAction(_ refreshControl: UIRefreshControl) {
        loadMovies(#selector(hideRefreshControl))
    }
    
    func hideCircularSpinner() {
        CircularSpinner.hide()
    }
    
    func hideRefreshControl() {
        refreshControl.endRefreshing()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if searchController.isActive && searchController.searchBar.text! != "" {
            return filteredMovies.count
        }
        return movies.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MovieCell") as! MovieTableViewCell
        let movie: Movie
        
        if searchController.isActive && searchController.searchBar.text! != "" {
            movie = self.filteredMovies[indexPath.row]
        } else {
            movie = self.movies[indexPath.row]
        }
        let backdropURL = "https://image.tmdb.org/t/p/w342\(movie.backdropPath)"
        cell.titleLabel?.text = movie.title
        cell.movieBackdrop.setImageWith(URL(string: backdropURL)!)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 210
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destVC = segue.destination as! MovieDetailViewController
        let cell = sender as! MovieTableViewCell
        let path = tableView.indexPath(for: cell)
        if searchController.isActive && searchController.searchBar.text! != "" {
            destVC.movie = self.filteredMovies[(path?.row)!]
        } else {
            destVC.movie = self.movies[(path?.row)!]
        }
    }
    
    func loadMovies(_ callback: Selector) {
        let endpoint = "https://api.themoviedb.org/3/movie/\(path!)?api_key=\(apiKey)"
        let url = URL(string: endpoint)
        let urlRequest = URLRequest(url: url!)
        let session = URLSession(configuration: URLSessionConfiguration.default, delegate: nil, delegateQueue: OperationQueue.main)
        
        let task = session.dataTask(with: urlRequest) { maybeData, success, error in
            if (error != nil) {
                self.networkErrorLabel.isHidden = false
            } else {
                self.networkErrorLabel.isHidden = true
                let data = try! JSONSerialization.jsonObject(with: maybeData!)
                if let responseData = data as? NSDictionary {
                    let resultsDict = responseData["results"] as! [NSDictionary]
                    self.movies = resultsDict.map { movie in
                        return Movie(from: movie)
                    }
                    self.tableView.reloadData()
                }
            }
            self.perform(callback)
        }
        
        task.resume()
    }
    
    func updateSearchResults(for searchController: UISearchController) {
        filterContentForSearchText(searchText: searchController.searchBar.text!)
    }
}
