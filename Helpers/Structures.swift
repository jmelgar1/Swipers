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

struct CustomNavBar<Left, Center, Right>: View where Left: View, Center: View, Right: View {
    let left: () -> Left
    let center: () -> Center
    let right: () -> Right
    init(@ViewBuilder left: @escaping () -> Left, @ViewBuilder center: @escaping () -> Center, @ViewBuilder right: @escaping() -> Right){
        self.left = left
        self.center = center
        self.right = right
    }
    var body: some View{
        ZStack{
            HStack{
                left()
                Spacer()
            }
            center()
            HStack{
                Spacer()
                right()
            }
        }
    }
}
