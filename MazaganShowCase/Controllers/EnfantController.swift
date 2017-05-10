import Foundation
import UIKit
import SJFluidSegmentedControl
import ActionButton
    class EnfantController: UIViewController{
        
        // MARK: - Outlets
        
        @IBOutlet weak var segmentedControl: SJFluidSegmentedControl!
        @IBOutlet var label: UILabel!
        
        var descriptionbaby :String? = nil
        var descriptionKids :String? = nil
        var descriptionRush :String? = nil
        var actionButton: ActionButton!
        // MARK: - View Lifecycle
        private let Array: NSArray = ["First","Second","Third"]
        
        let imageView = UIImageView(image: UIImage(named: "logoMazagan")!)
        
        let rect:CGRect = CGRect( x: 0, y: 0 ,width: 1000, height : 80)
        
        override func viewDidLoad() {
            super.viewDidLoad()
            
            let resp = Utils.getSyncDataFromUrl(url: "http://www.beyond4edges.com/mazagan/MazaganWebService/public/index.php/Mazagan/GetDescription/Enfants", httpMethod: "GET", parameter: "") as! NSArray
            let babysMenu : NSDictionary = resp[0] as! NSDictionary
            let kidsMenu : NSDictionary = resp[1] as! NSDictionary
            let RushyogaMenu : NSDictionary = resp[2] as! NSDictionary
            descriptionbaby = String (describing:babysMenu["description"])
            descriptionKids = String (describing:kidsMenu["description"])
            descriptionRush = String (describing:RushyogaMenu["description"])
            
            print("test: \(String(describing: resp[0]))")
            
            
            
            
            print("test")
            if #available(iOS 8.2, *) {
                segmentedControl.textFont = .systemFont(ofSize: 16, weight: UIFontWeightSemibold)
            } else {
                segmentedControl.textFont = .boldSystemFont(ofSize: 16)
            }
            
            let segRect:CGRect = CGRect(x: segmentedControl.frame.origin.x, y: segmentedControl.frame.origin.y, width: UIScreen.main.bounds.size.width - 40.0, height: 60)
            
            segmentedControl.frame = segRect
            
            let scrollRect:CGRect = CGRect(x: 0, y: segmentedControl.frame.origin.y + segmentedControl.frame.size.height, width: UIScreen.main.bounds.size.width, height: UIScreen.main.bounds.size.height - (segmentedControl.frame.origin.y + segmentedControl.frame.size.height))
            
            //the defaut value on load the page
            label?.text = descriptionbaby
            label.numberOfLines = 20
            label?.center = CGPoint(x: 300, y: 400)
            label?.textAlignment = .center
            label.frame = scrollRect
          
            //the code of floating buttom
            let twitterImage = UIImage(named: "logoMazagan")!
            let plusImage = UIImage(named: "logoMazagan")!
            
            let twitter = ActionButtonItem(title: "Twitter", image: twitterImage)
            
            let google = ActionButtonItem(title: "Google Plus", image: plusImage)
            google.action = { item in print("Google Plus...") }
            
            actionButton = ActionButton(attachedToView: self.view, items: [twitter, google])
            actionButton.action = { button in button.toggleMenu() }
            actionButton.setTitle("+", forState: UIControlState())
            
            actionButton.backgroundColor = UIColor(red: 238.0/255.0, green: 130.0/255.0, blue: 34.0/255.0, alpha:1.0)
           
            
        }
        
        // to be conformed to the protocol
        
        
        override func viewDidAppear(_ animated: Bool) {
            super.viewDidAppear(animated)
            
            // Uncomment the following line to set the current segment programmatically.
            // segmentedControl.currentSegment = 1
        }
        
        
    }
    
    // MARK: - SJFluidSegmentedControl Data Source Methods
    
    extension EnfantController: SJFluidSegmentedControlDataSource {
        
        func numberOfSegmentsInSegmentedControl(_ segmentedControl: SJFluidSegmentedControl) -> Int {
            return 3
        }
        
        func segmentedControl(_ segmentedControl: SJFluidSegmentedControl,
                              titleForSegmentAtIndex index: Int) -> String? {
            
            if index == 0 {
                return "baby club".uppercased()
            } else if index == 1 {
                return "kidz club".uppercased()
            }
            return "club rush".uppercased()
        }
        
        
        func segmentedControl(_ segmentedControl: SJFluidSegmentedControl, didChangeFromSegmentAtIndex fromIndex: Int, toSegmentAtIndex toIndex: Int) {
            
            if (toIndex == 0){
                
                label?.text = descriptionbaby
                label?.textColor = UIColor.black
                print("ii'm in 1")
                
            }
            if (toIndex == 1){
                label?.text = descriptionKids
                
                print("ii'm in 2")
                
                
            }
            if (toIndex == 2){
                label?.text = descriptionRush
                print("ii'm in 3")
                
            }
            
            //        self.segmentedControl(segmentedControl, didScrollWithXOffset:offset)
            
        }
        
        func segmentedControl(_ segmentedControl: SJFluidSegmentedControl,
                              gradientColorsForSelectedSegmentAtIndex index: Int) -> [UIColor] {
            switch index {
            case 0:
                return [UIColor(red: 51 / 255.0, green: 149 / 255.0, blue: 182 / 255.0, alpha: 1.0),
                        UIColor(red: 97 / 255.0, green: 199 / 255.0, blue: 234 / 255.0, alpha: 1.0)]
            case 1:
                return [UIColor(red: 227 / 255.0, green: 206 / 255.0, blue: 160 / 255.0, alpha: 1.0),
                        UIColor(red: 225 / 255.0, green: 195 / 255.0, blue: 128 / 255.0, alpha: 1.0)]
            case 2:
                return [UIColor(red: 21 / 255.0, green: 94 / 255.0, blue: 119 / 255.0, alpha: 1.0),
                        UIColor(red: 9 / 255.0, green: 82 / 255.0, blue: 107 / 255.0, alpha: 1.0)]
            default:
                break
            }
            return [.clear]
        }
        
        func segmentedControl(_ segmentedControl: SJFluidSegmentedControl,
                              gradientColorsForBounce bounce: SJFluidSegmentedControlBounce) -> [UIColor] {
            switch bounce {
            case .left:
                return [UIColor(red: 51 / 255.0, green: 149 / 255.0, blue: 182 / 255.0, alpha: 1.0)]
            case .right:
                return [UIColor(red: 9 / 255.0, green: 82 / 255.0, blue: 107 / 255.0, alpha: 1.0)]
            }
        }
        
    }
    
    // MARK: - SJFluidSegmentedControl Delegate Methods
    
    extension EnfantController: SJFluidSegmentedControlDelegate {
        
        func segmentedControl(_ segmentedControl: SJFluidSegmentedControl, didScrollWithXOffset offset: CGFloat) {
            
            print("Scrolling offset: \(offset)")
            
            //        scrollView.contentOffset.x += offset
        }
        
}

