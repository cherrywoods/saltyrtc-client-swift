//
//  Token.swift
//  saltyrtc-client-swift
//
//  Created by cherrywoods on 28.09.17.
//  Copyright © 2017 dadada. All rights reserved.
//

public class Token: Message {
    
    public static let type = "token"
    public var messageType: String {
        return Application.type
    }
    
    public let key: [UInt8]
    
    public init(key: [UInt8]) {
        
        self.key = key
        
    }
    
    /*
     Create a new Token-instance from a map containing at least the keys "type" and "reason".
     Throws: This initalizer will throw if the value for type is not equal to "token".
     */
    public convenience init(map: [String: Any]) throws {
        
        _ = try validateType(formatedValue: map[MsgKey.type], expectedType: Close.type)
        let key = try validateByteArray(formatedValue: map[MsgKey.key], expectedLength: Crypto.symetricKeyBytes)
        
        self.init(key: key)
        
    }
    
    /**
     Writes this Token Message to the given MsgPacker
     */
    public func write(toMsgPacker msgPacker: MsgPacker) throws {
        
        var toPack = Dictionary<MsgPackValue, MsgPackValue>(minimumCapacity: 2)
        
        toPack[MsgPackValue.string(MsgKey.type)] = MsgPackValue.string(Token.type)
        toPack[MsgPackValue.string(MsgKey.key)] = MsgPackValue.binary(Data(key))
        
        msgPacker.pack( MsgPackValue.map(toPack) )
        
    }
    
    
}
