//
//  MovieDetailsViewController.swift
//  MoviesFlix
//
//  Created by Ashwini on 17/05/20.
//  Copyright © 2020 Ashwini. All rights reserved.
//

import UIKit

class MovieDetailsViewController: UIViewController {
    var presenter: MDetailsViewToPresenterProtocol?
    
    @IBOutlet weak var posterImageView: UIImageView!
    
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var lblReleseDate: UILabel!
    @IBOutlet weak var lblOverview: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter?.updateView()
    
    }
    
    
}
extension MovieDetailsViewController: MDetailsPresenterToViewProtocol {
    func showMovieDetails(movie: MovieDetails) {
        lblTitle.adjustsFontSizeToFitWidth = true
        lblTitle.text = movie.title
        lblOverview.text = movie.overview
        lblReleseDate.text = movie.releaseDate
        let urlStr = movie.posterPath
        let imgStr = poster_path_BaseUrl + urlStr
        let url = URL(string: imgStr)
        let data = try? Data(contentsOf: url!)
        posterImageView.image = UIImage(data: data!)
        
    }
    
    func showError() {
        let alert = UIAlertController(title: "Alert", message: "Problem Fetching Movie Details", preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "Okay", style: UIAlertAction.Style.default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    
    
}
