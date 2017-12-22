//
//  Errors.swift
//  saltyrtc-client-swift
//
//  Created by cherrywoods on 26.09.17.
//  Copyright © 2017 dadada. All rights reserved.
//

import Foundation

public enum ValidationError: Error {
    
    case missingKey(key: String)
    
    case invalidValue(requiredType: String)
    case invalidLengthOfValue(requiredLength: Int, actualLength: Int)
    case wrongType(requiredType: String)
    case invalidCloseCode(code: Int)
    
    case emptyTaskName
    case emptyTaskNames
    case invalidTaskDataLength(requiredLength: Int)
    case invalidTaskData(missingKey: String)
    
}
