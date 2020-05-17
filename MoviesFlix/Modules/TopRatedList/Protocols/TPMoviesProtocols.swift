//
//  TPMoviesProtocols.swift
//  MoviesFlix
//
//  Created by Ashwini on 17/05/20.
//  Copyright © 2020 Ashwini. All rights reserved.
//


import Foundation
import UIKit

protocol TRPresenterToViewProtocol: class {
    func showMovies(movies: MoviesModel)
    func showError()
}

protocol TRInteractorToPresenterProtocol: class {
    func moviesTRFetched(movies: MoviesModel)
    func moviesTRFetchedFailed()
   
}

protocol TRPresentorToInteractorProtocol: class {
    var presenter: TRInteractorToPresenterProtocol? {get set}
    func fetchTRMovies()
}

protocol TRViewToPresenterProtocol: class {
    var view: TRPresenterToViewProtocol? {get set}
    var interactor: TRPresentorToInteractorProtocol? {get set}
    var router: TRPresenterToRouterProtocol? {get set}
    func updateView()
    func showMovieDetail(forMovie Movie: MovieDetails)
}

protocol TRPresenterToRouterProtocol: class {
    static func createModule() -> UIViewController
    func presentMovieDetailScreen(from view: TRPresenterToViewProtocol, forMovies movie: MovieDetails)
}
