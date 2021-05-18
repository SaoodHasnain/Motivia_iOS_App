//
//  ViewController.swift
//  Malama
//
//  Created by Hamza Shahbaz on 13/04/2020.
//  Copyright © 2020 Hamza Shahbaz. All rights reserved.
//

import UIKit
import Firebase


class OnBoardVC: UIViewController, UIScrollViewDelegate {
    
    @IBOutlet var scrollView: UIScrollView!
    @IBOutlet var pageControl: UIPageControl!
    @IBOutlet var btnGetStarted: UIButton!
    @IBOutlet var btnSignIn: UIButton!

    var scrollWidth: CGFloat! = 0.0
    var scrollHeight: CGFloat! = 0.0

    //data for the slides
    var titles = ["tile1","tile2","tile3","tile4"]
    var descs = ["Lorem ipsum dolor sit amet, consectetur eilts adipiscing elit. vel fringilla elit.","Lorem ipsum dolor sit amet, consectetur eilts adipiscing elit. vel fringilla elit.","Lorem ipsum dolor sit amet, consectetur eilts adipiscing elit. vel fringilla elit.","Lorem ipsum dolor sit amet, consectetur eilts adipiscing elit. vel fringilla elit."]
    var imgs = ["img1","img2","img3","img4"]

    //get dynamic width and height of scrollview and save it
    override func viewDidLayoutSubviews() {
        print(scrollView.frame.size.height)
        scrollWidth = scrollView.frame.size.width
        scrollHeight = scrollView.frame.size.height
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.layoutIfNeeded()
        //to call viewDidLayoutSubviews() and get dynamic width and height of scrollview

        self.scrollView.delegate = self
        scrollView.isPagingEnabled = true
        scrollView.showsHorizontalScrollIndicator = false
        scrollView.showsVerticalScrollIndicator = false

        //crete the slides and add them
        var frame = CGRect(x: 0, y: 0, width: 0, height: 0)

        for index in 0..<titles.count {
            frame.origin.x = scrollWidth * CGFloat(index)
            frame.size = CGSize(width: scrollWidth, height: scrollHeight)

            let slide = UIView(frame: frame)

            //subviews
            let imageView = UIImageView.init(image: UIImage.init(named: imgs[index]))
            imageView.frame = CGRect(x:0,y:0,width:self.view.frame.width,height:self.scrollView.frame.height/2.4)
            imageView.contentMode = .scaleAspectFill
            imageView.center = CGPoint(x:scrollWidth/2,y: scrollHeight/2 - 50)
          
            let txt1 = UILabel.init(frame: CGRect(x:15,y:imageView.frame.maxY+50,width:self.view.frame.width - 30,height:20))
            txt1.textAlignment = .center
            txt1.font = UIFont.boldSystemFont(ofSize: 20.0)
            txt1.text = titles[index]

            let txt2 = UILabel.init(frame: CGRect(x:30,y:txt1.frame.maxY+2,width:self.view.frame.width - 60,height:100))
            txt2.textAlignment = .center
            txt2.textColor = .lightGray
            txt2.numberOfLines = 0
            txt2.font = UIFont.systemFont(ofSize: 15.0)
            txt2.text = descs[index]

            slide.addSubview(imageView)
            slide.addSubview(txt1)
            slide.addSubview(txt2)
            scrollView.addSubview(slide)

        }

        //set width of scrollview to accomodate all the slides
        scrollView.contentSize = CGSize(width: scrollWidth * CGFloat(titles.count), height: scrollHeight)

        //disable vertical scroll/bounce
        self.scrollView.contentSize.height = 1.0

        //initial state
        pageControl.numberOfPages = titles.count
        pageControl.currentPage = 0

    }

    //indicator
    @IBAction func pageChanged(_ sender: Any) {
        scrollView!.scrollRectToVisible(CGRect(x: scrollWidth * CGFloat ((pageControl?.currentPage)!), y: 0, width: scrollWidth, height: scrollHeight), animated: true)
    }

    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        setIndiactorForCurrentPage()
    }

    func setIndiactorForCurrentPage()  {
        let page = (scrollView?.contentOffset.x)!/scrollWidth
        pageControl?.currentPage = Int(page)
    }

    @IBAction func nextBtnTapped(_ sender:Any){
        scrollRight()
    }
    
//    @IBAction func backBtnTapped(_ sender:Any){
//        scrollLeft()
//    }
    
    @IBAction func skipBtnTapped(_ sender:Any){
//        if Auth.auth().currentUser?.uid == nil{
//            let vc = storyboard?.instantiateViewController(withIdentifier: "LoginVC") as! LoginVC
//            self.present(vc,animated: true)
//        }else{
//            let vc = storyboard?.instantiateViewController(withIdentifier: "HomeNavigationVC") as! HomeNavigationVC
//            self.present(vc,animated: true)
//        }
    }
    
    func scrollLeft() {
        if scrollView.contentOffset.x >= self.view.bounds.width {
            scrollView.contentOffset.x -=  self.view.bounds.width

            var frame: CGRect = self.scrollView.frame
            frame.origin.x = scrollView.contentOffset.x
            frame.origin.y = 0
            self.scrollView.setContentOffset(CGPoint(x: frame.origin.x, y: frame.origin.y), animated: true)
            setIndiactorForCurrentPage()
        }
    }

    func scrollRight() {
        if scrollView.contentOffset.x < self.view.bounds.width * CGFloat(titles.count - 1) {
            scrollView.contentOffset.x +=  self.view.bounds.width
            setIndiactorForCurrentPage()
        }else{
//            if Auth.auth().currentUser?.uid == nil{
//                let vc = storyboard?.instantiateViewController(withIdentifier: "LoginVC") as! LoginVC
//                self.present(vc,animated: true)
//            }else{
//                let vc = storyboard?.instantiateViewController(withIdentifier: "HomeNavigationVC") as! HomeNavigationVC
//                self.present(vc,animated: true)
//            }
            
        }
    }
    
}
