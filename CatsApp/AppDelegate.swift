//
//  AppDelegate.swift
//  CatsApp
//
//  Created by Kravtsov Evgeniy on 27.06.2021.
//

import UIKit
@main
class AppDelegate: UIResponder, UIApplicationDelegate {


    enum urlExamples: String {
        case imageURL = "https://cataas.com/cat?width=250"
        case gifURL = "https://cataas.com/cat/gif"
        case factUrl = "https://cat-fact.herokuapp.com/facts/random?amount=1"
    }
    
    struct Fact:Decodable {
        let _id: String?
        let __v: Int?
        let text: String
        let updateAt: String?
        let deleted: Bool?
        let source: String?
        let sentCount: Int?
    }


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        fetchImage()
        fetchFact()
        return true
    }

    // MARK: UISceneSession Lifecycle

    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }

    private func fetchImage() {
        guard let url = URL(string: urlExamples.imageURL.rawValue) else { return }
        
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            if let error = error {
                print(error)
                return
            }
            
            if let data = data, let image = UIImage(data: data) {
                let startVC = UIApplication.shared.windows.first!.rootViewController as! MainViewController
                
                    DispatchQueue.main.async {
                        startVC.catImageView.image = image
//                        self.activityIndicator.stopAnimating()
                    }
                
            }
        }.resume()
    }
    
    private func fetchFact() {
        guard let url = URL(string: urlExamples.factUrl.rawValue) else { return }
        
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            if let error = error {
                print(error)
                return
            }
            guard let data = data else { return }
            do {
                let fact = try JSONDecoder().decode(Fact.self, from: data)
                DispatchQueue.main.async {
                    print(fact, "<<<<<<<<<<FACT")
                }
                                let startVC = UIApplication.shared.windows.first!.rootViewController as! MainViewController
                
                                    DispatchQueue.main.async {
                                        startVC.catFactLabel.text = fact.text
                                    }
                
            }
            catch let error {
                print (error)
            }

        }.resume()
    }
    
}

