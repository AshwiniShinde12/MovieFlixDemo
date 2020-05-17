

//
//  MovieListProtocols.swift
//  MoviesFlix
//
//  Created by Ashwini on 16/05/20.
//  Copyright © 2020 Ashwini. All rights reserved.
//

import Foundation
import UIKit

protocol PresenterToViewProtocol: class {
    func showMovies(movies: MoviesModel)
    func showError()
}

protocol InteractorToPresenterProtocol: class {
    func moviesFetched(movies: MoviesModel)
    func moviesFetchedFailed()
}

protocol PresentorToInteractorProtocol: class {
    var presenter: InteractorToPresenterProtocol? {get set}
    func fetchMovies()
}

protocol ViewToPresenterProtocol: class {
    var view: PresenterToViewProtocol? {get set}
    var interactor: PresentorToInteractorProtocol? {get set}
    var router: PresenterToRouterProtocol? {get set}
    func updateView()
     func showMovieDetail(forMovie Movie: MovieDetails)
}

protocol PresenterToRouterProtocol: class {
    static func createModule() -> UIViewController
    func presentMovieDetailScreen(from view: PresenterToViewProtocol, forMovies movie: MovieDetails)
}
