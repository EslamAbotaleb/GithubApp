//
//  extension + resuable fortableview + collectionview.swift
//  GithubTask
//
//  Created by Islam Abotaleb on 1/5/21.
//

import Foundation
extension ReusableView {
    static var reuseIdentifier: String {
        return String(describing: self)
    }
}
