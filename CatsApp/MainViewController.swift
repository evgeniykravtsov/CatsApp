import UIKit
import FLAnimatedImage

class MainViewController: UIViewController {
    
    @IBOutlet weak var catImageView: UIImageView!
    
    @IBOutlet weak var catFactLabel: UILabel!
    
    @IBOutlet weak var catGifView: FLAnimatedImageView!
    
    var isFirstClick: Bool = true
  
    

    @IBOutlet weak var factButton: UIButton!
    
    @IBOutlet weak var imageView: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    @IBAction func factActionButtom() {
        if isFirstClick {
            factButton.setTitle("mooore 🐱", for: .normal)
            isFirstClick = !isFirstClick
            
        }
    }
}

