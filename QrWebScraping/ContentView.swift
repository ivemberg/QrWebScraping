//
//  ContentView.swift
//  QrWebScraping
//
//  Created by Ivo Junior Bettini on 24/06/22.
//

import SwiftUI
import SwiftSoup
import Foundation

struct ContentView: View {
    
    @State var titolo = ""
    @State var url = ""
    
    var body: some View {
        NavigationView{
            
            VStack{
                Button("Generate Link") {
                    let url = URL(string: "https://it.wikipedia.org/wiki/Speciale:PaginaCasuale")!
                    let html = try! String(contentsOf: url)
                    let document = try! SwiftSoup.parse(html)
                    titolo = try! document.title()
                    print(titolo)
                }.padding()
                
                Text(titolo).padding()
                Button("Generate QR") {
                    let newTitolo: () = getTitolo()
                    
                    NavigationLink("\(newTitolo)" .capitalized, destination: VStack{
                        Text("aaaa")
                        }
                    )
                    
                }.padding()
            }
        }
}
    
func getTitolo(){
        
        var i = 0
        while i < 11{
            titolo.removeLast()
            i+=1
        }
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
