//
//  TitleRow.swift
//  Swipers
//
//  Created by Josh Melgar on 3/2/22.
//

import SwiftUI

struct TitleRow: View {
    @EnvironmentObject private var text: TitleRowData
    
    //other user imageurl
    var imageUrl = URL(string: "https://images.unsplash.com/photo-1544005313-94ddf0286df2?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=688&q=80")
    
    var body: some View {
        HStack(spacing: 20){
            AsyncImage(url: imageUrl) { image in
                image.resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: 50, height: 50)
                    .cornerRadius(50)
            } placeholder: {
                ProgressView()
            }
            
            VStack(alignment: .leading){
                Text(text.sellerFullName).font(.title).bold()
                
                Text("Online").font(.caption).foregroundColor(.gray)
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            
            Image(systemName: "phone.fill").foregroundColor(.gray).padding(10).background(.white).cornerRadius(50)
        }
        .padding()
    }
}

struct TitleRow_Previews: PreviewProvider {
    static var previews: some View {
        TitleRow().background(Color("LightBlueColor"))
    }
}

class TitleRowData: ObservableObject {
    @Published var sellerFullName: String  = ""
}
