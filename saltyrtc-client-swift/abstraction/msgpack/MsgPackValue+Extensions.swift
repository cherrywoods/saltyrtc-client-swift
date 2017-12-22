//
//  MsgPackerValue+Extensions.swift
//  saltyrtc-client-swift
//
//  Created by cherrywoods on 27.09.17.
//  Copyright © 2017 dadada. All rights reserved.
//

import MessagePack

extension MsgPackValue {
    
    var libValue: MessagePackValue {
        
        switch(self) {
            
        case .`nil`: return MessagePackValue.`nil`
        case .bool(let value): return MessagePackValue.bool(value)
        case .int(let value): return MessagePackValue.int(value)
        case .uint(let value): return MessagePackValue.uint(value)
        case .float(let value): return MessagePackValue.float(value)
        case .double(let value): return MessagePackValue.double(value)
        case .string(let value): return MessagePackValue.string(value)
        case .binary(let value): return MessagePackValue.binary(value)
        case .array(let value): return MessagePackValue.array(value)
        case .map(let value):
            var wrappedMap = Dictionary<MessagePackValue, MessagePackValue>(minimumCapacity: value.capacity)
            for (key, val) in value {
                wrappedMap[key.libValue] = val.libValue
            }
            return MessagePackValue.map( wrappedMap )
        case .extended(let value, let data): return MessagePackValue.extended(value, data)
            
        }
    }
    
}

extension MsgPackValue: Equatable {
    
    public static func ==(lhs: MsgPackValue, rhs: MsgPackValue) -> Bool {
        
        return lhs.libValue == rhs.libValue
        
    }
    
}

extension MsgPackValue: Hashable {
    
    public var hashValue: Int {
        
        return libValue.hashValue
        
    }
    
}
