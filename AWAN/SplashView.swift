//
//  SplashView.swift
//  AWAN
//
//  Created by شذا on 29/02/1448 AH.
//
//
//  SplashView.swift
//  AWAN
//

import SwiftUI

// ════════════════════════════════════════════
// MARK: - ١) الجذر: الشعار فوق التطبيق
// ════════════════════════════════════════════

/// هذه هي الشاشة الأولى للتطبيق الآن.
///
/// الفكرة: التطبيق يُبنى تحت مباشرة، والشعار مجرد طبقة فوقه تختفي بعد
/// لحظة. هكذا لا ينتظر المستخدم شيئاً فعلياً — الانتقال يبدو فورياً.
struct RootView: View {

    @State private var showSplash = true

    /// كم يبقى الشعار على الشاشة (بالثواني)
    private let splashDuration = 1.5

    var body: some View {
        ZStack {

            // التطبيق: SwiftUIView تقرر بنفسها أونبوردنق أم MainTabView
            SwiftUIView()

            if showSplash {
                SplashView()
                    // الخروج: يكبر ويتلاشى — نفس أسلوب X
                    .transition(.scale(scale: 1.35).combined(with: .opacity))
                    .zIndex(10)
            }
        }
        .onAppear {
            DispatchQueue.main.asyncAfter(deadline: .now() + splashDuration) {
                withAnimation(.easeInOut(duration: 0.55)) {
                    showSplash = false
                }
            }
        }
    }
}


// ════════════════════════════════════════════
// MARK: - ٢) شاشة الشعار
// ════════════════════════════════════════════

struct SplashView: View {

    let mainBlue = Color(red: 96/255, green: 157/255, blue: 220/255)

    @State private var logoScale: CGFloat = 0.70
    @State private var logoOpacity: Double = 0
    @State private var logoBlur: CGFloat = 12
    @State private var haloScale: CGFloat = 0.75

    var body: some View {
        ZStack {

            // نفس خلفية التطبيق حتى لا يظهر أي وميض أبيض عند الاختفاء
            Image("back")
                .resizable()
                .scaledToFill()
                .ignoresSafeArea()

            ZStack {

                // هالة تتوسّع خلف الشعار
                Circle()
                    .fill(
                        RadialGradient(
                            colors: [mainBlue.opacity(0.22), .clear],
                            center: .center, startRadius: 10, endRadius: 150
                        )
                    )
                    .frame(width: 300, height: 300)
                    .scaleEffect(haloScale)
                    .opacity(logoOpacity)

                Text("أوَانْ")
                    .font(.system(size: 72, weight: .bold))
                    .foregroundStyle(mainBlue)
                    .scaleEffect(logoScale)
                    .opacity(logoOpacity)
                    // البدء بضبابية ثم وضوح = إحساس سينمائي بدل ظهور مسطح
                    .blur(radius: logoBlur)
            }
        }
        .onAppear {
            // نطّة الدخول
            withAnimation(.spring(response: 0.85, dampingFraction: 0.55)) {
                logoScale = 1
                logoOpacity = 1
                logoBlur = 0
            }
            // الهالة تتوسّع ببطء طوال مدة العرض
            withAnimation(.easeOut(duration: 1.4)) {
                haloScale = 1.15
            }
        }
    }
}


#Preview("Splash") {
    SplashView()
}

#Preview("Root") {
    RootView()
}
