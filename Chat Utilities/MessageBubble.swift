//
//  MessageBubble.swift
//  Swipers
//
//  Created by Josh Melgar on 3/2/22.
//

import SwiftUI

struct MessageBubble: View {
    var message: Message
    @State private var showTime = false
    
    var body: some View {
        VStack(alignment: message.received ? .leading : .trailing){
            HStack {
                Text(message.text).padding().background(message.received ? Color("GrayColor") : Color("LightBlueColor")).cornerRadius(30)
            }
            .frame(maxWidth: 300, alignment: message.received ? .leading : .trailing).onTapGesture {
                showTime.toggle()
            }
            
            if showTime {
                Text("\(message.timestamp.formatted(.dateTime.hour().minute()))").font(.caption2).foregroundColor(.gray).padding(message.received ? .leading : .trailing, 25)
            }
        }
        .frame(maxWidth: .infinity, alignment: message.received ? .leading : .trailing).padding(message.received ? .leading : .trailing).padding(.horizontal, 10)
    }
}

struct MessageBubble_Previews: PreviewProvider {
    static var previews: some View {
        MessageBubble(message: Message(id: "12345", text: "Test Message 1", received: true, timestamp: Date()))
    }
}
