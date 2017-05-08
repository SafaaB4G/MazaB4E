
    import Foundation
    import UIKit
    import SJFluidSegmentedControl
    
    class ViewControllerSegmented: UIViewController ,UITableViewDataSource, UITableViewDelegate{
        
        // MARK: - Outlets
        
        @IBOutlet weak var segmentedControl: SJFluidSegmentedControl!
        
        @IBOutlet weak var scrollView: UIScrollView!
        var descriptinvilla : String? = nil

        // MARK: - View Lifecycle
        let imageView = UIImageView(image: UIImage(named: "logoMazagan")!)
        let image1 = UIImageView(image: UIImage(named: "PoolViewRoom")!)
        let image2 = UIImageView(image: UIImage(named: "PartialOceanViewRoom")!)
        let image3 = UIImageView(image: UIImage(named: "OceanViewRoom")!)
        let image4 = UIImageView(image: UIImage(named: "mazaganbeach")!)

        
        let rect:CGRect = CGRect( x: 0, y: 0 ,width: 1000, height : 80)
        var myTableView:UITableView? = nil
        var myTableView1:UITableView? = nil
        var myView3:UIView? = nil
        
        override func viewDidLoad() {
            super.viewDidLoad()
            
            
            let resp = Utils.getSyncDataFromUrl(url: "http://www.beyond4edges.com/mazagan/MazaganWebService/public/index.php/Mazagan/GetDescription/villa", httpMethod: "GET", parameter: "") as! NSArray
            let villaMenu : NSDictionary = resp[0] as! NSDictionary
            descriptinvilla = String (describing:villaMenu["description"])
            
            
            
            
            print("test")
            if #available(iOS 8.2, *) {
                segmentedControl.textFont = .systemFont(ofSize: 16, weight: UIFontWeightSemibold)
            } else {
                segmentedControl.textFont = .boldSystemFont(ofSize: 16)
            }
            
            let segRect:CGRect = CGRect(x: segmentedControl.frame.origin.x, y: segmentedControl.frame.origin.y, width: UIScreen.main.bounds.size.width - 40.0, height: 60)
            
            segmentedControl.frame = segRect
            
            
            
            let scrollRect:CGRect = CGRect(x: 0, y: segmentedControl.frame.origin.y + segmentedControl.frame.size.height, width: UIScreen.main.bounds.size.width, height: UIScreen.main.bounds.size.height - (segmentedControl.frame.origin.y + segmentedControl.frame.size.height))
           
            
             let scrollRect2:CGRect = CGRect(x: 0, y: segmentedControl.frame.origin.y + segmentedControl.frame.size.height - 200, width: UIScreen.main.bounds.size.width, height: UIScreen.main.bounds.size.height - (segmentedControl.frame.origin.y + segmentedControl.frame.size.height))
            scrollView.frame = scrollRect
            
            let barHeight: CGFloat = UIApplication.shared.statusBarFrame.size.height / 2
            let displayWidth: CGFloat = self.view.frame.width
            let displayHeight: CGFloat = self.view.frame.height
            
            myTableView = UITableView(frame: CGRect(x: 0, y: 0 , width: displayWidth, height: displayHeight - barHeight))
            myTableView?.register(UITableViewCell.self, forCellReuseIdentifier: "MyCell")
            myTableView?.dataSource = self
            myTableView?.delegate = self
            self.myTableView?.separatorColor = UIColor.clear
            
            myTableView?.backgroundColor = UIColor.yellow
            
            myTableView1 = UITableView(frame: CGRect(x: UIScreen.main.bounds.size.width, y: 0 , width: displayWidth, height: displayHeight - barHeight))
            myTableView1?.register(UITableViewCell.self, forCellReuseIdentifier: "MyCell")
            myTableView1?.dataSource = self
            myTableView1?.delegate = self
            myTableView1?.separatorColor = UIColor.clear
            myTableView1?.backgroundColor = UIColor.orange
            
            myView3 = UIView(frame: CGRect(x: UIScreen.main.bounds.size.width * 2, y: 0 , width: displayWidth, height: displayHeight - barHeight))
            
//            let rectlabel : CGRect = CGRect(x:0 ,y :segmentedControl.frame.origin.y+segmentedControl.frame.height , width :displayWidth , height : displayHeight - barHeight )
//            
            //myView3?.backgroundColor = UIColor.purple
            let label:UILabel = UILabel()
            label.textColor = UIColor.black
            label.backgroundColor = UIColor.brown
            label.text = descriptinvilla
            label.numberOfLines = 20
            label.center = CGPoint(x: 300, y: 400)
            label.textAlignment = .center
            label.frame = scrollRect2
            
            self.myView3?.addSubview(label)
            self.scrollView.addSubview(myTableView!)
            self.scrollView.addSubview(myTableView1!)
            self.scrollView.addSubview(myView3!)
            
        }
        
        // to be conformed to the protocol
        
        func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
            print("Num: \(indexPath.row)")
            //print("Value: \(Array[indexPath.row])")
        }
        
        func numberOfSections(in tableView: UITableView) -> Int {
            
            return 1
        }
        
        func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            
            if (segmentedControl.currentSegment == 0){
                print ("im in chambre")
                
                return 4
            }
            if (segmentedControl.currentSegment == 1){
                print ("im in suite")
                
                return 5
            }
            
            return 9
            
        }
        
        
        func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            
            let cell = tableView.dequeueReusableCell(withIdentifier: "MyCell", for: indexPath as IndexPath)
            cell.textLabel?.font = UIFont.boldSystemFont(ofSize: 20)
            cell.textLabel?.textColor = UIColor.blue
            
            if (segmentedControl.currentSegment == 0){
                
                
                switch indexPath.row {
                case 0:
                    cell.textLabel?.text = "Pool View Room"
                    cell.imageView?.image = image1.image
                    image1.frame = rect
                case 1:
                    cell.textLabel?.text = "Partial Ocean View Room"
                    image2.frame = rect

                    cell.imageView?.image = image2.image


                case 2:
                    cell.textLabel?.text = "Ocean View Room"
                    image3.frame = rect

                    cell.imageView?.image = image3.image


                case 3:
                    cell.textLabel?.text = "Prime Ocean View Room"
                    image4.frame = rect

                    cell.imageView?.image = image4.image


                default:
                    cell.textLabel?.text = "No Rows"

                }
                
            }
            if (segmentedControl.currentSegment == 1){
                imageView.frame = rect
                cell.imageView?.image = imageView.image
                switch indexPath.row {
                case 0:
                    cell.textLabel?.text = "Ocean View Mazagan Suite"
                case 1:
                    cell.textLabel?.text = "Prime Ocean Mazagan Suite"
                case 2:
                    cell.textLabel?.text = "Executive  Suite"
                case 3:
                    cell.textLabel?.text = "Ambassadeur Suite"
                case 4:
                    cell.textLabel?.text = "Royal Suite"
                default:
                    cell.textLabel?.text = "No Rows"
                    
                }
            }
            
            
            return cell
        }
        func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
          return 200
        }
        
        
        override func viewDidAppear(_ animated: Bool) {
            super.viewDidAppear(animated)
            
            // Uncomment the following line to set the current segment programmatically.
            // segmentedControl.currentSegment = 1
        }
        
        
    }
    
    // MARK: - SJFluidSegmentedControl Data Source Methods
    
    extension ViewControllerSegmented: SJFluidSegmentedControlDataSource {
        
        func numberOfSegmentsInSegmentedControl(_ segmentedControl: SJFluidSegmentedControl) -> Int {
            return 3
        }
        
        func segmentedControl(_ segmentedControl: SJFluidSegmentedControl,
                              titleForSegmentAtIndex index: Int) -> String? {
            
            if index == 0 {
                return "Chambre".uppercased()
            } else if index == 1 {
                return "Suite".uppercased()
            }
            return "Villa".uppercased()
        }
        
        
        func segmentedControl(_ segmentedControl: SJFluidSegmentedControl, didChangeFromSegmentAtIndex fromIndex: Int, toSegmentAtIndex toIndex: Int) {
            
            let offset:CGFloat = UIScreen.main.bounds.size.width * CGFloat(toIndex - fromIndex);
            
            scrollView.contentOffset.x += offset
            
            //        self.segmentedControl(segmentedControl, didScrollWithXOffset:offset)
            
            print ("index is : \(fromIndex) \(toIndex)")
            self.myTableView?.reloadData()
            self.myTableView1?.reloadData()
            
            
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
    
    extension ViewControllerSegmented: SJFluidSegmentedControlDelegate {
        
        func segmentedControl(_ segmentedControl: SJFluidSegmentedControl, didScrollWithXOffset offset: CGFloat) {
            
            print("Scrolling offset: \(offset)")
            
            //        scrollView.contentOffset.x += offset
        }
        
        
}

