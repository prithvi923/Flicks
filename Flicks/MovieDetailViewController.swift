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
    @IBOutlet weak var overviewView: UIScrollView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let posterURL = "https://image.tmdb.org/t/p/w342\(self.movie.posterPath)"
        self.posterImageView.setImageWith(URL(string: posterURL)!)
        self.navigationItem.title = self.movie.title
        
        let width = self.view.frame.width * 4/5
        let offset = (self.view.frame.width - width)/2
        let label = UILabel(frame: CGRect(x: offset, y: offset, width: width, height: CGFloat.greatestFiniteMagnitude))
        label.numberOfLines = 0
        label.lineBreakMode = NSLineBreakMode.byWordWrapping
        label.text = self.movie.overview
        label.textColor = .white
        label.sizeToFit()
        
        let contentWidth = overviewView.bounds.width
        let contentHeight = overviewView.bounds.height < label.frame.height ? label.frame.height : overviewView.bounds.height
        overviewView.contentSize = CGSize(width: contentWidth, height: contentHeight)
        overviewView.addSubview(label)
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
