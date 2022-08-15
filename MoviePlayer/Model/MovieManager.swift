//
//  MovieManager.swift
//  MoviePlayer
//
//  Created by Devkrushna4 on 13/08/22.
//

import Foundation

enum MovieAPIManager{
    
    static func callGETApi(url: String, completionHandler: (([String : Any], Bool, String) -> Void)?) {
        lodermaster.start()
        guard MYdevice.isConnectedToNetwork() else {
            lodermaster.stop()
           // get Offline data
            return
        }
        
//        let url1 = "https://api.themoviedb.org/3/movie/popular?api_key=4e0be2c22f7268edffde97481d49064a&language=en-US&page=1"
        
        var request = URLRequest(url: URL(string: url)!)
        
        request.setValue("application/json;charset=utf-8", forHTTPHeaderField: "Content-Type")
        request.httpMethod = "GET"



        let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
        lodermaster.stop()

            if (error != nil) {
                if let error = error as NSError? {
                    print("ErrorDesc : \(error.description)")
                    print("ErrorDebugDesc : \(error.debugDescription)")
                }

                if let validHandler = completionHandler {
                    print("strErrorMessage :- \(error?.localizedDescription ?? "")")

                    if (error?.localizedDescription == "The Internet connection appears to be offline.") {
                        validHandler([String : Any](), false, "noInternetConnection")
                    } else {
                        validHandler([String : Any](), false, error?.localizedDescription ?? "")
                    }
                }

            } else {
                do {
                    guard let data = data else {
                        print(String(describing: error))
                        return
                    }

                    let jsonResponse = try JSONSerialization.jsonObject(with: data, options: []) as? [String : Any]
                   
                    if let dictResponse = jsonResponse, let status = (response as? HTTPURLResponse)?.statusCode, let validHandler = completionHandler {

                        var message: String = ""

                        if let msg = dictResponse[ResponseKeys.responseMessage] as? String {
                            message = msg
                        }

                        DispatchQueue.main.async {
                            validHandler(dictResponse, (status == 200), message)
                        }
                    }

                } catch {
                    if let validHandler = completionHandler {
                        DispatchQueue.main.async {
                            print(error)
                            print("Api response fail", response as Any)
                            validHandler([String : Any](), false, "Something went wrong!")
                        }
                    }
                }
            }
        }
        task.resume()
    }
    
   
}
