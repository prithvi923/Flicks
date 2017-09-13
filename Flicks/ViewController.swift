//
//  ViewController.swift
//  Flicks
//
//  Created by Prithvi Prabahar on 9/11/17.
//  Copyright © 2017 Prithvi Prabahar. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    var movies: [Movie] = []
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        tableView.dataSource = self
        tableView.delegate = self
        
        loadMovies()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return movies.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MovieCell")!
        cell.textLabel?.text = self.movies[indexPath.row].title
        return cell
    }
    
    func loadMovies() {
        let apiKey = "b138fd7bdb72c3c86f8ad32f0d1ce8e4"
        let nowPlaying = "https://api.themoviedb.org/3/movie/now_playing?api_key=\(apiKey)"
        
        let url = URL(string: nowPlaying)
        let urlRequest = URLRequest(url: url!)
        let session = URLSession(configuration: URLSessionConfiguration.default, delegate: nil, delegateQueue: OperationQueue.main)
        let task = session.dataTask(with: urlRequest) { maybeData, success, error in
            let data = try! JSONSerialization.jsonObject(with: maybeData!)
            if let responseData = data as? NSDictionary {
                let resultsDict = responseData["results"] as! [NSDictionary]
                self.movies = resultsDict.map { movie in
                    return Movie(from: movie)
                }
                self.tableView.reloadData()
            }
        }
        
        task.resume()
    }


}

