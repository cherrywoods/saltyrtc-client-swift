//
//  CloseCode.swift
//  saltyrtc-client-swift
//
//  Created by cherrywoods on 27.09.17.
//  Copyright © 2017 dadada. All rights reserved.
//

public struct CloseCode {
    
    /**
     WebSocket close codes
     */
    public enum Code: Int {
        
        /**
         Normal closing of websocket.
         */
        case closingNormal = 1000
        
        /**
         The endpoint is going away.
         */
        case goingAway = 1001
        
        /**
         No shared sub-protocol could be found.
         */
        case noSharedSubprotocol = 1002
        
        /**
         No free responder byte.
         */
        case pathFull = 3000
        
        /**
         Invalid message, invalid path length, ...
         */
        case protocolError = 3001
        
        /**
         Syntax error, ...
         */
        case internalError = 3002
        
        /**
         Handover of the signaling channel.
         */
        case handover = 3003
        
        /**
         Dropped by initiator.
         
         For an initiator, that means that another initiator has connected to the path.
         
         For a responder, it means that an initiator requested to drop the responder.
         */
        case droppedByInitiator = 3004
        
        /**
         Initiator could not decrypt a message.
         */
        case initiatorCouldNotDecrypt = 3005
        
        /**
         No shared task was found.
         */
        case noSharedTask = 3006
        
        /**
         Invalid key.
         */
        case invalidKey = 3007
        
        /**
         Explain the close code.
         */
        func explain() -> String {
            
            switch (self) {
                
            case .closingNormal: return "Normal closing"
            case .goingAway: return "The endpoint is going away"
            case .noSharedSubprotocol: return "No shared subprotocol could be found"
            case .pathFull: return "No free responder byte"
            case .protocolError: return "Protocol error"
            case .internalError: return "Internal error"
            case .handover: return "Handover finished"
            case .droppedByInitiator: return "Dropped by initiator"
            case .initiatorCouldNotDecrypt: return "Initiator could not decrypt a message"
            case .noSharedTask: return "No shared task was found"
            case .invalidKey: return "Invalid key"
                
            }
            
        }
        
    }
    
    /**
     Valid close codes for drop-responder messages.
     */
    public static let closeCodesDropResponder: [Code] = [ .protocolError, .internalError, .droppedByInitiator, .initiatorCouldNotDecrypt ]
    
    /**
     All valid close codes.
     */
    public static let closeCodesAll: [Code] = [ .goingAway, .noSharedSubprotocol, .pathFull, .protocolError, .internalError, .handover, .droppedByInitiator, .initiatorCouldNotDecrypt, .noSharedTask, .invalidKey ]
    
}
