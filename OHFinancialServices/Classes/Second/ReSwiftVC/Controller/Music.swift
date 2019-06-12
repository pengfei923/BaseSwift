//
//  Music.swift
//  DouYuSwift
//
//  Created by hoomsun on 2019/4/16.
//  Copyright © 2019 hoomsun. All rights reserved.
//

import UIKit

struct Music {
    let name : String
    let singer : String
    init(name : String, singer : String) {
        self.name = name
        self.singer = singer
    }
    
}

extension Music : CustomStringConvertible {
    var description: String {
        return "name:\(name) singer:\(singer)"
    }
}
