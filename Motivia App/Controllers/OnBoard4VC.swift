//
//  OnBoard4VC.swift
//  Motivia App
//
//  Created by Hamza Shahbaz on 01/04/2021.
//

import UIKit

class OnBoard4VC: UIViewController {
    
    //MARK:- Properties
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    var passUser: UserModel?
    
    var target = [String]()
    var arrData = ["Estime de soi","Lâcher prise", "Bonheur", "Santé", "Stress", "Énergie", "Spiritualité", "Relations"]
    let kItemPadding = 15
    
    //MARK:- Controller Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let bubbleLayout = MICollectionViewBubbleLayout()
        bubbleLayout.minimumLineSpacing = 10.0
        bubbleLayout.minimumInteritemSpacing = 10.0
        bubbleLayout.delegate = self
        collectionView.setCollectionViewLayout(bubbleLayout, animated: false)
        
    }
    
    //MARK:- Supporting functions
    
    
    
    //MARK:- Actions
    
    @IBAction func btnContinueTapped(_ sender: Any){
        if target.count != 0 {
            let user = UserModel(userId: passUser?.userId ?? "", startTime: passUser?.startTime ?? "", endTime: passUser?.endTime ?? "", quantity: passUser?.quantity ?? "", deviceId: passUser?.deviceId ?? "", target: target, themeid: passUser?.themeId ?? "",deviceTpe: passUser?.deviceTpe ?? "" ,likes: [])
          
            let controller = self.storyboard?.instantiateViewController(identifier: "OnBoard5VC") as! OnBoard5VC
            controller.passUser = user
            self.present(controller, animated: true, completion: nil)
        }
        else
        {
         print("Select target")
        }
    }
}


extension OnBoard4VC: UICollectionViewDelegate,UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return arrData.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "OnBoard4Cell", for: indexPath) as! OnBoard4Cell
        cell.lbltitleText.text = arrData[indexPath.row] as String
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if let cell = collectionView.cellForItem(at: indexPath) as? OnBoard4Cell {
            if cell.targetView.layer.borderWidth != 1 {
                cell.targetView.layer.borderColor = UIColor.white.cgColor
                cell.targetView.layer.borderWidth = 1
                self.target.append(arrData[indexPath.row])
                print(target)
            }
            else
            {
                cell.targetView.layer.borderColor = nil
                cell.targetView.layer.borderWidth = 0
                target = target.filter{$0 != arrData[indexPath.row]}
                print(target)
            }
        }
        
    }
}

extension OnBoard4VC: MICollectionViewBubbleLayoutDelegate{
    
    func collectionView(_ collectionView:UICollectionView, itemSizeAt indexPath:NSIndexPath) -> CGSize
    {
        let title = arrData[indexPath.row] as String
        var size = title.size(withAttributes: [NSAttributedString.Key.font: UIFont(name: "DMSans-Regular", size: 13)!])
        size.width = CGFloat(ceilf(Float(size.width + CGFloat(kItemPadding * 2))))
        size.height = 40
        
        //...Checking if item width is greater than collection view width then set item width == collection view width.
        if size.width > collectionView.frame.size.width {
            size.width = collectionView.frame.size.width
        }
        
        return size;
    }
}


