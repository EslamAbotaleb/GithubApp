//
//  UsersGithubController + TableView.swift
//  GithubTask
//
//  Created by Islam Abotaleb on 1/5/21.
//

import UIKit

extension UsersGithubControllerViewController: UITableViewDelegate, UITableViewDataSource {
  
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: DisplayUsersGithubTableViewCell.reuseIdentifier, for: indexPath) as? DisplayUsersGithubTableViewCell else {
            fatalError("Cannot found users github cell")
        }
        
        if viewModel?.numberOfRowsUsersByPagnation() == 0 {
            let usersGithubModel = self.usersGithubFromCoreDataModel[indexPath.row]
            cell.userName.text = usersGithubModel.username
            ImageService.downloadImage(withURL: URL(string: usersGithubModel.userimage)!) { (imageUser) in
                cell.avaterImg.image = imageUser
                
         }
            return cell

        } else {
            cell.configure(userGithub: (viewModel?.githubUsersList?[indexPath.row])!)
            return cell

        }
        
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
      
        if viewModel?.numberOfRowsUsersByPagnation() == 0 {
            return self.usersGithubFromCoreDataModel.count
        } else {
            return  viewModel?.numberOfRowsUsersByPagnation() ?? 0

        }
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let repoUserGithubController =  RepoUserGithubController.init(nibName: "RepoUserGithubView", bundle: nil)

        if viewModel?.numberOfRowsUsersByPagnation() == 0 {
            
            userName = (self.usersGithubFromCoreDataModel[indexPath.row]).username
            repoUserGithubController.delegate = self
    //        self.navigationController?.pushViewController(repoUserGithubController, animated: true)
            self.present(repoUserGithubController, animated: true, completion: nil)
//            appDelegate.window?.rootViewController = repoUserGithubController
            
        } else {
            userName = (viewModel?.githubUsersList?[indexPath.row])?.login
    //        let repoUserGithubController = RepoUserGithubController()
            
            
            repoUserGithubController.delegate = self
    //        self.navigationController?.pushViewController(repoUserGithubController, animated: true)
            self.present(repoUserGithubController, animated: true, completion: nil)
        }
        
       
    }
    
}
