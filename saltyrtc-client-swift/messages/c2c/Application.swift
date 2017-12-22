//
//  Application.swift
//  saltyrtc-client-swift
//
//  Created by cherrywoods on 26.09.17.
//  Copyright © 2017 dadada. All rights reserved.
//

/**
 Application message.

 This class is still under construction
 
 This message type SHOULD actually take arbitrary data, but that's currently not what it does.
 Currently you may only give Swift-Foundation objects (e.g. Dictionarys). These will be encoded to json and then encoded to psgpack. This means you will get a msgpack dictionary, with the keys "type" and "data". The value for "type" will be "application", but "data" will contain a further dictionary of keys and values of value encoded in JSON(!).
 */
public class Application: Message {
    
    public static let type = "application"
    public var messageType: String {
        return Application.type
    }
    
    public let value: Any
    
    /**
     Init with data
    */
    public init(withValue value: Any) {
        
        self.value = value
        
    }
    
    /*
     Create a new Application-instance from a map containing at least the keys "type" and "data". This initalizer will throw if the value for type is not equal to the specified messageType.
     */
    public convenience init(map: [String: Any]) throws {
        
        _ = try validateType(formatedValue: map[MsgKey.type], expectedType: Application.type)
        
        // check for presence of data and call initalizer
        guard let value: Any = map[MsgKey.data] else {
            
            throw ValidationError.missingKey(key: MsgKey.data)
            
        }
        
        self.init(withValue: value)
        
    }
    
    /**
     This method does not what it should.
     
     */
    public func write(toMsgPacker msgPacker: MsgPacker) throws {
        
        var toPack = Dictionary<MsgPackValue, MsgPackValue>()
        
        // TODO: reimplement this
        // this ain't the right implementation! The java implementation possibly does something comepletly diffrent
        // because it uses it's MessagePacks, MessagePackFactory, it (maybe) does not convert to json
        // furthermore swifts JSONSerialization unly supports swift Foundation objects... this is maybe not realy what we want, but I need to dig deeper into the java implementation.
        
        toPack[ MsgPackValue.string(MsgKey.type) ] = MsgPackValue.string(Application.type)
        // TODO: check for this! is this realy identical to the java implementation?
        let jsonData = try JSONSerialization.data(withJSONObject: value)
        toPack[ MsgPackValue.string(MsgKey.data) ] = MsgPackValue.binary(jsonData)
        
        msgPacker.pack( MsgPackValue.map(toPack) )
        
    }
    
}
