

//
//  MovieDetailsProtocols.swift
//  MoviesFlix
//
//  Created by Ashwini on 17/05/20.
//  Copyright © 2020 Ashwini. All rights reserved.
//

import Foundation
import UIKit

protocol MDetailsPresenterToViewProtocol: class {
    var presenter: MDetailsViewToPresenterProtocol? {get set}
    func showMovieDetails(movie: MovieDetails)
   
}

protocol MDetailsViewToPresenterProtocol: class {
    var view: MDetailsPresenterToViewProtocol? {get set}
    var router: MDetailsPresenterToRouterProtocol? {get set}
    var movie:MovieDetails?{get set}
    func updateView()
}

protocol MDetailsPresenterToRouterProtocol: class {
    static func createMovieDetailsModule(forMovies movie: MovieDetails) ->UIViewController
}
