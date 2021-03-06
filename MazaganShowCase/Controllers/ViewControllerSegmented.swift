//
//  ViewControllerSegmented.swift
//  MazaganShowCase
//
//  Created by Nabil Sossey Alaoui on 4/3/17.
//  Copyright © 2017 B4E. All rights reserved.
//

import Foundation
import UIKit
import SJFluidSegmentedControl

class ViewControllerSegmented: UIViewController ,UITableViewDataSource, UITableViewDelegate{
    
    // MARK: - Outlets
    
    @IBOutlet weak var segmentedControl: SJFluidSegmentedControl!
    
    @IBOutlet weak var scrollView: UIScrollView!
    // MARK: - View Lifecycle
    private let Array: NSArray = ["First","Second","Third"]
    
    let imageView = UIImageView(image: UIImage(named: "logoMazagan")!)
    
    let rect:CGRect = CGRect( x: 0, y: 0 ,width: 1000, height : 80)

    override func viewDidLoad() {
        super.viewDidLoad()


        if #available(iOS 8.2, *) {
            segmentedControl.textFont = .systemFont(ofSize: 16, weight: UIFontWeightSemibold)
        } else {
            segmentedControl.textFont = .boldSystemFont(ofSize: 16)
        }
 
        let segRect:CGRect = CGRect(x: segmentedControl.frame.origin.x, y: segmentedControl.frame.origin.y, width: UIScreen.main.bounds.size.width - 40.0, height: 60)
        
        segmentedControl.frame = segRect
        
        let scrollRect:CGRect = CGRect(x: 0, y: segmentedControl.frame.origin.y + segmentedControl.frame.size.height, width: UIScreen.main.bounds.size.width, height: UIScreen.main.bounds.size.height - (segmentedControl.frame.origin.y + segmentedControl.frame.size.height))
        
        scrollView.frame = scrollRect
        
        let barHeight: CGFloat = UIApplication.shared.statusBarFrame.size.height / 2
        let displayWidth: CGFloat = self.view.frame.width
        let displayHeight: CGFloat = self.view.frame.height
        
        let myTableView:UITableView = UITableView(frame: CGRect(x: 0, y: 0 , width: displayWidth, height: displayHeight - barHeight))
        myTableView.register(UITableViewCell.self, forCellReuseIdentifier: "MyCell")
        myTableView.dataSource = self
        myTableView.delegate = self
        
        myTableView.backgroundColor = UIColor.yellow
        
        let myTableView1:UITableView = UITableView(frame: CGRect(x: UIScreen.main.bounds.size.width, y: 0 , width: displayWidth, height: displayHeight - barHeight))
        myTableView1.register(UITableViewCell.self, forCellReuseIdentifier: "MyCell")
        myTableView1.dataSource = self
        myTableView1.delegate = self
        
        myTableView1.backgroundColor = UIColor.orange
        
        let myTableView2:UITableView = UITableView(frame: CGRect(x: UIScreen.main.bounds.size.width * 2, y: 0 , width: displayWidth, height: displayHeight - barHeight))
        myTableView2.register(UITableViewCell.self, forCellReuseIdentifier: "MyCell")
        myTableView2.dataSource = self
        myTableView2.delegate = self
        
        myTableView2.backgroundColor = UIColor.purple
        
        self.scrollView.addSubview(myTableView)
        self.scrollView.addSubview(myTableView1)
        self.scrollView.addSubview(myTableView2)
        
    }
    
    // to be conformed to the protocol
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("Num: \(indexPath.row)")
        print("Value: \(Array[indexPath.row])")
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return Array.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MyCell", for: indexPath as IndexPath)
        imageView.frame = rect
        cell.imageView?.image = imageView.image
        cell.textLabel?.text = "Pool View Room"
        
        return cell
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

