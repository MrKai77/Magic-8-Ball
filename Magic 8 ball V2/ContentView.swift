//
//  ContentView.swift
//  Magic 8 ball V2
//
//  Created by Kai Azim on 2021-05-07.
//

import SwiftUI
import Combine

let messagePublisher = PassthroughSubject<Int, Never>()

extension UIWindow {
    open override func motionEnded(_ motion: UIEvent.EventSubtype, with event: UIEvent?) {
        if (motion == .motionShake) {
            let randomNum = Int.random(in: 0...19)
            messagePublisher.send(randomNum)
        }   //detect if the phone shaked
    }
}

struct ContentView: View {
    
    @State private var isRotated = false
    @State var FinalChoice = "Waiting..."
    
    var body: some View {
        GeometryReader { geometry in
            ZStack {
                Rectangle()
                    .ignoresSafeArea()
                    .foregroundColor(.black)
                VStack {
                    
                    Path { p in
                       p.addLines([
                        CGPoint(x: geometry.size.width/2, y: geometry.size.height/2-70), //point a
                        CGPoint(x: geometry.size.width/2+100, y: geometry.size.height/2+100), //point b
                        CGPoint(x: geometry.size.width/2-100, y: geometry.size.height/2+100) //point c
                    ])} //the triangle
                    .foregroundColor(Color("AccentColor"))
                    .overlay (
                        VStack {
                            Spacer()
                                .frame(height: 60)
                            Text(self.FinalChoice)
                                .foregroundColor(Color.white)
                                .multilineTextAlignment(.center)
                                .onReceive(messagePublisher)
                                {randomNum in switch randomNum {
                            case 0:
                                FinalChoice = "As I see it, \nyes."
                                break
                            case 1:
                                FinalChoice = "Ask again \nlater."
                                break
                            case 2:
                                FinalChoice = "Better not \ntell you now."
                                break
                            case 3:
                                FinalChoice = "Cannot \npredict now."
                                break
                            case 4:
                                FinalChoice = "Concentrate \nand ask again."
                                break
                            case 5:
                                FinalChoice = "Don’t count \non it."
                                break
                            case 6:
                                FinalChoice = "It is certain."
                                break
                            case 7:
                                FinalChoice = "It is \ndecidedly so."
                                break
                            case 8:
                                FinalChoice = "Most likely."
                                break
                            case 9:
                                FinalChoice = "My reply \nis no."
                                break
                            case 10:
                                FinalChoice = "My sources \nsay no."
                                break
                            case 11:
                                FinalChoice = "Outlook not \nso good."
                                break
                            case 12:
                                FinalChoice = "Outlook \ngood."
                                break
                            case 13:
                                FinalChoice = "Reply hazy, \ntry again."
                                break
                            case 14:
                                FinalChoice = "Signs point \nto yes."
                                break
                            case 15:
                                FinalChoice = "Very \ndoubtful."
                                break
                            case 16:
                                FinalChoice = "Without \na doubt."
                                break
                            case 17:
                                FinalChoice = "Yes."
                                break
                            case 18:
                                FinalChoice = "Yes - \ndefinitely."
                                break
                            case 19:
                                FinalChoice = "You may \nrely on it."
                                break
                            default:
                                FinalChoice = "Waiting..."
                                break
                            }
                            self.isRotated.toggle()
                            }
                        }
                    )   //the text inside the triangle
                        
                    .rotation3DEffect(Angle.degrees(isRotated ? 1080 : 0), axis: (x: 1, y: 1, z: 1))    //this gives the triangle a 3D rotation effect
                    .animation(.easeOut(duration: 1))
                }
                .animation(.spring())
            }
        }
        .ignoresSafeArea()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
