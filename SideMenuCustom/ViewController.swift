//
//  ViewController.swift
//  SideMenuCustom
//
//  Created by Ahmed Ramzy on 7/25/20.
//  Copyright © 2020 Ahmed Ramzy. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    var sideVC: SideMenuVC?
    let width = UIScreen.main.bounds.size.width
    let finalWidth = UIScreen.main.bounds.size.width * 0.8
    let finalHeight = UIScreen.main.bounds.size.height
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        AppDelegate.isEnglish = true
        setUpMenu()

    }
    
    func setUpMenu(){
        sideVC = storyboard?.instantiateViewController(withIdentifier: "sideMenuVC") as? SideMenuVC

        let swipeRight = UISwipeGestureRecognizer(target: self, action: #selector(self.respondToGeture))
        swipeRight.direction = UISwipeGestureRecognizer.Direction.right
        let swipeLeft = UISwipeGestureRecognizer(target: self, action: #selector(self.respondToGeture))
        swipeLeft.direction = UISwipeGestureRecognizer.Direction.left
        
        self.view.addGestureRecognizer(swipeRight)
        self.view.addGestureRecognizer(swipeLeft)
        
        if AppDelegate.isEnglish {
            self.navigationItem.leftBarButtonItem = UIBarButtonItem(image: #imageLiteral(resourceName: "menu"), landscapeImagePhone: #imageLiteral(resourceName: "menu"), style: .plain, target: self, action: #selector(self.didTabMenu))
        } else{
            self.navigationItem.rightBarButtonItem = UIBarButtonItem(image: #imageLiteral(resourceName: "menu"), landscapeImagePhone: #imageLiteral(resourceName: "menu"), style: .plain, target: self, action: #selector(self.didTabMenu))
        }
    }
        @IBAction func didTabMenu(_ sender: Any) {
            if AppDelegate.menu_bool{
                show_menu()
            } else{
                hide_menu()
            }
        }

    
    @objc func respondToGeture(gesture: UISwipeGestureRecognizer){
        switch gesture.direction {
        case UISwipeGestureRecognizer.Direction.right:
            AppDelegate.isEnglish ? show_menu() : hide_menu()
        case UISwipeGestureRecognizer.Direction.left:
            AppDelegate.isEnglish ? hide_menu() : show_menu()
        default:
            break
        }
    }
    
    func show_menu(){
        UIView.animate(withDuration: 0.3){
            () -> Void in
            if (AppDelegate.isEnglish){
                self.sideVC?.view.frame = CGRect(x: 0, y: 0, width: self.finalWidth, height: self.finalHeight)
            }else{
                self.sideVC?.view.frame = CGRect(x: self.width - self.finalWidth, y:0, width: UIScreen.main.bounds.size.width * 0.8, height: self.finalHeight)
            }
            
            //self.sideVC?.view.backgroundColor = UIColor.white.withAlphaComponent(0.6)
            
            self.addChild(self.sideVC!)
            self.view.addSubview((self.sideVC?.view)!)
            AppDelegate.menu_bool = false
        }
    }
    
    func hide_menu(){
        UIView.animate(withDuration: 0.3, animations: {
            () -> Void in
            if (AppDelegate.isEnglish){
                self.sideVC?.view.frame = CGRect(x: -self.finalWidth, y: 0, width: self.finalWidth, height: self.finalHeight)
            }else{
                self.sideVC?.view.frame = CGRect(x: self.finalWidth, y: 0, width: self.finalWidth, height: self.finalHeight)
            }
                    }) {
            (finished) in
            self.sideVC?.view.removeFromSuperview()
        }
        AppDelegate.menu_bool = true
    }

    
}

