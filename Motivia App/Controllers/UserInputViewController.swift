//
//  UserInputViewController.swift
//  Motivia App
//
//  Created by Hamza Shahbaz on 05/04/2021.
//

import UIKit

class UserInputViewController: UIViewController {
    
    //MARK:- Propeerties
    
    @IBOutlet weak var lblQuantity: UILabel!
    @IBOutlet weak var lblStartTime: UILabel!
    @IBOutlet weak var lblEndTime: UILabel!
    
    var startTime = "09:00"
    var endTIme = "22:00"
    var qunatity = 1
    
    //MARK:- Controller Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
    }
    
    
    //MARK:- Supporitng Functions
        
    
    
    //MARK:- Actions
    
    @IBAction func btnContinueTapped(_ sender: Any){
        let controller = self.storyboard?.instantiateViewController(identifier: "WidgetsOnbaordViewController") as! WidgetsOnbaordViewController
        let user = UserModel(userId: getUniqueId(), startTime: startTime, endTime: endTIme, quantity: "\(qunatity)", deviceId: UIDevice.current.identifierForVendor!.uuidString, target: [], themeid: "", deviceTpe: "iOS", likes: [])

        controller.passUser = user
        self.present(controller, animated: true, completion: nil)
    }
    
    
    @IBAction func btnMinusTapped(_ sender: UIButton){
        
        switch sender.tag {
        case 1:
            if qunatity == 1 {
                return
            }
            qunatity = qunatity - 1
            lblQuantity.text = "\(qunatity)"
        case 2:
            let result = timeIncreaseAndDecrease(time: startTime, addedTime: -30)
            lblStartTime.text = result
            self.startTime = result
        default:
            let result = timeIncreaseAndDecrease(time: endTIme, addedTime: -30)
            self.endTIme = result
            lblEndTime.text = result

        }
        
    }
    
    @IBAction func btnPlusTapped(_ sender: UIButton){
        switch sender.tag {
        case 1:
            qunatity = qunatity + 1
            lblQuantity.text = "\(qunatity)"
        case 2:
            let result = timeIncreaseAndDecrease(time: startTime, addedTime: 30)
            self.startTime = result
            lblStartTime.text = result
        default:
            let result = timeIncreaseAndDecrease(time: endTIme, addedTime: 30)
            self.endTIme = result
            lblEndTime.text = result
        }
    }
    
}
