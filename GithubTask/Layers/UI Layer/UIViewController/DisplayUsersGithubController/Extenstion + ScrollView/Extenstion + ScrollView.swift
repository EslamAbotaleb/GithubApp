//
//  Extenstion + ScrollView.swift
//  GithubTask
//
//  Created by Islam Abotaleb on 1/5/21.
//

import UIKit
extension UsersGithubControllerViewController: UIScrollViewDelegate {
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        
        print("scrollViewWillBeginDragging")
        isDataLoading = false
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        print("scrollViewDidEndDecelerating")
    }
    //Pagination
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        if scrollView == tableView {
            print("scrollViewDidEndDragging")
            if ((tableView.contentOffset.y + tableView.frame.size.height) >= tableView.contentSize.height)
            {
                if !isDataLoading{
                    isDataLoading = true
                    
                    
                    let lastlabel = UILabel()
                    lastlabel.font = UIFont.systemFont(ofSize: 15.0)
                    
                    lastlabel.textAlignment = .center
                    
                    lastlabel.text = "Load More"
                    
                    lastlabel.textColor = UIColor.black
                    lastlabel.frame = CGRect(x: CGFloat(0), y: CGFloat(0), width: tableView.bounds.width, height: CGFloat(44))
                    self.tableView.tableFooterView = lastlabel
                    self.tableView.tableFooterView?.isHidden = false
                    
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
                        self.loadMoreUsersFromGithub()
                    }
                }
            }
        }
        
    }
}
