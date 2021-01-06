//
//  UsersGithubControllerViewController.swift
//  GithubTask
//
//  Created by Islam Abotaleb on 1/5/21.
//

import UIKit

class UsersGithubControllerViewController: BaseViewController,GetUserNameProfileGithub {
    var userName: String?
    @IBOutlet weak var tableView: UITableView!
    var usersGithubFromCoreDataModel = [UsersGithubCoreData]()
    var setUsersGithubMode: UsersGithubCoreData?
    var viewModel: GithubViewModel?
    var isDataLoading: Bool = false
    var pageNumber: Int = 1
    var limitUsersEverypage: Int = 10
    let context = PersistanceService.shared.persistentContainer.viewContext
    let persistence = PersistanceService.shared
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.intialnavigationBarAppearace(checkflag: true)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        tableView.delegate = self
        tableView.dataSource = self
        viewModel = GithubViewModel()
        viewModel?.registTableViewCellSpesficUser(nibName: "DisplayUsersGithubTableViewCell", tableView: tableView)
        NotificationCenter.default.addObserver(forName: NSNotification.Name("PersistedDataUpdated"), object: nil, queue: .main) { (_) in
            
        }
        //MARK:- online
        if (InternetConnectionManager.isConnectedToNetwork()) {
            //MARK:- Get Users Github From Server
                viewModel?.getUsersFromGithub(since: pageNumber, per_page: 10, completionHandler: { (usersGithubResult) in
                    self.viewModel?.githubUsersList = usersGithubResult
                    
                    DispatchQueue.main.async {
                        self.tableView.reloadData()
                    }
                })
            self.viewModel?.saveUsersGithubFromServerIntoCoreData(since: self.pageNumber, per_Page: 10, tableView: self.tableView)

//            loadUsersFromCoreData()
        } else {
            //MARK:- offline
            loadUsersFromCoreData()
        }
       
        

    }
    
    //MARK:- Get Users Github from CoreData
    func loadUsersFromCoreData() {
            viewModel?.saveUsersGithubFromServerIntoCoreData(since: pageNumber, per_Page: 10, tableView: self.tableView)
            persistence.fetch(UsersGithubCoreData.self) { [weak self] (usersGithubModel) in
                self?.usersGithubFromCoreDataModel = usersGithubModel
                DispatchQueue.main.async {
                    self?.tableView.reloadData()
                }
            }
    }
   // MARK:- load more users from github
    
    func loadMoreUsersFromGithub() {
        self.pageNumber += 1
        //MARK:- Get Users Github From Server
        viewModel?.getUsersFromGithub(since: pageNumber, per_page: 10, completionHandler: { [weak self](users) in
            self?.viewModel?.githubUsersList?.append(contentsOf: users)
            DispatchQueue.main.async {
                self?.tableView.reloadData()
            }
        })
        
        //MARK:- Get Users Github from CoreData
        self.viewModel?.saveUsersGithubFromServerIntoCoreData(since: self.pageNumber, per_Page: 10, tableView: self.tableView)
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
