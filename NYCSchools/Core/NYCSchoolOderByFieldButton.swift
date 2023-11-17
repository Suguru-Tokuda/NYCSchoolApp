//
//  NYCOderByFieldButton.swift
//  NYCSchools
//
//  Created by Suguru Tokuda on 11/16/23.
//

import UIKit

class NYCSchoolOderByFieldButton: UIButton {
    var orderByField: NYCSchoolSortKey = .schoolName

    override init(frame: CGRect) {
        super.init(frame: frame)

    }

    required init(coder aDecoder: NSCoder) {
        fatalError("This class does not support NSCoding")
    }
}
