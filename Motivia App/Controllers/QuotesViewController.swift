//
//  QuotesViewController.swift
//  Motivia App
//
//  Created by Hamza Shahbaz on 05/04/2021.
//

import UIKit

class QuotesViewController: UIViewController {
    
    //MARK:- Properties
    
    @IBOutlet weak var themeImage: UIImageView!
    @IBOutlet weak var collectionView: UICollectionView!
    
    let userId = UserDefaults.standard.string(forKey: "userId")
    var likes = UserDefaults.standard.array(forKey: "likes")! as? [String] ?? [String]()
    
    var quoteArr : [QuoteModel]?
    let currentUser = DataService.instance.currentUser
    
    //MARK:- Controller Life Cycle
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getAllQuotes()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if let image = UserDefaults.standard.string(forKey: "themeImg") {
            themeImage.image = UIImage(named: image)
        }
    }
    
    
    //MARK:- Supporting Functions
    
    func getAllQuotes(){
        DataService.instance.getAllQuotes { (quote) in
            self.quoteArr = quote
            self.collectionView.reloadData()
        }
        
        
    }
    
    
    //MARK:- Actions
    
    @objc func handleFavourtiteBtnTapped(sender: UIButton){
        if sender.image(for: .normal) == UIImage(named: "heart") {
            likes = likes.filter{$0 != quoteArr?[sender.tag].quoteId ?? ""}
            UserDefaults.standard.set(likes, forKey: "likes")
            DataService.instance.updateUserField(withUid: userId ?? "", andField: "likes", toNewValue: likes)
            sender.setImage(UIImage(named: "icons8-heart_outline"), for: .normal)
            print(likes)
        }
        else
        {
            sender.setImage(UIImage(named: "heart"), for: .normal)
            likes.append(quoteArr?[sender.tag].quoteId ?? "")
            UserDefaults.standard.set(likes, forKey: "likes")
            DataService.instance.updateUserField(withUid: userId ?? "", andField: "likes", toNewValue: likes)
            print(likes)
        }
    }
    
    @objc func handleShareBtnTapped(sender:UIButton){
        let objectsToShare = [quoteArr?[sender.tag].quote,quoteArr?[sender.tag].author]
        let activityVC = UIActivityViewController(activityItems: objectsToShare as [Any], applicationActivities: nil)
        self.present(activityVC, animated: true, completion: nil)
        
    }
    
}

extension QuotesViewController: UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return quoteArr?.count ?? 0
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "QuotesCell", for: indexPath) as! QuotesCell
        let data = quoteArr?[indexPath.row]
        if likes.contains(data!.quoteId) == true {
            cell.btnfavourite.setImage(UIImage(named: "heart"), for: .normal)
            cell.lblQuotetxt.text = data?.quote
            cell.lblAuthorTxt.text = data?.author
            cell.btnfavourite.addTarget(self, action: #selector(handleFavourtiteBtnTapped), for: .touchUpInside)
            cell.btnfavourite.tag = indexPath.row
        }
        else
        {
            cell.btnfavourite.setImage(UIImage(named: "icons8-heart_outline"), for: .normal)
            cell.lblQuotetxt.text = data?.quote
            cell.lblAuthorTxt.text = data?.author
            cell.btnfavourite.addTarget(self, action: #selector(handleFavourtiteBtnTapped), for: .touchUpInside)
            cell.btnfavourite.tag = indexPath.row
        }
        
        cell.btnShareTapped.addTarget(self, action: #selector(handleShareBtnTapped), for: .touchUpInside)
        cell.btnShareTapped.tag = indexPath.row
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: self.collectionView.frame.size.width, height: self.collectionView.frame.size.height)
    }
    
}
