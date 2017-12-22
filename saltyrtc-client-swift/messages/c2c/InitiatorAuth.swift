//
//  InitiatorAuth.swift
//  saltyrtc-client-swift
//
//  Created by cherrywoods on 27.09.17.
//  Copyright © 2017 dadada. All rights reserved.
//

/**
 Initiator authentification message.
 */
public class InitiatorAuth: Message {
    
    public static let type = "auth"
    public var messageType: String {
        return Application.type
    }
    
    public let yourCookie: [UInt8]
    public let task: String
    public let data: [String : [AnyHashable : Any]?]
    
    /**
     Creates a new InitiatorAuth
     Throws: ValidationsErrors
     - .emptyTaskName, if task is empty
     - .invalidTaskDataLength, if data does not contain exactly one element
     - .invalidTaskData, if the data dictionary contains no key for the task name you gave
     */
    public init(yourCookie: [UInt8], task: String, data: [String : [AnyHashable : Any]?]) throws {
        
        guard !task.isEmpty else {
            throw ValidationError.emptyTaskName
        }
        guard data.count == 1 else {
            throw ValidationError.invalidTaskDataLength(requiredLength: 1)
        }
        guard data.keys.contains(task) else {
            throw ValidationError.invalidTaskData(missingKey: task)
        }
        
        self.yourCookie = yourCookie
        self.task = task
        self.data = data
        
    }
    
    /*
     Creates a new InitiatorAuth-instance from a map containing at least the keys "type" and "reason".
     Throws: ValidationErrors:
     - .invalidValue, if one of the values in map for the keys "type", "data", "your_cookie" and "task" does not conform to the assumed type
     - .wrongType, if the value for "type" is not equal to "auth"
     - .invalidLengthOfValue, if the value for "your_cookie" is not of length 16
     - .emptyTaskName, if the value for "task" is empty
     - .invalidTaskDataLength, if the value for "data" does not contain exactly one element
     - .invalidTaskData, if the value for "data" contains no key for the value for "task"
     */
    public convenience required init(map: [String : Any]) throws {
        
        _ = try validateType(formatedValue: map[MsgKey.type], expectedType: InitiatorAuth.type)
        
        let cookieLenght = 16
        let yourCookie = try validateByteArray(formatedValue: map[MsgKey.yourCookie], expectedLength: cookieLenght)
        let task = try validateString(formatedValue: map[MsgKey.task])
        let data = try validateDictionaryOfStringsAndDictionarys(formatedValue: map[MsgKey.data])
        
        try self.init(yourCookie: yourCookie, task: task, data: data)
        
    }
    
    /**
     Writes this InitiatorAuth Message to the given MsgPacker
     Currently under construction!
     */
    public func write(toMsgPacker msgPacker: MsgPacker) throws {
        
        var toPack = Dictionary<MsgPackValue, MsgPackValue>(minimumCapacity: 4)
        
        toPack[MsgPackValue.string(MsgKey.type)] = MsgPackValue.string(InitiatorAuth.type)
        toPack[MsgPackValue.string(MsgKey.yourCookie)] = MsgPackValue.binary(Data(bytes: yourCookie) )
        toPack[MsgPackValue.string(MsgKey.task)] = MsgPackValue.string(task)
        // TODO: wait for generic implementation for non MsgPackValue values!!! (see Application)
        toPack[MsgPackValue.string(MsgKey.data)] = MsgPackValue.map([:])
        
        msgPacker.pack( MsgPackValue.map(toPack) )
        
    }
    
}
