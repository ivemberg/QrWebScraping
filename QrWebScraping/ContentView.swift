//
//  ContentView.swift
//  QrWebScraping
//
//  Created by Ivo Junior Bettini on 24/06/22.
//

import SwiftUI
import SwiftSoup
import Foundation
import UIKit
import WebKit

struct ContentView: View {
    
    @State var qrCode: Image = Image("")
    @State var tito = ""
    @State var newtito = ""
    
    
    var body: some View {
        
        Button("Generate Link") {
            let url = URL(string: "https://it.wikipedia.org/wiki/Speciale:PaginaCasuale")!
            let html = try! String(contentsOf: url)
            let document = try! SwiftSoup.parse(html)
            tito = try! document.title()
            
        }.padding()
        
        
        Text(tito).padding()
        
        
        qrCode
            .resizable()
            .scaledToFit()
            .aspectRatio(contentMode: .fit)
            .frame(width: 200, height: 200)
            .padding()
        
        
        
        Button("Genera QR Code") {
            newtito = getTitolo()
            qrCode = Image(uiImage: UIImage(data: getQRCodeDate(text: "https://it.wikipedia.org/wiki/\(newtito)")!)!)
            
        }
    }
    
    func getTitolo() -> String{
        
        var i = 0
        while i < 11{
            tito.removeLast()
            i+=1
        }
        
        return tito
        
    }
    
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

func getQRCodeDate(text: String) -> Data? {
    guard let filter = CIFilter(name: "CIQRCodeGenerator") else { return nil }
    let data = text.data(using: .ascii, allowLossyConversion: false)
    filter.setValue(data, forKey: "inputMessage")
    guard let ciimage = filter.outputImage else { return nil }
    let transform = CGAffineTransform(scaleX: 10, y: 10)
    let scaledCIImage = ciimage.transformed(by: transform)
    let uiimage = UIImage(ciImage: scaledCIImage)
    return uiimage.pngData()!
}
