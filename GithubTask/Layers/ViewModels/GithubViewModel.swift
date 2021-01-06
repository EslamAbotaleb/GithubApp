//
//  GithubViewModel.swift
//  GithubTask
//
//  Created by Islam Abotaleb on 1/5/21.
//

import Foundation
import Moya

final class GithubViewModel {
    
    let githubUserService = MoyaProvider<GithubService>()
    var githubUsersList: [UsersModel]?
    var repoUserGithubList: [RepoUserGithubModel]?
    var usersGithubCoreDataModel = [UsersGithubCoreData]()
    var repoUserGithubCoreDataModel = [RepoUserGithub]()

    let networking = NetworkingService.shared
    let persistence = PersistanceService.shared

    //MARK:- Get Users by page number
    func getUsersFromGithub(since: Int, per_page: Int,
                            completionHandler: @escaping([UsersModel]) -> ()) {
        githubUserService.request(.getUsersGithubWithPagnation(since: since, per_page: per_page)) { [weak self] (resultUsersInGithub) in
            switch (resultUsersInGithub) {
            case .success(let response):
                DispatchQueue.main.async {
                    print(response.data)
                    let usersGithub = try! JSONDecoder().decode([UsersModel].self, from: response.data)
                    
                    if self?.githubUsersList != nil {
                        
                        self?.githubUsersList!.append(contentsOf: (self?.githubUsersList)!)
                    }  else {
                        self?.githubUsersList = usersGithub
                    }
                    completionHandler(usersGithub)
                }
                break
            case .failure(let error):
                print(error)
                break
            }
        }
    }
    //MARK:- Get repo user profile through userName
    func repoSpesficUserFromGithub(userName: String, completionHandler: @escaping([RepoUserGithubModel]) -> ()) {
        githubUserService.request(.getRepoUserGithubByUserName(userName: userName)) {
            [weak self] (repoUserGithub) in
            switch (repoUserGithub) {
            case .success(let response):
                DispatchQueue.main.async {
                    print(response.data)
                    let repoUserGithub = try! JSONDecoder().decode([RepoUserGithubModel].self, from: response.data)
                    if self?.repoUserGithubList != nil {
                        self?.repoUserGithubList?.append(contentsOf: (self?.repoUserGithubList)!)
                        
                    } else {
                        self?.repoUserGithubList = repoUserGithub
                    }
                    completionHandler(repoUserGithub)
                }
                break
            case .failure(let error):
                print(error)
                break
            }
        }
    }
    
    //MARK:- Save users github into coreData
    func saveUsersGithubFromServerIntoCoreData(since: Int, per_Page: Int, tableView: UITableView) {
        let urlPath = "https://api.github.com/users?since=\(since)&per_page=\(per_Page)"
        
        networking.request(urlPath) { (result) in
            
            switch result {
            case .success(let response):
                do {

                    guard let fetchUsersGithub = try JSONSerialization.jsonObject(with: response, options: []) as? [[String: Any]] else {
                        return
                    }

                                    let resultUsersGithubCoreDataModel: [UsersGithubCoreData] = fetchUsersGithub.compactMap {
                                        
                                        guard let login = $0["login"] as? String,
                                              let imageUser = $0["avatar_url"] as? String
                                        else {return nil}

                                        let usersModel = UsersGithubCoreData(context: self.persistence.context)
                                        usersModel.username = login
                                        usersModel.userimage = imageUser
                                        return usersModel
                                    }

                                    self.usersGithubCoreDataModel = resultUsersGithubCoreDataModel
                                    DispatchQueue.main.async {
                                        self.persistence.save()
//                                        tableView.reloadData()
                                    }

                } catch {
                    print(error)
                }
                
            case .failure(let error):
                print(error.localizedDescription)
                
            }
        }
    }
    
    //MARK:- get repo user github from coredata
    
    func retreiveRepoUserGithubFromCoreData(userName: String, tableView: UITableView) {
        
        
        let urlPath = "https://api.github.com/users/\(userName)/repos"
        networking.request(urlPath) {
            (result) in
            switch result {
            case .success(let response):
                do {
                    guard let fetchrepoUserGithub = try JSONSerialization.jsonObject(with: response, options: []) as? [[String: Any]] else {
                        return
                    }
                    let repoUserGithubCoreDataModel: [RepoUserGithub] =
                        fetchrepoUserGithub.compactMap {
                            guard let reponame = $0["name"] as? String,
                                  let forks_count = $0["forks_count"] as? Int16,
                                  let createDate = $0["created_at"] as? String,
                                  let description = $0["description"] as? String
                                  else {
                                return nil
                            }
                            let reposUserGithubObject = RepoUserGithub(context: self.persistence.context)
                            reposUserGithubObject.reponame = reponame
                            reposUserGithubObject.forkcount = forks_count
                            reposUserGithubObject.createdate = createDate
                            reposUserGithubObject.descriptionrepo = description
                            return reposUserGithubObject
                        }
                    self.repoUserGithubCoreDataModel = repoUserGithubCoreDataModel
                    DispatchQueue.main.async {
                        self.persistence.save()
                    }
                } catch {
                    print(error)
                }
                break
            case .failure(let error):
                print(error)
                break
            }
        }
    }
    func numberOfRowsUsersByPagnation() -> Int {
        return self.githubUsersList?.count ?? 0
    }
    
    func registTableViewCellSpesficUser(nibName name: String, tableView: UITableView) {
        let nib = UINib(nibName: name, bundle: nil)
        
        tableView.register(nib, forCellReuseIdentifier: DisplayUsersGithubTableViewCell.reuseIdentifier)
    }
    
    func numbesOfRowSpesficRepoUserAfterSelectedThisUser() -> Int {
        return self.repoUserGithubList?.count ?? 0
    }
    
    func registTableViewCellSpesficRepoUserGithub(nibName name: String, tableView: UITableView) {
        let nib = UINib(nibName: name, bundle: nil)
        
        tableView.register(nib, forCellReuseIdentifier: RepoProfileUserTableViewCell.reuseIdentifier)
    }
}
