//
//  Key.swift
//  saltyrtc-client-swift
//
//  Created by cherrywoods on 28.09.17.
//  Copyright © 2017 dadada. All rights reserved.
//

public class Key: Message {
    
    public static let type = "key"
    public var messageType: String {
        return Application.type
    }
    
    public let key: [UInt8]
    
    public init(key: [UInt8]) {
        
        self.key = key
        
    }
    
    public convenience required init(map: [String : Any]) throws {
        
        _ = try validateType(formatedValue: map[MsgKey.type], expectedType: Key.type)
        
        let key = try validateByteArray(formatedValue: map[MsgKey.key], expectedLength: Crypto.publicKeyBytes)
        
        self.init(key: key)
        
    }
    
    /**
     Writes this Key Message to the given MsgPacker
     */
    public func write(toMsgPacker msgPacker: MsgPacker) throws {
        
        var toPack = Dictionary<MsgPackValue, MsgPackValue>(minimumCapacity: 2)
        
        toPack[MsgPackValue.string(MsgKey.type)] = MsgPackValue.string(Key.type)
        toPack[MsgPackValue.string(MsgKey.key)] = MsgPackValue.binary(Data(bytes: key))
        
        msgPacker.pack( MsgPackValue.map(toPack) )
        
    }
    
}
