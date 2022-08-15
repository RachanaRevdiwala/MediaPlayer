//
//  ViewController.swift
//  MoviePlayer
//
//  Created by Devkrushna4 on 13/08/22.
//

import UIKit
import Foundation
import SDWebImage

class HomeViewController: UIViewController {

    
    @IBOutlet weak var navigationView: UIView!
    @IBOutlet weak var movieListTableView: UITableView!
    
    let movieUrl = "https://image.tmdb.org/t/p/w185/"
    var movieDetils = [MovieDetail]()
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setUpUI()
        self.callGetPopularMoviesAPI()
        
        // Do any additional setup after loading the view.
    }
    
    func setUpUI(){
        self.view.backgroundColor = .backgroundColor
        self.navigationView.frame.size.height = 70 + MYdevice.topAnchor
        self.navigationView.backgroundColor = .navigationColor
        
        self.movieListTableView.frame.origin.y = navigationView.frame.maxY
        
        self.movieListTableView.register(UINib(nibName: CellIdentifier.moviesListTableViewCell, bundle: nil), forCellReuseIdentifier: CellIdentifier.moviesListTableViewCell)
        self.movieListTableView.delegate = self
        self.movieListTableView.dataSource = self
    }
    
    func callGetPopularMoviesAPI()
    {
        let url1 = "https://api.themoviedb.org/3/movie/popular?api_key=4e0be2c22f7268edffde97481d49064a&language=en-US&page=1"
        MovieAPIManager.callGETApi(url: url1) { responceDict, status, message in
            
            if status
            {
                do{
                    let encodedData = try NSKeyedArchiver.archivedData(withRootObject: responceDict, requiringSecureCoding: false)
                    UserDefaults.standard.set(encodedData, forKey: "MoviesData")
                }catch{
                    print(error)
                }
            
            }
            self.getMoviesDataFromUserDefaults()
        }
    }
    
    
    func getMoviesDataFromUserDefaults(){
        do{
            let decoded  = UserDefaults.standard.object(forKey: "MoviesData") as! Data
            let decodedData = try NSKeyedUnarchiver.unarchiveTopLevelObjectWithData(decoded) as! [String:Any]
            
            movieDetils = [MovieDetail]()
            let result = decodedData["results"] as! [Any]
            for res in result {
                let resData = res as! [String: AnyObject]
                var myResult = MovieDetail()
                myResult.popularity = resData["popularity"] as? Double
                myResult.voteCount = resData["vote_count"] as? Int
                myResult.video = resData["video"] as? Bool
                myResult.posterPath = movieUrl + (resData["poster_path"] as! String)
                myResult.id = resData["id"] as? Int
                myResult.adult = resData["adult"] as? Bool
                myResult.backdropPath = resData["backdrop_path"] as? String
                myResult.originalLanguage = resData["original_language"] as? String
                myResult.originalTitle = resData["original_title"] as? String
                myResult.genreIDS = resData["genre_ids"] as? [Int]
                myResult.title = resData["title"] as? String
                myResult.voteAverage = resData["vote_average"] as? Double
                myResult.overview = resData["overview"] as? String
                myResult.releaseDate = resData["release_date"] as? String
                movieDetils.append( myResult)
            }
            
            movieListTableView.reloadData()
        }catch{
            
        }
    }

}

extension HomeViewController: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        movieDetils.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = movieListTableView.dequeueReusableCell(withIdentifier: CellIdentifier.moviesListTableViewCell, for: indexPath) as! MoviesListTableViewCell
        
        cell.imgViewMovies.sd_setImage(with: URL(string: movieDetils[indexPath.row].posterPath!))
        cell.lblMovietitle.text = movieDetils[indexPath.row].title
        cell.lblMovieStarRating.text = String(describing: movieDetils[indexPath.row].voteAverage!.rounded())
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: ClassIdentifier.movieDetailsViewController) as! MovieDetailsViewController
        vc.movieDetail = movieDetils[indexPath.row]
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return self.movieListTableView.frame.size.width / 3
    }
    
}
