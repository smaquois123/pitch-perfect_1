//
//  RecordedAudio.swift
//  PitchPerfect
//
//  Created by JC Smith on 2/18/15.
//  Copyright (c) 2015 JC Smith. All rights reserved.
//

import Foundation

class RecordedAudio: NSObject{
    var filePathUrl: NSURL!
    var title: String!
    
    init(filePathUrl: NSURL, title: String) {
        super.init()
        self.filePathUrl = filePathUrl
        self.title = title
    }
    
}
