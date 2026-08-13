//
//  SwiftUIView.swift
//  AWAN
//
//  صفحات البداية الثلاث + الانتقال للتطبيق، كلها في ملف واحد مستقل.
//  الصق هذا فوق محتوى SwiftUIView.swift بالكامل (⌘A ثم لصق).
//
//  لا يحتاج تعديل أي ملف آخر. يكفي أن يكون الجذر SwiftUIView().
//

import SwiftUI

// ════════════════════════════════════════════
// MARK: - ١) محتوى الصفحات — عدّلي هنا فقط
// ════════════════════════════════════════════

/// حجم الصورة في الصفحات الثلاث. رقم واحد يتحكم بالكل.
let onboardImageSize: CGFloat = 300

struct OnboardPage: Identifiable {
    let id = UUID()
    let image: String
    let title: String
    let subtitle: String
}

let onboardPages: [OnboardPage] = [

    OnboardPage(
        image: "OLD",
        title: "Never Miss\nYour Medication",
        subtitle: "We'll remind you at the right time so you never forget your medicine."
    ),

    OnboardPage(
        image: "OLD2",
        title: "Organize Your\nMedical Appointments",
        subtitle: "Keep all your medical appointments in one place for easy tracking."
    ),

    OnboardPage(
        image: "grand",
        title: "Welcome",
        subtitle: "We help you easily remember your medications and appointments."
    )
]


// ════════════════════════════════════════════
// MARK: - ٢) الشاشة
// ════════════════════════════════════════════

struct SwiftUIView: View {

    let mainBlue = Color(red: 96/255, green: 157/255, blue: 220/255)

    /// @AppStorage يحفظ القيمة على الجهاز، فتبقى بعد إغلاق التطبيق.
    /// النتيجة: الأونبوردنق يظهر مرة واحدة فقط.
    @AppStorage("didFinishOnboarding") private var didFinishOnboarding = false

    @State private var page = 0
    @State private var appeared = false
    @State private var breathing = false

    // ── الجسم: يقرر بنفسه أونبوردنق أم تطبيق ──
    // هذا يجعل الملف مستقلاً: لا يحتاج تعديل AWANApp.swift إطلاقاً.
    var body: some View {
        ZStack {
            if didFinishOnboarding {
                MainTabView()
                    .transition(.opacity)
            } else {
                onboarding
                    .transition(.opacity)
            }
        }
        .animation(.easeInOut(duration: 0.45), value: didFinishOnboarding)
    }


    // ════════════════════════════════════════
    // MARK: - ٣) الأونبوردنق
    // ════════════════════════════════════════

    var onboarding: some View {
        ZStack {

            // خلفية واحدة للتدفق كله، خارج الشريط المتحرك فلا تنزلق معه
            Image("back")
                .resizable()
                .scaledToFill()
                .ignoresSafeArea()

            // ── الشريط المتحرك: الصفحات الثلاث جنب بعض ──
            TabView(selection: $page) {
                ForEach(Array(onboardPages.enumerated()), id: \.element.id) { pair in
                    pageTemplate(pair.element)
                        .tag(pair.offset)
                }
            }
            .tabViewStyle(.page(indexDisplayMode: .never))
            .ignoresSafeArea()

            // ── الأزرار ──
            // zIndex(2) يضمن أنها فوق الشريط المتحرك وتستقبل الضغط،
            // فالـ TabView يلتقط الإيماءات وقد يبتلع الضغطات بدونها.
            VStack {
                skipButton
                Spacer()
                bottomControls
            }
            .zIndex(2)
        }
        .toolbar(.hidden, for: .navigationBar)
        .onAppear { startEntrance() }
    }


