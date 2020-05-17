

//
//  MovieListRouter.swift
//  MoviesFlix
//
//  Created by Ashwini on 16/05/20.
//  Copyright © 2020 Ashwini. All rights reserved.
//

import Foundation
import UIKit

class MovieListRouter: PresenterToRouterProtocol{
   

    class func createModule() ->UIViewController{
        let view = mainstoryboard.instantiateViewController(withIdentifier: "MovieListViewController") as? MoviesListViewController
        //if let view = navController.childViewControllers.first as? MovieListViewController {
            let presenter: ViewToPresenterProtocol & InteractorToPresenterProtocol = MovieListPresenter()
            let interactor: PresentorToInteractorProtocol = MovieListInteractor()
            let router: PresenterToRouterProtocol = MovieListRouter()
            
            view?.presenter = presenter
            presenter.view = view
            presenter.router = router
            presenter.interactor = interactor
            interactor.presenter = presenter
            
            return view!;
            
        //}
        
        //return UIViewController()
    }
    
    static var mainstoryboard: UIStoryboard{
        return UIStoryboard(name:"Main",bundle: Bundle.main)
    }
    
    func presentMovieDetailScreen(from view: PresenterToViewProtocol, forMovies movie: MovieDetails) {
        
        let movieDetailViewController = MDetailsMovieListRouter.createMovieDetailsModule(forMovies: movie)
    
         if let sourceView = view as? UIViewController {
            sourceView.navigationController?.pushViewController(movieDetailViewController, animated: true)
         }
     }
   
       

}
