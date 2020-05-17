

//
//  MovieDetailsPresenter.swift
//  MoviesFlix
//
//  Created by Ashwini on 17/05/20.
//  Copyright © 2020 Ashwini. All rights reserved.
//

class MDetailsMovieListPresenter: MDetailsViewToPresenterProtocol {
    
    
    
    var view: MDetailsPresenterToViewProtocol?
    var router: MDetailsPresenterToRouterProtocol?
    var movie: MovieDetails?
    
    func updateView() {
        view?.showMovieDetails(movie: movie!)
    }
}

