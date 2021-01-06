//
//  RepoProfileUserTableView + Extenstion.swift
//  GithubTask
//
//  Created by Islam Abotaleb on 1/5/21.
//

import UIKit

extension RepoUserGithubController: UITableViewDelegate, UITableViewDataSource {
   
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: RepoProfileUserTableViewCell.reuseIdentifier, for: indexPath) as? RepoProfileUserTableViewCell else {
            fatalError("not found cell repo user")
        }
        if self.viewModel?.numbesOfRowSpesficRepoUserAfterSelectedThisUser() == 0 {
            cell.repoNameLabel.text = self.repoUserGithubCoreDataModel[indexPath.row].reponame
            cell.forksCountLabel.text = "\(self.repoUserGithubCoreDataModel[indexPath.row].forkcount)"

            cell.descriptionRepoLabel.text = self.repoUserGithubCoreDataModel[indexPath.row].descriptionrepo
        } else {
            cell.configure(repoUserGithub: (viewModel?.repoUserGithubList?[indexPath.row])!)
        }
       
        return cell
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if self.viewModel?.numbesOfRowSpesficRepoUserAfterSelectedThisUser() == 0 {
            return self.repoUserGithubCoreDataModel.count
        } else {
            return
                self.viewModel?.numbesOfRowSpesficRepoUserAfterSelectedThisUser() ?? 0
        }
       
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // this will open Safri
        if let url = URL(string: ((self.viewModel?.repoUserGithubList?[indexPath.row])?.htmlURL!)!+""+((self.viewModel?.repoUserGithubList?[indexPath.row])?.name)!) {
        UIApplication.shared.open(url)
        }

    }
}
