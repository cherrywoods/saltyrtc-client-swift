//
//  Message.swift
//  saltyrtc-client-swift
//
//  Created by cherrywoods on 26.09.17.
//  Copyright © 2017 dadada. All rights reserved.
//

import Foundation
import MessagePack

/**
 All messages sent through SaltyRTC conform to this protocol.
 */
public protocol Message {
    
    /**
     Its own message type.
     */
    var messageType: String {get}
    
    /**
     Return messagepacked data of itself
    */
    func write(toMsgPacker: MsgPacker ) throws
    
    var messageAsData: Data? { get }
    
}

// provides default implementations
public extension Message {
    
    /*
     Calls the write method with a new MsgPacker and returns the data value of this instance. Will retrun nil, if write throws a error
    */
    var messageAsData: Data? {
    
        do {
            
            let msgPacker = MsgPacker()
            try self.write(toMsgPacker: msgPacker)
            return msgPacker.data
            
        } catch {
            
            return nil
            
        }
        
    }
    
}
