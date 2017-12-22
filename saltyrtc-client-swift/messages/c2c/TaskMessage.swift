//
//  TaskMessage.swift
//  saltyrtc-client-swift
//
//  Created by cherrywoods on 28.09.17.
//  Copyright © 2017 dadada. All rights reserved.
//

public class TaskMessage: Message {
    
    public let messageType: String
    
    public let data: [String : Any]
    
    public init(messageType type: String, otherData data: [String:Any]) {
        
        self.messageType = type
        self.data = data
        
    }
    
    /**
     Writes this Close Message to the given MsgPacker
     */
    public func write(toMsgPacker msgPacker: MsgPacker) throws {
        
        // TODO: this implementaion requires more generic msgpack librarys
        
    }
    
}
