//
//  SplashViewController.swift
//  GithubTask
//
//  Created by Islam Abotaleb on 1/5/21.
//

import UIKit

class SplashViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        DispatchQueue.main.asyncAfter(deadline: .now() + 4.0) {
            let marvelViewController = UsersGithubControllerViewController.init(nibName: "DisplayUsersGithub", bundle: nil)
            let navigationController = UINavigationController(rootViewController: marvelViewController)
            navigationController.modalPresentationStyle = .fullScreen
            appDelegate.window?.rootViewController = navigationController
        }
    }


    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

