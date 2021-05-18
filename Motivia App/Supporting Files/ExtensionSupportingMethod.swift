//
//  ExtensionSupportingMethod.swift
//  Sculpt
//
//  Created by Bukhari Syed Saood on 11/25/20.
//

import UIKit

enum type {
    case tblView
    case collView
}

extension UIViewController {
    
    func ConfigureCell(tableView:UITableView?, collectionView:UICollectionView?, nibName: String, reuseIdentifier: String, cellType: type){
        switch cellType {
        case .tblView:
            tableView?.register(UINib(nibName: nibName, bundle: nil), forCellReuseIdentifier: reuseIdentifier)
        default:
            collectionView?.register(UINib(nibName: nibName, bundle: nil), forCellWithReuseIdentifier: reuseIdentifier)
        }
    }
}

//extension UIViewController {
//    
//    
//    class var storyboardID: String {
//        return "\(self)"
//    }
//    
//    static func initiateFrom(Storybaord _storybaord: Storyboard) -> Self {
//        return _storybaord.viewController(Class: self)
//    }
//}

extension UIViewController {
    //MARK:- Helping Methods
    func pushController(contorller: UIViewController, animated: Bool) {
        self.navigationController?.pushViewController(contorller, animated: animated)
    }
    
    func popViewController(animated: Bool = true) {
        self.navigationController?.popViewController(animated: animated)
    }
}

// MARK: To show AlertView
extension UIViewController {
    
    func presentAlert(withTitle title: String, message : String ) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let OKAction = UIAlertAction(title: "OK", style: .default) { action in
        }
        alertController.addAction(OKAction)
        self.present(alertController, animated: true, completion: nil)
        
    }
    
    @discardableResult func popTo(ViewController _viewController: UIViewController.Type) -> Bool {
        for controller in self.navigationController!.viewControllers as Array {
            if controller.isKind(of: _viewController.self) {
                _ =  self.navigationController!.popToViewController(controller, animated: true)
                break
            }
        }
        return false
    }
    
}
extension String {
    func isValidEmail() -> Bool {
        // here, `try!` will always succeed because the pattern is valid
        let regex = try! NSRegularExpression(pattern: "^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,61}[a-zA-Z0-9])?(?:\\.[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,61}[a-zA-Z0-9])?)*$", options: .caseInsensitive)
        return regex.firstMatch(in: self, options: [], range: NSRange(location: 0, length: count)) != nil
    }
}


fileprivate var aView : UIView?

extension UIViewController {
    
    func showLoader(){
        aView = UIView(frame: self.view.bounds)
                aView?.backgroundColor = UIColor(red: 0.5, green: 0.5, blue: 0.5, alpha: 0.5)
        let ai = UIActivityIndicatorView(style: .large)
        ai.color = UIColor.darkGray
        ai.center = aView!.center
        ai.startAnimating()
        aView?.addSubview(ai)
        self.view.addSubview(aView!)
    }
    
    func hideLoader(){
        aView?.removeFromSuperview()
        aView = nil
    }
    
}

//func getCurrentDate() -> String {
//    let formatter = DateFormatter()
//    formatter.dateFormat = "MM/dd/yyyy"
//    return (formatter.string(from: Date()))
//}
//
//func getCurrentTime() -> String{
//    let currentDateTime = Date()
//    let formatter = DateFormatter()
//    
//    formatter.timeStyle = .medium
//    formatter.dateStyle = .none
//    return (formatter.string(from: currentDateTime))
//}
//
//struct Currency {
//
//    private static let formatter: NumberFormatter = {
//        let formatter         = NumberFormatter()
//        formatter.numberStyle = .currency
//        return formatter
//    }()
//    
//    static func stringFrom(_ decimal: Decimal, currency: String? = nil) -> String {
//        return self.formatter.string(from: decimal as NSDecimalNumber)!
//    }
//}
