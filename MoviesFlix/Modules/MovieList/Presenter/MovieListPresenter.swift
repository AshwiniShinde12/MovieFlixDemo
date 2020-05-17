//
//  MovieListPresenter.swift
//  MoviesFlix
//
//  Created by Ashwini on 16/05/20.
//  Copyright © 2020 Ashwini. All rights reserved.
//

import Foundation

class MovieListPresenter: ViewToPresenterProtocol {
   
    var view: PresenterToViewProtocol?
    var interactor: PresentorToInteractorProtocol?
    var router: PresenterToRouterProtocol?
    
    func updateView() {
        interactor?.fetchMovies()
    }
    func showMovieDetail(forMovie Movie: MovieDetails){
            router?.presentMovieDetailScreen(from: view!, forMovies: Movie)
    }
       
       
}

extension MovieListPresenter: InteractorToPresenterProtocol {
    func moviesFetched(movies: MoviesModel) {
        view?.showMovies(movies: movies)
    }
    
    func moviesFetchedFailed() {
        view?.showError()
    }
    

}

