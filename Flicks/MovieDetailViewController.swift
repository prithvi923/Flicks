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
    @IBOutlet weak var overviewLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let posterURL = "https://image.tmdb.org/t/p/w342\(self.movie.posterPath)"
        let imageRequest = URLRequest(url: URL(string: posterURL)!)
        self.posterImageView.setImageWith(
            imageRequest,
            placeholderImage: nil,
            success: { (imageRequest, imageResponse, image) in
                if imageResponse != nil {
                    self.posterImageView.alpha = 0.0
                    self.posterImageView.image = image
                    UIView.animate(withDuration: 0.3, animations: { () -> Void in
                        self.posterImageView.alpha = 1.0
                    })
                } else {
                    self.posterImageView.image = image
                }
        }, failure: { (imageRequest, imageResponse, error) in
            
        })

        
        
        self.navigationItem.title = self.movie.title
        
        overviewLabel.text = self.movie.overview
        overviewLabel.sizeToFit()
        
        let realHeight = (overviewLabel.frame.origin.y * 2) + overviewLabel.frame.height
        
        let contentWidth = overviewView.bounds.width
        let contentHeight = overviewView.bounds.height < realHeight ? realHeight : overviewView.bounds.height
        overviewView.contentSize = CGSize(width: contentWidth, height: contentHeight)
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
