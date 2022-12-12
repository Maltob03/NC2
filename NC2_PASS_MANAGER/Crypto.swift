//
//  Crypto.swift
//  NC2_PASS_MANAGER
//
//  Created by Matteo Altobello on 09/12/22.
//


import UIKit
import CryptoKit





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

func crypto (password: String) -> AES.GCM.SealedBox {
    let key = SymmetricKey(size: .bits256)
    let message = password.data(using: .utf8)!
    let sealedBox = try! AES.GCM.seal (message, using: key)
    return(sealedBox)
}


func decrypto (password: AES.GCM.SealedBox) -> String {
    let key = SymmetricKey(size: .bits256)
    let decryptedData = try? AES.GCM.open(password, using: key)
    let output = (String (data: decryptedData ?? Data(), encoding: .utf8) ?? "")
    return output
}


func prova (password: String) -> String {
    let key = SymmetricKey(size: .bits256)
    let message = password.data(using: .utf8)!
    let sealedBox = try! AES.GCM.seal (message, using: key)
    let decryptedData = try? AES.GCM.open(sealedBox, using: key)
    let output = (String (data: decryptedData ?? Data(), encoding: .utf8) ?? "")
    return output
}

