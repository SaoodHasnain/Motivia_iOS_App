//
//  HomeVC.swift
//  KindFind
//
//  Created by Hamza Shahbaz on 07/11/2020.
//

import UIKit
import CHTCollectionViewWaterfallLayout

class ThemeViewController: UIViewController {
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    var isSelected = true
    var index : IndexPath?
    let theme = UserDefaults.standard.string(forKey: "themeImg")

    
    //MARK: - View Controller Lifecycle
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        // Attach datasource and delegate
        collectionView.dataSource  = self
        collectionView.delegate = self
        setupCollectionView()
        
        //Register nibs
        registerNibs()
    }
    
   
    
   
  
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //MARK: - CollectionView UI Setup
    func setupCollectionView(){
        
        // Create a waterfall layout
        let layout = CHTCollectionViewWaterfallLayout()
        
        // Change individual layout attributes for the spacing between cells
        layout.minimumColumnSpacing = 1.0
        layout.minimumInteritemSpacing = 1.0
        
        // Collection view attributes
        collectionView.autoresizingMask = [.flexibleHeight, .flexibleWidth]
        collectionView.alwaysBounceVertical = true
        
        // Add the waterfall layout to your collection view
        collectionView.collectionViewLayout = layout
    }

    func registerNibs(){
        
        // attach the UI nib file for the ImageUICollectionViewCell to the collectionview
        let viewNib = UINib(nibName: "ImageUICollectionViewCell", bundle: nil)
        collectionView.register(viewNib, forCellWithReuseIdentifier: "cell")
    }
    
    //MARK:- Actions
    
    @IBAction func btnAnnuerTapped(_ sender: Any){
        self.dismiss(animated: true, completion: nil)
    }
}


extension ThemeViewController: UICollectionViewDelegate, UICollectionViewDataSource, CHTCollectionViewDelegateWaterfallLayout{
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 125
    }
    
    
    //** Create a basic CollectionView Cell */
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! ImageUICollectionViewCell
        if indexPath.row == index?.row  {
            cell.tickView.isHidden = false
        }
        else
        {
            cell.tickView.isHidden = true
        }
        if isSelected == true {
            if indexPath.row == (Int(theme!)! - 1) {
                cell.tickView.isHidden = false
                isSelected = false
            }
        }
        cell.image.image = UIImage(named: "\(indexPath.row + 1)")
        cell.initCell()
        return cell
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if let cell = collectionView.cellForItem(at: indexPath) as? ImageUICollectionViewCell {
            if cell.tickView.isHidden == true {
                cell.tickView.isHidden = false
                self.index = indexPath
                UserDefaults.standard.setValue("\(indexPath.row + 1)", forKey: "themeImg")
                self.collectionView.reloadData()
            }
            else
            {
                cell.tickView.isHidden = true
                self.index = indexPath
                self.collectionView.reloadData()
            }
        }
    }
    
    //MARK: - CollectionView Waterfall Layout Delegate Methods (Required)
    
    //** Size for the cells in the Waterfall Layout */
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        // create a cell size from the image size, and return the size
        //let imageSize = model.images[indexPath.row].size
//        if collectionView == categoryCollectionView{
//            return CGSize()
//        }
        if indexPath.row % 2 == 0{
            return CGSize(width: self.collectionView.frame.width/2, height: 250.0)
        }else{
            return CGSize(width: self.collectionView.frame.width/2, height: 250.0)
        }
    }
}
