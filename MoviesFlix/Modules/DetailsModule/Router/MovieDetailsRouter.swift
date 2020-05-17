


//
//  MovieDetailsRouter.swift
//  MoviesFlix
//
//  Created by Ashwini on 17/05/20.
//  Copyright © 2020 Ashwini. All rights reserved.
//

import Foundation
import UIKit

class MDetailsMovieListRouter: MDetailsPresenterToRouterProtocol{
  
    
    class func createMovieDetailsModule(forMovies movie: MovieDetails) ->UIViewController{
        let view = mainstoryboard.instantiateViewController(withIdentifier: "MovieDetailsViewController") as? MovieDetailsViewController
        //if let view = navController.childViewControllers.first as? MovieListViewController {
            let presenter: MDetailsViewToPresenterProtocol = MDetailsMovieListPresenter()
           
            let router: MDetailsPresenterToRouterProtocol = MDetailsMovieListRouter()
            
            view?.presenter = presenter
            presenter.view = view
            presenter.router = router
            presenter.movie = movie
            
            return view!;
            
        //}
        
        //return UIViewController()
    }
    
    static var mainstoryboard: UIStoryboard{
        return UIStoryboard(name:"Main",bundle: Bundle.main)
    }
}