    /// تشغيل حركة الدخول.
    ///
    /// التأخير 0.15 مقصود: عند فتح التطبيق يُستدعى onAppear أحياناً قبل أن
    /// تُرسم الشاشة فعلياً، فتقفز القيمة من false إلى true بلا حركة مرئية.
    /// تأخير بسيط يضمن أن الحركة تبدأ بعد أول إطار.
    func startEntrance() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.15) {
            // withAnimation صريح أوثق من .animation(value:) هنا
            withAnimation(.spring(response: 0.85, dampingFraction: 0.6)) {
                appeared = true
            }
            withAnimation(.easeInOut(duration: 2.4).repeatForever(autoreverses: true)) {
                breathing = true
            }
        }
    }


    // ════════════════════════════════════════
    // MARK: - ٤) قالب الصفحة (ارتفاعات ثابتة = صفحات متطابقة)
    // ════════════════════════════════════════

    func pageTemplate(_ item: OnboardPage) -> some View {
        GeometryReader { geo in

            // بُعد الصفحة عن منتصف الشاشة:
            // ٠ = في المنتصف، ±١ = شاشة كاملة بعيداً
            let progress = geo.frame(in: .global).minX / UIScreen.main.bounds.width
            let distance = min(abs(progress), 1)

            VStack(spacing: 0) {

                logo
                    .frame(height: 100)
                    .padding(.top, 40)

                // حجم موحّد: العرض والارتفاع معاً.
                // .frame(height:) وحده لا يكفي، لأن العرض حينها يتحدد من
                // نسبة كل صورة فتبدو الصور بأحجام مختلفة.
                Image(item.image)
                    .resizable()
                    .scaledToFit()
                    .frame(width: onboardImageSize, height: onboardImageSize)
                    .frame(maxWidth: .infinity)

                Spacer(minLength: 0)

                Text(item.title)
                    .font(.system(size: 34, weight: .bold))
                    .foregroundStyle(mainBlue)
                    .multilineTextAlignment(.center)
                    .frame(height: 90)

                Text(item.subtitle)
                    .font(.system(size: 16))
                    .foregroundColor(.gray)
                    .multilineTextAlignment(.center)
                    .padding(.horizontal, 32)
                    .frame(height: 60)
                    .padding(.bottom, 165)
            }
            .frame(width: geo.size.width, height: geo.size.height)

            // إحساس الكاروسيل: الصفحة تتفاعل مع السحب لحظياً
            .scaleEffect(1 - distance * 0.10)
            .opacity(1 - distance * 0.55)
            .offset(x: -progress * 45)
            .blur(radius: distance * 3)
        }
    }


    // ════════════════════════════════════════
    // MARK: - ٥) الأزرار
    // ════════════════════════════════════════

    var skipButton: some View {
        HStack {
            Spacer()
            Button {
                finish()
            } label: {
                Text("Skip")
                    .font(.headline)
                    .foregroundColor(.gray)
                    .padding(14)
                    .contentShape(Rectangle())
            }
            .buttonStyle(.plain)
            .opacity(page == onboardPages.count - 1 ? 0 : 1)
            .disabled(page == onboardPages.count - 1)
            .animation(.easeInOut(duration: 0.25), value: page)
        }
        .padding(.horizontal, 14)
        .padding(.top, 8)
    }

    var bottomControls: some View {
        VStack(spacing: 16) {

            // ── النقاط: اضغطي أي واحدة للانتقال لصفحتها ──
            HStack(spacing: 8) {
                ForEach(onboardPages.indices, id: \.self) { i in
                    Button {
                        withAnimation(.timingCurve(0.22, 1, 0.36, 1, duration: 0.6)) {
                            page = i
                        }
                    } label: {
                        Capsule()
                            .fill(mainBlue.opacity(i == page ? 1 : 0.25))
                            .frame(width: i == page ? 28 : 9, height: 9)
                            // padding قبل contentShape = نقطة صغيرة
                            // بمساحة لمس كبيرة غير مرئية
                            .padding(10)
                            .contentShape(Rectangle())
                    }
                    .buttonStyle(.plain)
                }
            }
            .animation(.spring(response: 0.4, dampingFraction: 0.75), value: page)

            // ── Next / Get Started ──
            Button {
                if page < onboardPages.count - 1 {
                    withAnimation(.timingCurve(0.22, 1, 0.36, 1, duration: 0.6)) {
                        page += 1
                    }
                } else {
                    finish()
                }
            } label: {
                Text(page == onboardPages.count - 1 ? "Get Started" : "Next")
                    .font(.title2)
                    .fontWeight(.bold)
                    .foregroundColor(.white)
                    .frame(maxWidth: .infinity)
                    .frame(height: 55)
                    .background(mainBlue)
                    .cornerRadius(15)
                    .contentShape(Rectangle())
            }
            .buttonStyle(OnboardPressStyle())
            .padding(.horizontal, 30)
        }
        .padding(.bottom, 28)
    }


    // ════════════════════════════════════════
    // MARK: - ٦) اللوقو
    // ════════════════════════════════════════

    var logo: some View {
        ZStack {
            // هالة ناعمة تتنفس خلف الكلمة
            Circle()
                .fill(
                    RadialGradient(
                        colors: [mainBlue.opacity(0.20), .clear],
                        center: .center, startRadius: 5, endRadius: 100
                    )
                )
                .frame(width: 210, height: 210)
                .scaleEffect(breathing ? 1.12 : 0.92)
                .opacity(appeared ? 1 : 0)

            Text("أوَانْ")
                .font(.system(size: 60, weight: .bold))
                .foregroundStyle(mainBlue)
                // الدخول: يبدأ صغيراً ومموّهاً وشفافاً ثم ينط لحجمه.
                // الحركة نفسها تُشغَّل من startEntrance() بـ withAnimation.
                .scaleEffect(appeared ? 1 : 0.70)
                .opacity(appeared ? 1 : 0)
                .blur(radius: appeared ? 0 : 10)
                .offset(y: appeared ? 0 : 20)
        }
    }


    // ════════════════════════════════════════
    // MARK: - ٧) نهاية الأونبوردنق
    // ════════════════════════════════════════

    /// ينتقل للتطبيق (MainTabView) ولا يعود للأونبوردنق بعدها أبداً.
    func finish() {
        didFinishOnboarding = true
    }
}


/// الزر ينكمش قليلاً وقت الضغط.
struct OnboardPressStyle: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .scaleEffect(configuration.isPressed ? 0.96 : 1)
            .opacity(configuration.isPressed ? 0.9 : 1)
            .animation(.spring(response: 0.3, dampingFraction: 0.6),
                       value: configuration.isPressed)
    }
}


#Preview {
    SwiftUIView()
}
