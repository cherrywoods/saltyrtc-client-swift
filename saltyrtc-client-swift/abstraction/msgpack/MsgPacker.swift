//
//  MessagePacker.swift
//  saltyrtc-client-swift
//
//  Created by cherrywoods on 27.09.17.
//  Copyright © 2017 dadada. All rights reserved.
//

import MessagePack

/*
 This file specifies the only classes and enums and so on, that will directly use the MessagePack library. Any other class or whathever will relly on these classes
 */

public enum MsgPackValue {
    
    case `nil`
    case bool(Bool)
    case int(Int64)
    case uint(UInt64)
    case float(Float)
    case double(Double)
    case string(String)
    case binary(Data)
    case array([MessagePackValue])
    case map([MsgPackValue: MsgPackValue])
    case extended(Int8, Data)
    
}

/**
 This class provides a layer of abstraction to the used msgpack library.
 It imitates the functionality of the java's implementations class MessageBufferPacker
 */
public class MsgPacker {
    
    var data = Data()
    
    func pack(_ value: MsgPackValue) {
        
        data.append( MessagePack.pack(value.libValue) )
        
    }
    
}
