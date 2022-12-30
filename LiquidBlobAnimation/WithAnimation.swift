//
//  WithAnimation.swift
//  LiquidBlobAnimation
//
//  Created by Ahmed on 17/12/22.
//

import SwiftUI

struct WithAnimation: View {
    
    @State private var animate: Bool = false
    
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
        Canvas { context, size in
            
            let circle0 = context.resolveSymbol(id: 0)!
            let circle1 = context.resolveSymbol(id: 1)!
            
            context.addFilter(.alphaThreshold(min: 0.5, color: .black))
            context.addFilter(.blur(radius: 15))
            
       
            
            context.drawLayer { ctx in
                ctx.draw(circle0, at: CGPoint(x: initialX, y: initialY))
                ctx.draw(circle1, at: CGPoint(x: initialX, y: initialY))
            }
            
            
        } symbols: {
            Circle()
                .frame(width: circleDiameter, height: circleDiameter)
                .offset(x: animate ? 70 : 0)
                .tag(0)
            Circle()
                .frame(width: circleDiameter, height: circleDiameter)
                .offset(x: animate ? -70 : 0)
                .tag(1)
        }
        .animation(.easeInOut(duration: 3).repeatForever(autoreverses: true), value: animate)
        .ignoresSafeArea(.all)
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .task {
            animate = true
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        WithAnimation()
    }
}
