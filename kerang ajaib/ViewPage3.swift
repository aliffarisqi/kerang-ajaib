//
//  ViewPage3.swift
//  kerang ajaib
//
//  Created by Bayu Alif Farisqi on 20/03/23.
//

import SwiftUI

struct ViewPage3: View {
    
    var body: some View {
            ZStack{
                Rectangle()
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                    .overlay(content: {
                    Image("Ocean")
                            .resizable()
                            .scaledToFill()
                    })
                    .clipped()
                    .padding(0)
                    .edgesIgnoringSafeArea(.all)
                
                ViewFlower()
                
                VStack{
                    Spacer(minLength: 100)
                    Image("TextLogo")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 170)
                    Image("Logo")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 250)
                    Spacer()
                    ZStack{
                        Rectangle()
                            .fill(
                                Color.white.opacity(0.5)
                            )
                            .frame(maxWidth: .infinity, minHeight: 400)
                            .cornerRadius(50)
                            .edgesIgnoringSafeArea(.all)
                            
                        VStack{
                            Spacer()
                            Rectangle()
                                .fill(
                                    Color.white
                                )
                                .frame(width: 320, height: 200)
                                .cornerRadius(25)
                            Spacer()
                                Image(systemName: "mic.fill")
                                    .font(.largeTitle)
                                    .foregroundColor(Color.blue)
                                    .padding(20)
                                    .background(
                                        Color.white.opacity(0.4)
                                            .cornerRadius(50)
                                    )
                            Spacer()
                        }
                        .padding()
                    }
                }
            }
    }
}

struct ViewPage3_Previews: PreviewProvider {
    static var previews: some View {
        ViewPage3()
    }
}
