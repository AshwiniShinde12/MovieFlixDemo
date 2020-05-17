


//
//  TPMoviesInterator.swift
//  MoviesFlix
//
//  Created by Ashwini on 17/05/20.
//  Copyright © 2020 Ashwini. All rights reserved.
//

import Foundation
import Alamofire

class TRMovieListInteractor: TRPresentorToInteractorProtocol{
   
    

    var presenter: TRInteractorToPresenterProtocol?
    
    func fetchTRMovies() {
              AF.request(API_TOP_RATED_LIST).response { response in
                       if(response.response?.statusCode == 200){
                           guard let data = response.data else { return }
                           do {
                               let decoder = JSONDecoder()
                               let movies = try decoder.decode(MoviesModel.self, from: data)
           //                    guard let firstArticle = movies.results?[0] else {
           //                        return
           //                    }
                            self.presenter?.moviesTRFetched(movies: movies)
                           } catch let error {
                               print(error)
                           }
                       }
                       else {
                           self.presenter?.moviesTRFetchedFailed()
                       }
                   }
       }
    
}
