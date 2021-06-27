import UIKit
import FLAnimatedImage


class MainViewController: UIViewController {
    
    @IBOutlet weak var catImageView: UIImageView!
    @IBOutlet weak var catFactLabel: UILabel!
    @IBOutlet weak var catGifView: FLAnimatedImageView!
    
    var isFirstClick: Bool = true
    
    
    @IBOutlet weak var factButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func factActionButtom() {
        if isFirstClick {
            factButton.setTitle("mooore 🐱", for: .normal)
            isFirstClick = !isFirstClick
        }
        updateData()
    }
}

extension MainViewController {
    private func updateData(){
        for neededData in dataExamples.allCases {
            guard let url = URL(string: neededData.rawValue) else { return }
            
             URLSession.shared.dataTask(with: url) { (data, response, error) in
                if let error = error {
                    print(error)
                    return
                }
                
                if let data = data{
                    DispatchQueue.main.async {
                        switch neededData {
                        case .image:
                            guard let image = UIImage(data: data) else {return}
                            self.catImageView.image = image
                        case .gif:
                            DispatchQueue.main.async {
                                let imageData = try? FLAnimatedImage(animatedGIFData: data)
                                self.catGifView.animatedImage = imageData
                            }
                        default:
                            do {
                                let fact = try JSONDecoder().decode(Fact.self, from: data)
                                DispatchQueue.main.async {
                                    self.catFactLabel.text = fact.text
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
