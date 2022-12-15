//
//  crypto.swift
//  PasswordManager
//
//  Created by Matteo Altobello on 13/12/22.
//

import Foundation

import UIKit
import CryptoKit

/*
struct Generatekey {
    static let shared = Generatekey()
    let data = "guy"
    
    private init(){}
    
    func generateKey () ->SymmetricKey {
        let key = SymmetricKey(size: .bits256)
        return key
    }

}

*/




class Singleton {
    static let shared = SymmetricKey(size: .bits256)
  
  private init() {}
}

func generateKey () ->SymmetricKey {
    let key = SymmetricKey(size: .bits256)
    return key
}


func hash (password: String) -> String {
    let string = password
    let data = Data(string.utf8)
    let digest = SHA256.hash(data: data)
    let hash = digest.compactMap { String(format: "%02x", $0) }.joined()
    
    
    
    
    /*let outputString = hash.replacingOccurrences(of: "[^\\s]",
                              with: "#",
                           options: .regularExpression,
                             range: hash.startIndex..<hash.endIndex)
     */
    
    return(hash)
}

func crypto (password: String, key: SymmetricKey) -> String {
    let message = password.data(using: .utf8)!
    let encrypted = try! AES.GCM.seal (message, using: key)
    return encrypted.combined!.base64EncodedString()
}


func decrypto (password: String, key: SymmetricKey) -> String {
    do {
        guard let data = Data(base64Encoded: password) else {
            return "Could not decode text: \(password)"
        }
        
        let sealedBox = try AES.GCM.SealedBox(combined: data)
        let decryptedData = try AES.GCM.open(sealedBox, using: key)
        
        guard let text = String(data: decryptedData, encoding: .utf8) else {
            return "Could not decode data: \(decryptedData)"
        }
        
        return text
    } catch let error {
        return "Error decrypting message: \(error.localizedDescription)"
    }
}


func prova (password: String) -> String {
    let key = SymmetricKey(size: .bits256)
    let message = password.data(using: .utf8)!
    let sealedBox = try! AES.GCM.seal (message, using: key)
    let decryptedData = try? AES.GCM.open(sealedBox, using: key)
    let output = (String (data: decryptedData ?? Data(), encoding: .utf8) ?? "")
    return output
}


