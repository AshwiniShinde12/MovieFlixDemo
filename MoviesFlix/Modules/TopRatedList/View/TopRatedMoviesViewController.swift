//
//  TopRatedMoviesViewController.swift
//  MoviesFlix
//
//  Created by Ashwini on 17/05/20.
//  Copyright © 2020 Ashwini. All rights reserved.
//

import UIKit

class TopRatedMoviesViewController: UIViewController {
    var presenter: TRViewToPresenterProtocol?
    
    
    @IBOutlet weak var movieTRCollection: UICollectionView!
    
    
    
    lazy var searchBar:UISearchBar = UISearchBar()
    var filteredArray : [MovieDetails]?
    var shouldShowSearchResults = false
    var arrayList:MoviesModel?
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)!
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
    }
    override func viewWillAppear(_ animated: Bool) {
        
        setUpUI()
        presenter?.updateView()
        shouldShowSearchResults = false
        showProgressIndicator(view: self.view)
    }
    
    
    func setUpUI()
    {
        self.searchBar.searchBarStyle = UISearchBar.Style.default
        self.searchBar.placeholder = " Search"
        self.searchBar.text = ""
        self.searchBar.sizeToFit()
        self.searchBar.isTranslucent = false
        self.searchBar.backgroundImage = UIImage()
        self.searchBar.delegate = self
        self.searchBar.resignFirstResponder()
        self.navigationController?.navigationBar.backgroundColor = .themeColor
        self.navigationItem.titleView = searchBar
    }
    
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}


extension TopRatedMoviesViewController: TRPresenterToViewProtocol {
    func showMovies(movies: MoviesModel) {
        arrayList = movies
        movieTRCollection.reloadData()
        hideProgressIndicator(view: self.view)
    }
    
    
    
    func showError() {
        let alert = UIAlertController(title: "Alert", message: "Problem Fetching Movie List", preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "Okay", style: UIAlertAction.Style.default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    
    
}

extension TopRatedMoviesViewController:UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout
{
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
         let width = ((collectionView.frame.width))
         return CGSize(width: width, height: 200)
     }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if(shouldShowSearchResults)
        {
            return filteredArray?.count ?? 0
            
        }else{
            
            return arrayList?.results.count ?? 0
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = movieTRCollection.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! TRMoviesCell
        if(shouldShowSearchResults)
        {
            
            let urlstr = filteredArray?[indexPath.row].posterPath
            let imgStr = poster_path_BaseUrl + urlstr!
            let url = URL(string: imgStr)
            let data = try? Data(contentsOf: url!)
            cell.imageViewTR.image = UIImage(data: data!)
            cell.titleTR.text = filteredArray?[indexPath.row].title
            cell.overviewTR.text = filteredArray?[indexPath.row].overview
            
        }else{
            let urlstr = arrayList?.results[indexPath.row].posterPath
            let imgStr = poster_path_BaseUrl + urlstr!
            let url = URL(string: imgStr)
            let data = try? Data(contentsOf: url!)
            cell.imageViewTR.image = UIImage(data: data!)
            cell.titleTR.text = arrayList?.results[indexPath.row].title
            cell.overviewTR.text = arrayList?.results[indexPath.row].overview
        }
        return cell
        
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        if(shouldShowSearchResults)
        {
            let details = filteredArray?[indexPath.row]
            presenter?.showMovieDetail(forMovie:details!)
            
        }else{
            let details = arrayList?.results[indexPath.row]
            presenter?.showMovieDetail(forMovie:details!)
        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, performAction action: Selector, forItemAt indexPath: IndexPath, withSender sender: Any?) {
           self.arrayList?.results.remove(at: indexPath.row)
           self.movieTRCollection.deleteItems(at: [indexPath])
        }
    
}

extension TopRatedMoviesViewController: UISearchBarDelegate, UISearchDisplayDelegate{
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        self.searchBar.endEditing(true)
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        
        self.searchBar.text = ""
        self.searchBar.endEditing(true)
    }
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        
        print(searchBar.text!)
        let searchString = searchBar.text!
        filteredArray = (arrayList?.results.filter({ $0.title.range(of: searchString,options: .caseInsensitive) != nil}))
        if(filteredArray?.count != 0)
        {
            DispatchQueue.main.async {
                self.shouldShowSearchResults = true
                self.movieTRCollection.reloadData()
            }
        }else{
            self.shouldShowSearchResults = false
            self.movieTRCollection.reloadData()
        }
        
    }
    
    
}

