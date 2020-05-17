


//
//  TPMoviesRouter.swift
//  MoviesFlix
//
//  Created by Ashwini on 17/05/20.
//  Copyright © 2020 Ashwini. All rights reserved.
//

import Foundation
import UIKit

class TRMovieListRouter: TRPresenterToRouterProtocol{
    
    class func createModule() ->UIViewController{
        let view = mainstoryboard.instantiateViewController(withIdentifier: "TRMovieListViewController") as? TopRatedMoviesViewController
        //if let view = navController.childViewControllers.first as? MovieListViewController {
            let presenter: TRViewToPresenterProtocol & TRInteractorToPresenterProtocol = TRMovieListPresenter()
            let interactor: TRPresentorToInteractorProtocol = TRMovieListInteractor()
            let router: TRPresenterToRouterProtocol = TRMovieListRouter()
            
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
    
    func presentMovieDetailScreen(from view: TRPresenterToViewProtocol, forMovies movie: MovieDetails) {
        
        let movieDetailViewController = MDetailsMovieListRouter.createMovieDetailsModule(forMovies: movie)
    
         if let sourceView = view as? UIViewController {
            sourceView.navigationController?.pushViewController(movieDetailViewController, animated: true)
         }
     }
}
