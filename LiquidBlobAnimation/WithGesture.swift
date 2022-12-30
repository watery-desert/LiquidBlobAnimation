//
//  WithGesture.swift
//  LiquidBlobAnimation
//
//  Created by Ahmed on 17/12/22.
//

import SwiftUI

struct WithGesture: View {
    @State private var offset = CGSize.zero
    private let circleDiameter = 90.0
    private let deviceWidth = UIScreen.main.bounds.width
    private let deviceHeight = UIScreen.main.bounds.height
    
    private var initialX: Double {
        deviceWidth/2.0
    }
    
    private var initialY: Double {
        deviceHeight/2.0
    }
    
    var body: some View {
        ZStack {
            Canvas { context, size in
                
                let circle0 = context.resolveSymbol(id: 0)!
                let circle1 = context.resolveSymbol(id: 1)!
                
                context.addFilter(.alphaThreshold(min: 0.5, color: .green))
                context.addFilter(.blur(radius: 15))
                
           
                
                context.drawLayer { ctx in
                    ctx.draw(circle0, at: CGPoint(x: initialX, y: initialY))
                    ctx.draw(circle1, at: CGPoint(x: initialX, y: initialY))
                }
                
                
            } symbols: {
                Circle()
                    .frame(width: circleDiameter, height: circleDiameter)
                    .tag(0)
                Circle()
                    .frame(width: circleDiameter, height: circleDiameter)
                    .offset(x: offset.width, y: offset.height)
                    .tag(1)
            }
            .gesture(
                DragGesture()
                    .onChanged { value in
                        offset = value.translation
                    }
                    .onEnded { value in
                        withAnimation(.spring(response: 0.6, dampingFraction: 0.6)) {
                            offset = .zero
                        }
                    }
            )
            
//            Circle()
//                .stroke(lineWidth: 1.0)
//                .foregroundColor(.red)
//                .frame(width: circleDiameter, height: circleDiameter)
//
//            Circle()
//                .stroke(lineWidth: 1.0)
//                .foregroundColor(.red)
//                .frame(width: circleDiameter, height: circleDiameter)
//                .offset(x: offset.width, y: offset.height)
            
        }
        
        .ignoresSafeArea(.all)
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        
    }
}

struct WithGesture_Previews: PreviewProvider {
    static var previews: some View {
        WithGesture()
    }
}
