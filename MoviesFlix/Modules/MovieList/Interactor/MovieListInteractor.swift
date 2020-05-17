
//
//  MovieListInteractor.swift
//  MoviesFlix
//
//  Created by Ashwini on 16/05/20.
//  Copyright © 2020 Ashwini. All rights reserved.
//

import Foundation
import Alamofire

class MovieListInteractor: PresentorToInteractorProtocol{

    var presenter: InteractorToPresenterProtocol?
    
    func fetchMovies() {
        AF.request(API_NOW_PLAYING_LIST).response { response in
            if(response.response?.statusCode == 200){
                guard let data = response.data else { return }
                do {
                    let decoder = JSONDecoder()
                    let movies = try decoder.decode(MoviesModel.self, from: data)
                    self.presenter?.moviesFetched(movies: movies)
                } catch let error {
                    print(error)
                }
            }
            else {
                self.presenter?.moviesFetchedFailed()
            }
        }
    }
}
