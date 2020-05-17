


//
//  TPMoviesPresenter'.swift
//  MoviesFlix
//
//  Created by Ashwini on 17/05/20.
//  Copyright © 2020 Ashwini. All rights reserved.
//

import Foundation

class TRMovieListPresenter: TRViewToPresenterProtocol {
  
   
    
    
    var view: TRPresenterToViewProtocol?
    var interactor: TRPresentorToInteractorProtocol?
    var router: TRPresenterToRouterProtocol?
    
    func updateView() {
        interactor?.fetchTRMovies()
    }
    func showMovieDetail(forMovie Movie: MovieDetails) {
        router?.presentMovieDetailScreen(from: view!, forMovies: Movie)
    }
  
}

extension TRMovieListPresenter: TRInteractorToPresenterProtocol {
    func moviesTRFetched(movies: MoviesModel) {
         view?.showMovies(movies: movies)
    }
    
    func moviesTRFetchedFailed() {
        view?.showError()
    }
    
   
}

