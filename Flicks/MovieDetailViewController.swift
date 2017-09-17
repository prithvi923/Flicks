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
        
        let lowRes = "https://image.tmdb.org/t/p/w45\(self.movie.posterPath)"
        let highRes = "https://image.tmdb.org/t/p/original\(self.movie.posterPath)"
        let smallImageRequest = URLRequest(url: URL(string: lowRes)!)
        let largeImageRequest = URLRequest(url: URL(string: highRes)!)
        self.posterImageView.setImageWith(
            smallImageRequest,
            placeholderImage: nil,
            success: { (smallImageRequest, smallImageResponse, smallImage) in
                if smallImageResponse != nil {
                    self.posterImageView.alpha = 0.0
                    self.posterImageView.image = smallImage
                    UIView.animate(
                        withDuration: 0.3,
                        animations: { () -> Void in
                            self.posterImageView.alpha = 1.0
                        },
                        completion: { (success) -> Void in
                            self.posterImageView.setImageWith(
                                largeImageRequest,
                                placeholderImage: smallImage,
                                success: { (largeImageRequest, largeImageResponse, largeImage) in
                                    self.posterImageView.image = largeImage
                                },
                                failure: { (imageRequest, imageResponse, error) in
                            
                                }
                            )
                        })
                } else {
                    self.posterImageView.image = smallImage
                    self.posterImageView.setImageWith(
                        largeImageRequest,
                        placeholderImage: smallImage,
                        success: { (largeImageRequest, largeImageResponse, largeImage) in
                            self.posterImageView.image = largeImage
                    },
                        failure: { (imageRequest, imageResponse, error) in
                            
                    }
                    )
                }
            }, failure: { (imageRequest, imageResponse, error) in
            
            }
        )

        
        
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
