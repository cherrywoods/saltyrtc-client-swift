//
//  Crypto.swift
//  saltyrtc-client-swift
//
//  Created by cherrywoods on 28.09.17.
//  Copyright © 2017 dadada. All rights reserved.
//

import Sodium

public class Crypto {
    
    private static let sodium = Sodium()
    
    // MARK: public key cryptografy
    public static let publicKeyBytes = sodium.box.PublicKeyBytes
    
    // MARK: secret key cryptografy
    public static let symetricKeyBytes = sodium.secretBox.KeyBytes
    
}
