//
//  MovieDetailViewController.swift
//  Flicks
//
//  Created by Prithvi Prabahar on 9/14/17.
//  Copyright © 2017 Prithvi Prabahar. All rights reserved.
//

import UIKit

class MovieDetailViewController: UIViewController {

    @IBOutlet weak var posterImageView: UIImageView!
    var movie: Movie!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let posterURL = "https://image.tmdb.org/t/p/w342\(self.movie.posterPath)"
        self.posterImageView.setImageWith(URL(string: posterURL)!)
        self.navigationItem.title = self.movie.title
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
