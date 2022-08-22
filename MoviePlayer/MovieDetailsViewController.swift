//
//  MovieDetailsViewController.swift
//  MoviePlayer
//
//  Created by Devkrushna4 on 13/08/22.
//

import UIKit

class MovieDetailsViewController: UIViewController {

    
    @IBOutlet weak var navigationView: UIView!
    
    @IBOutlet weak var moviewDetailContainerView: UIView!
    @IBOutlet weak var movieImageView: UIImageView!
    @IBOutlet weak var moviesDetailTableView: UITableView!
    
    var movieDetail = MovieDetail()
    var genreDetails = [GenreList]()
    var genreUrl = "https://api.themoviedb.org/3/genre/movie/list?api_key=4e0be2c22f7268edffde97481d49064a&language=en-US"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setUpUIElements()
        
        // Do any additional setup after loading the view.
    }
    
    func setUpUIElements(){
        self.view.backgroundColor = .backgroundColor
        self.navigationView.frame.size.height = 70 + MYdevice.topAnchor
        self.navigationView.backgroundColor = .navigationColor
        
        self.moviewDetailContainerView.frame.origin.y = navigationView.frame.maxY
        
        self.movieImageView.sd_setImage(with: URL(string: (movieDetail.posterPath)!))
        self.moviesDetailTableView.register(UINib(nibName: CellIdentifier.movieDetailTableViewCell, bundle: nil), forCellReuseIdentifier: CellIdentifier.movieDetailTableViewCell)
        self.moviesDetailTableView.delegate = self
        self.moviesDetailTableView.dataSource = self
        
        
        MovieAPIManager.callGETApi(url: genreUrl) { responceDict, status, message in

            if status {
                self.genreDetails = [GenreList]()
                let result = responceDict["genres"] as! [Any]
                for res in result {
                    let resData = res as! [String: AnyObject]
                    var myResult = GenreList()
                    myResult.id = (resData["id"] as? Int)
                    myResult.name = resData["name"] as? String
                    self.genreDetails.append( myResult)
                }
                self.moviesDetailTableView.reloadData()
//                do{
//                    let encodedData = try NSKeyedArchiver.archivedData(withRootObject: responceDict, requiringSecureCoding: false)
//                    UserDefaults.standard.set(encodedData, forKey: "GenreData")
//                }catch{
//                    print(error)
//                }

            }
        }
//        getGenreDataFromUserDefaults()
    }
    
//    func getGenreDataFromUserDefaults(){
//        do{
//            let decoded  = UserDefaults.standard.object(forKey: "GenreData") as! Data
//            let decodedData = try NSKeyedUnarchiver.unarchiveTopLevelObjectWithData(decoded) as! [String:Any]
//
//            genreDetails = [GenreList]()
//            let result = decodedData["genres"] as! [Any]
//            for res in result {
//                let resData = res as! [String: AnyObject]
//                var myResult = GenreList()
//                myResult.id = (resData["id"] as? Int)
//                myResult.name = resData["name"] as? String
//                genreDetails.append( myResult)
//            }
//            moviesDetailTableView.reloadData()
//        }catch{
//
//        }
//    }

    func getgenreName()->String{
        var str = String()
        for gen in movieDetail.genreIDS!{
            for genre in genreDetails{
                if genre.id == gen{
                    if str != ""{
                        str.append(",")
                    }
                    str.append(genre.name!)
                }
            }
        }
        return str
    }

    @IBAction func btnBackAction(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    
}


extension MovieDetailsViewController: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 8
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = moviesDetailTableView.dequeueReusableCell(withIdentifier: CellIdentifier.movieDetailTableViewCell, for: indexPath) as! MovieDetailTableViewCell
       
        
        let newString = getLAbelString(indexPath: indexPath)
        cell.lblDetails.attributedText = newString
        cell.lblDetails.frame.size.height = cell.lblDetails.optimalHeight
        cell.frame.size.height = cell.lblDetails.frame.height
        print(cell.lblDetails.frame.size.height,cell.frame.size.height)
        return cell
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return indexPath.row == 6 ? 200 : 30
    }
    
    func getLAbelString(indexPath: IndexPath)-> NSAttributedString{
        let boldAttribute = [
              NSAttributedString.Key.font: UIFont(name: "HelveticaNeue-Bold", size: 18.0)!
           ]
        let regularAttribute = [
              NSAttributedString.Key.font: UIFont(name: "HelveticaNeue-Light", size: 18.0)!
           ]
        var boldText = NSAttributedString()
        var regularText = NSAttributedString()
        
        
        switch indexPath.row{
        case 0:
            boldText = NSAttributedString(string: (movieDetail.originalTitle)!, attributes: boldAttribute)
            regularText = NSAttributedString(string: "", attributes: regularAttribute)
        case 1:
            boldText = NSAttributedString(string: "Duration : ", attributes: boldAttribute)
            regularText = NSAttributedString(string: "Not Available", attributes: regularAttribute)
        case 2:
            boldText = NSAttributedString(string: "Release Date : ", attributes: boldAttribute)
            regularText = NSAttributedString(string: "\((movieDetail.releaseDate)!)", attributes: regularAttribute)
        case 3:
            boldText = NSAttributedString(string: "Languages : ", attributes: boldAttribute)
            regularText = NSAttributedString(string: "\((movieDetail.originalLanguage)!)", attributes: regularAttribute)
        case 4:
            boldText = NSAttributedString(string: "Genres : ", attributes: boldAttribute)
            regularText = NSAttributedString(string: "\(getgenreName())", attributes: regularAttribute)
            
        case 5:
            boldText = NSAttributedString(string: "Rating : ", attributes: boldAttribute)
            regularText = NSAttributedString(string: "\(((movieDetail.voteAverage)! / 2))", attributes: regularAttribute)
            let starAttachment = NSTextAttachment()
            starAttachment.image = UIImage(named: "starrate")?.withTintColor(.black)
            starAttachment.bounds = CGRect(x: 0, y: 0, width: 20, height: 20)
            let newString = NSMutableAttributedString()
            newString.append(boldText)
            newString.append(NSAttributedString(attachment: starAttachment))
            newString.append(regularText)
            return newString
        
        case 6:
            boldText = NSAttributedString(string: "About : ", attributes: boldAttribute)
            regularText = NSAttributedString(string: "\((movieDetail.overview)!)", attributes: regularAttribute)
            
        case 7:
            boldText = NSAttributedString(string: "Cast : ", attributes: boldAttribute)
            regularText = NSAttributedString(string: "\((movieDetail.title)!)", attributes: regularAttribute)
        default: break
        }
        
        
        let newString = NSMutableAttributedString()
        newString.append(boldText)
        newString.append(regularText)
        return newString
    }
}
