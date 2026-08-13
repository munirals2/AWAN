//
//  PageTransition.swift
//  AWAN
//
//  A native-feeling page transition, plus animated page dots.
//  Written once here, used by every onboarding screen.
//

import SwiftUI

// ════════════════════════════════════════════
// MARK: - The transition
// ════════════════════════════════════════════

/// What makes a transition feel professional is that the two pages
/// do NOT move the same amount.
///
/// The incoming page travels the full screen width.
/// The outgoing page travels only ~30% and shrinks and blurs slightly,
/// so it reads as "sliding back into the distance" instead of being shoved away.
/// This depth difference is called parallax, and it is exactly what iOS
/// itself does when you push a screen.
///
/// Transition is the iOS 17 protocol for building your own transitions.
struct PageSlide: Transition {

    /// how far it travels, as a fraction of the screen width
    var travel: CGFloat
    /// how much it shrinks while off-screen
    var scale: CGFloat
    /// softness while off-screen
    var blur: CGFloat
    /// dark veil over the page while off-screen (adds depth)
    var dim: CGFloat

    func body(content: Content, phase: TransitionPhase) -> some View {
        // phase.value is -1 before appearing, 0 on screen, +1 after leaving.
        // Multiplying by -1 makes new pages come from the right
        // and old pages leave to the left.
        content
            .offset(x: -phase.value * UIScreen.main.bounds.width * travel)
            .scaleEffect(phase.isIdentity ? 1 : scale)
            .opacity(phase.isIdentity ? 1 : 0)
            .blur(radius: phase.isIdentity ? 0 : blur)
            .overlay(
                Color.black
                    .opacity(phase.isIdentity ? 0 : dim)
                    .ignoresSafeArea()
                    .allowsHitTesting(false)
            )
    }
}

extension AnyTransition {

    /// moving forward: next page comes from the right
    static var pageForward: AnyTransition {
        .asymmetric(
            insertion: AnyTransition(PageSlide(travel: 1.00, scale: 0.96, blur: 0, dim: 0)),
            removal:   AnyTransition(PageSlide(travel: 0.30, scale: 0.92, blur: 5, dim: 0.18))
        )
    }
}

extension Animation {

    /// The curve Apple uses for navigation pushes: fast at first, then it
    /// glides to a stop. Much more expensive-feeling than .easeInOut.
    /// Numbers are a cubic-bezier (this one is known as "easeOutQuint").
    static var page: Animation {
        .timingCurve(0.22, 1.0, 0.36, 1.0, duration: 0.62)
    }

    /// Softer spring for small UI details (dots, buttons)
    static var snappy: Animation {
        .spring(response: 0.45, dampingFraction: 0.78)
    }
}


// ════════════════════════════════════════════
// MARK: - Equal page sizes
// ════════════════════════════════════════════

extension View {

    /// Forces a page to fill the whole screen.
    ///
    /// Why this matters for the transition:
    /// by default every page is only as big as its content, so a short page
    /// and a tall page have different heights. During the transition the
    /// ZStack keeps resizing itself between the two, and the pages appear to
    /// jump or shift vertically instead of sliding cleanly.
    ///
    /// Giving both pages the exact same frame removes the jump completely.
    func fullPage() -> some View {
        self
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .ignoresSafeArea()
    }
}


// ════════════════════════════════════════════
// MARK: - Animated page dots
// ════════════════════════════════════════════

/// The active dot stretches into a capsule instead of just changing colour.
/// Small detail, big difference in how finished the app feels.
struct PageDots: View {
    let count: Int
    let index: Int
    var color: Color = .blue

    var body: some View {
        HStack(spacing: 8){
            ForEach(0..<count, id: \.self){ i in
                Capsule()
                    .fill(color.opacity(i == index ? 1 : 0.25))
                    .frame(width: i == index ? 26 : 9, height: 9)
            }
        }
        .animation(.snappy, value: index)
    }
}


#Preview {
    VStack(spacing: 40){
        PageDots(count: 3, index: 0)
        PageDots(count: 3, index: 1)
        PageDots(count: 3, index: 2)
    }
}
