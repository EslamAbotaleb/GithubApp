//
//  BaseViewController.swift
//  GithubTask
//
//  Created by Islam Abotaleb on 1/5/21.
//

import UIKit
class BaseViewController: UIViewController {
    func intialnavigationBarAppearace(checkflag: Bool = true) {

          self.navigationController?.navigationBar.isHidden = false
          UINavigationBar.appearance().isTranslucent = false
//        let imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 150, height: 40))
//        imageView.contentMode = .scaleAspectFit

//           let image = UIImage(named: "githubicon")
//           imageView.image = image
        
        let label = UILabel()
        label.text = "Github"
        label.textAlignment = .left
//        self.navigationItem.titleView = label
        navigationController?.navigationBar.topItem?.title = "Github"
        navigationController?.navigationBar.prefersLargeTitles = true

          navigationController?.navigationBar.barTintColor = UIColor.white
      }
    
    func initializeNavigationBarAppearanceWithoutMenu(checkflag: Bool = true) {
        self.navigationController?.navigationBar.isHidden = false
        UINavigationBar.appearance().isTranslucent = false
        
        let orangetitlebtn = UIButton(type: .custom)
        orangetitlebtn.setTitleColor(UIColor.white, for: .normal)
        orangetitlebtn.titleLabel?.font = .boldSystemFont(ofSize: 16)
       
//        let iconimg = UIButton(type: .custom)
//
//        iconimg.setImage(UIImage(named: "group264"), for: .normal)
//
//        let buttonBarorange = UIBarButtonItem(customView: orangetitlebtn)
//        let iconorange = UIBarButtonItem(customView: iconimg)
//
//        buttonBarorange.isEnabled = false
//        iconorange.isEnabled = false
//
        
        
        let button = UIButton(type: .custom)

        button.addTarget(self, action: #selector(navigateBack), for: .touchUpInside)
//        let buttonBar = UIBarButtonItem(customView: button)
        
         
            
                button.setImage(UIImage(named: "icons8-ios-filled-50"), for: .normal)

//            self.navigationItem.setLeftBarButtonItems([iconorange,buttonBarorange], animated: true)
            
            orangetitlebtn.setTitle("Github", for: .normal)
       
        //        navigationController?.navigationBar.barTintColor = UIColor.clear
        // navigationController?.navigationBar.barTintColor = UIColor(red:26.0/255.0 green:184.0/255.0 blue:110.0/255.0 alpha:1.0)
        navigationController?.navigationBar.barTintColor = UIColor(white: 1.0, alpha: 1.0)
        //        if checkflag {
        //            checkStatus()
        //        }
        
    }
    
    @objc func navigateBack() {
        self.navigationController?.popViewController(animated: true)
    }
}
