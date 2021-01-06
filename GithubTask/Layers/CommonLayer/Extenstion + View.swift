//
//  Extenstion + View.swift
//  GithubTask
//
//  Created by Islam Abotaleb on 1/5/21.
//

import UIKit
public extension UIView {
public func round() {
    let width = bounds.width < bounds.height ? bounds.width : bounds.height
    let mask = CAShapeLayer()
    mask.path = UIBezierPath(ovalIn: CGRect(x: bounds.midX - width / 2, y: bounds.midY - width / 2, width: width, height: width)).cgPath
    self.layer.mask = mask
}
}
