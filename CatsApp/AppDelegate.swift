//
//  AppDelegate.swift
//  CatsApp
//
//  Created by Kravtsov Evgeniy on 27.06.2021.
//

import UIKit
import FLAnimatedImage

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        fetchData()
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
    
    private func fetchData() {
        for neededData in dataExamples.allCases {
            
            guard let url = URL(string: neededData.rawValue) else { return }
            
            URLSession.shared.dataTask(with: url) { (data, response, error) in
                if let error = error {
                    print(error)
                    return
                }
                
                if let data = data{
                    let startVC = UIApplication.shared.windows.first!.rootViewController as! MainViewController
                    
                    DispatchQueue.main.async {
                        switch neededData {
                        case .image:
                            guard let image = UIImage(data: data) else {return}
                            startVC.catImageView.image = image
                        case .gif:
                            DispatchQueue.main.async {
                                let imageData = try? FLAnimatedImage(animatedGIFData: data)
                                startVC.catGifView.animatedImage = imageData
                            }
                        default:
                            do {
                                let fact = try JSONDecoder().decode(Fact.self, from: data)
                                DispatchQueue.main.async {
                                    startVC.catFactLabel.text = fact.text
                                }
                            }
                            catch let error {
                                print (error)
                            }
                        }
                        
                    }
                }
            }.resume()
        }
    }
    
}

