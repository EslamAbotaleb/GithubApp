//
//  Users + CoreDataProperties.swift
//  GithubTask
//
//  Created by Islam Abotaleb on 1/6/21.
//

import Foundation
import CoreData
extension UsersGithubCoreData {
    @nonobjc public class func fetchRequest() -> NSFetchRequest<UsersGithubCoreData> {
        return NSFetchRequest<UsersGithubCoreData>(entityName: "UsersGithubCoreData")
    }
    @NSManaged public var username: String?
    @NSManaged public var userimage: String
}
