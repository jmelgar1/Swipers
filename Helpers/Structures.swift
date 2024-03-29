//
//  Structures.swift
//  Swipers
//
//  Created by Josh Melgar on 3/12/22.
//

import SwiftUI

struct RoundedCorner: Shape {
    var radius: CGFloat = .infinity
    var corners: UIRectCorner = .allCorners
    
    func path(in rect: CGRect) -> Path {
        let path = UIBezierPath(roundedRect: rect, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
        return Path(path.cgPath)
    }
}

struct CustomNavBar<Left, Right>: View where Left: View, Right: View {
    let left: () -> Left
    let right: () -> Right
    init(@ViewBuilder left: @escaping () -> Left, @ViewBuilder right: @escaping() -> Right){
        self.left = left
        self.right = right
    }
    var body: some View{
        ZStack{
            HStack{
                left()
                Spacer()
            }

            HStack{
                Spacer()
                right()
            }
        }
    }
}
