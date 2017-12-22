//
//  Close.swift
//  saltyrtc-client-swift
//
//  Created by cherrywoods on 27.09.17.
//  Copyright © 2017 dadada. All rights reserved.
//

/**
 Close message.
 */
public class Close: Message {
    
    public static let type = "close"
    public var messageType: String {
        return Application.type
    }
    
    public let reason: Int
    
    public init(reason: Int) {
        
        self.reason = reason
        
    }
    
    /*
     Create a new Close-instance from a map containing at least the keys "type" and "reason".
     Throws: This initalizer will throw if the value for type is not equal to "close".
     */
    public convenience required init(map: [String: Any]) throws {
        
        _ = try validateType(formatedValue: map[MsgKey.type], expectedType: Close.type)
        self.init(reason: try validateCloseCode(formatedValue: map[MsgKey.reason], dropResponder: false))
        
    }
    
    /**
     Writes this Close Message to the given MsgPacker
     */
    public func write(toMsgPacker msgPacker: MsgPacker) throws {
        
        var toPack = Dictionary<MsgPackValue, MsgPackValue>(minimumCapacity: 2)
        
        toPack[MsgPackValue.string(MsgKey.type)] = MsgPackValue.string(Close.type)
        toPack[MsgPackValue.string(MsgKey.reason)] = MsgPackValue.int(Int64(reason))
        
        msgPacker.pack( MsgPackValue.map(toPack) )
        
    }
    
}
