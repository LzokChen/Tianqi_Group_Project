//
//  LottieView.swift
//  ClimaWeather
//
//  Created by Mingyu Liu on 2022-08-11.
//
import SwiftUI
import Lottie
 
struct LottieView: UIViewRepresentable {
    let lottieFile: String//传入JSON文件的名称
 
    let animationView = AnimationView()
 
    func makeUIView(context: UIViewRepresentableContext<LottieView>) -> some UIView {
        let view = UIView(frame: .zero)
        animationView.animation = Animation.named(lottieFile)
        animationView.contentMode = .scaleAspectFit
        animationView.loopMode = .loop

        animationView.play()
 
        view.addSubview(animationView)
 
        animationView.translatesAutoresizingMaskIntoConstraints = false
        animationView.heightAnchor.constraint(equalTo: view.heightAnchor).isActive = true
        animationView.widthAnchor.constraint(equalTo: view.widthAnchor).isActive = true
 
        return view
    }
 
    func updateUIView(_ uiView: UIViewType, context: UIViewRepresentableContext<LottieView>) {
        uiView.subviews.forEach({ sub in
                    sub.removeFromSuperview()
                })
            
        animationView.translatesAutoresizingMaskIntoConstraints = false
        uiView.addSubview(animationView)

        NSLayoutConstraint.activate([
            animationView.widthAnchor.constraint(equalTo: uiView.widthAnchor),
            animationView.heightAnchor.constraint(equalTo: uiView.heightAnchor)
        ])

        animationView.animation = Animation.named(lottieFile)
        animationView.contentMode = .scaleAspectFit
        animationView.loopMode = .loop
        animationView.play()
    }
    
    
}