class TRMoviesCell:UICollectionViewCell,UIGestureRecognizerDelegate{
    
    @IBOutlet weak var imageViewTR: UIImageView!
    @IBOutlet weak var bviewTR: UIView!
    @IBOutlet weak var titleTR: UILabel!
    @IBOutlet weak var overviewTR: UILabel!
    
      var cellLabel: UILabel!
      var pan: UIPanGestureRecognizer!
      var deleteLabel1: UILabel!
      var deleteLabel2: UILabel!

      override init(frame: CGRect) {
          super.init(frame: frame)
          commonInit()
      }

      required init?(coder aDecoder: NSCoder) {
          super.init(coder: aDecoder)
          commonInit()
      }

      private func commonInit() {
          self.contentView.backgroundColor = UIColor.themeColor
          self.backgroundColor = UIColor.red

          cellLabel = UILabel()
          cellLabel.textColor = UIColor.white
          cellLabel.translatesAutoresizingMaskIntoConstraints = false
          self.contentView.addSubview(cellLabel)
          cellLabel.topAnchor.constraint(equalTo: self.contentView.topAnchor).isActive = true
          cellLabel.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor).isActive = true
          cellLabel.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor).isActive = true
          cellLabel.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor).isActive = true

          deleteLabel1 = UILabel()
          deleteLabel1.text = "delete"
          deleteLabel1.textColor = UIColor.white
          self.insertSubview(deleteLabel1, belowSubview: self.contentView)

          deleteLabel2 = UILabel()
          deleteLabel2.text = "delete"
          deleteLabel2.textColor = UIColor.white
          self.insertSubview(deleteLabel2, belowSubview: self.contentView)

          pan = UIPanGestureRecognizer(target: self, action: #selector(onPan(_:)))
          pan.delegate = self
          self.addGestureRecognizer(pan)
      }

      override func prepareForReuse() {
          self.contentView.frame = self.bounds
      }

      override func layoutSubviews() {
          super.layoutSubviews()

        if (pan.state == UIGestureRecognizer.State.changed) {
              let p: CGPoint = pan.translation(in: self)
              let width = self.contentView.frame.width
              let height = self.contentView.frame.height
              self.contentView.frame = CGRect(x: p.x,y: 0, width: width, height: height);
              self.deleteLabel1.frame = CGRect(x: p.x - deleteLabel1.frame.size.width-10, y: 0, width: 100, height: height)
              self.deleteLabel2.frame = CGRect(x: p.x + width + deleteLabel2.frame.size.width, y: 0, width: 100, height: height)
          }

      }

    @objc func onPan(_ pan: UIPanGestureRecognizer) {
        if pan.state == UIGestureRecognizer.State.began {

        } else if pan.state == UIGestureRecognizer.State.changed {
              self.setNeedsLayout()
          } else {
              if abs(pan.velocity(in: self).x) > 500 {
                  let collectionView: UICollectionView = self.superview as! UICollectionView
                  let indexPath: IndexPath = collectionView.indexPathForItem(at: self.center)!
                  collectionView.delegate?.collectionView!(collectionView, performAction: #selector(onPan(_:)), forItemAt: indexPath, withSender: nil)
              } else {
                  UIView.animate(withDuration: 0.2, animations: {
                      self.setNeedsLayout()
                      self.layoutIfNeeded()
                  })
              }
          }
      }
      
      func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldRecognizeSimultaneouslyWith otherGestureRecognizer: UIGestureRecognizer) -> Bool {
          return true
      }
      
      override func gestureRecognizerShouldBegin(_ gestureRecognizer: UIGestureRecognizer) -> Bool {
          return abs((pan.velocity(in: pan.view)).x) > abs((pan.velocity(in: pan.view)).y)
      }
    
}








