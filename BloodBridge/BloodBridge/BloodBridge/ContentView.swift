import SwiftUI

struct ContentView: View {
    @State private var isSignUp = false
    @State private var fullName = ""
    @State private var email = ""
    @State private var password = ""
    @State private var showPassword = false

    @State private var alertTitle = ""
    @State private var alertMessage = ""
    @State private var showAlert = false

    private let gold = Color(
        red: 0.78, green: 0.57, blue: 0.32
    )

    private let backgroundColor = Color(
        red: 0.025, green: 0.03, blue: 0.035
    )

    var body: some View {
        ZStack {
            backgroundColor
                .ignoresSafeArea()

            ScrollView(showsIndicators: false) {
                VStack(spacing: 0) {
                    header

                    BloodBridgeHero(gold: gold)
                        .frame(height: 250)
                        .padding(.top, 12)

                    introduction
                        .padding(.top, 4)

                    authenticationForm
                        .padding(.top, 26)

                    footer
                        .padding(.top, 28)
                        .padding(.bottom, 30)
                }
                .padding(.horizontal, 24)
                .frame(maxWidth: 480)
                .frame(maxWidth: .infinity)
            }
        }
        .preferredColorScheme(.dark)
        .alert(alertTitle, isPresented: $showAlert) {
            Button("OK", role: .cancel) { }
        } message: {
            Text(alertMessage)
        }
    }

    // MARK: - Header

    private var header: some View {
        HStack(spacing: 12) {
            ZStack {
                Circle()
                    .stroke(gold.opacity(0.8), lineWidth: 1.5)
                    .frame(width: 46, height: 46)

                Image(systemName: "drop.fill")
                    .font(.system(size: 25))
                    .foregroundStyle(
                        LinearGradient(
                            colors: [gold, Color.red.opacity(0.85)],
                            startPoint: .topLeading,
                            endPoint: .bottomTrailing
                        )
                    )

                Image(systemName: "cross.fill")
                    .font(.system(size: 8, weight: .bold))
                    .foregroundStyle(.white)
            }

            VStack(alignment: .leading, spacing: 2) {
                HStack(spacing: 0) {
                    Text("Blood")
                        .foregroundStyle(.white)

                    Text("Bridge")
                        .foregroundStyle(gold)
                }
                .font(.system(size: 22, weight: .medium))

                Text("P R O J E C T S")
                    .font(.system(size: 9, weight: .medium))
                    .tracking(3.2)
                    .foregroundStyle(.white.opacity(0.65))
            }

            Spacer()

            Text("SAVE LIVES")
                .font(.system(size: 9, weight: .medium))
                .tracking(1.5)
                .foregroundStyle(gold)
        }
        .padding(.top, 18)
        .accessibilityElement(children: .combine)
        .accessibilityLabel("BloodBridge Projects")
    }

    // MARK: - Introduction

    private var introduction: some View {
        VStack(alignment: .leading, spacing: 12) {
            Text("TOGETHER WE SAVE LIVES")
                .font(.system(size: 10, weight: .semibold))
                .tracking(3)
                .foregroundStyle(gold)

            (
                Text("Connecting\nDonors to ")
                    .foregroundStyle(Color.white)
                +
                Text("Life")
                    .foregroundStyle(gold)
            )
            .font(.system(size: 38, weight: .regular))
            .minimumScaleFactor(0.75)
            .lineSpacing(1)
            .fixedSize(horizontal: false, vertical: true)

            Text(
                "Connecting compassionate donors with people " +
                "who need blood, when it matters most."
            )
            .font(.system(size: 14))
            .foregroundStyle(.white.opacity(0.68))
            .lineSpacing(5)
            .fixedSize(horizontal: false, vertical: true)
        }
        .frame(maxWidth: .infinity, alignment: .leading)
    }

    // MARK: - Login and Sign Up

    private var authenticationForm: some View {
        VStack(spacing: 18) {
            HStack(spacing: 28) {
                modeButton(title: "Login", selected: !isSignUp) {
                    isSignUp = false
                }

                modeButton(title: "Sign Up", selected: isSignUp) {
                    isSignUp = true
                }

                Spacer()
            }

            if isSignUp {
                inputField(
                    icon: "person",
                    placeholder: "Full name",
                    text: $fullName,
                    isSecure: false
                )
            }

            inputField(
                icon: "envelope",
                placeholder: "Email address",
                text: $email,
                isSecure: false
            )
            .textInputAutocapitalization(.never)
            .keyboardType(.emailAddress)
            .textContentType(.emailAddress)
            .autocorrectionDisabled()

            HStack(spacing: 12) {
                Image(systemName: "lock")
                    .foregroundStyle(gold.opacity(0.9))
                    .frame(width: 20)

                Group {
                    if showPassword {
                        TextField("Password", text: $password)
                    } else {
                        SecureField("Password", text: $password)
                    }
                }
                .textContentType(
                    isSignUp ? .newPassword : .password
                )
                .textInputAutocapitalization(.never)
                .autocorrectionDisabled()

                Button {
                    showPassword.toggle()
                } label: {
                    Image(
                        systemName: showPassword
                            ? "eye"
                            : "eye.slash"
                    )
                    .foregroundStyle(.white.opacity(0.6))
                }
                .accessibilityLabel(
                    showPassword ? "Hide password" : "Show password"
                )
            }
            .padding(.horizontal, 16)
            .frame(height: 54)
            .background(Color.white.opacity(0.025))
            .clipShape(RoundedRectangle(cornerRadius: 13))
            .overlay {
                RoundedRectangle(cornerRadius: 13)
                    .stroke(Color.white.opacity(0.12), lineWidth: 1)
            }

            if !isSignUp {
                HStack {
                    Spacer()

                    Button("Forgot your password?") {
                        presentAlert(
                            title: "Password Recovery",
                            message: "Password recovery will be available " +
                            "when authentication is connected."
                        )
                    }
                    .font(.system(size: 12))
                    .foregroundStyle(gold)
                }
            }

            Button {
                validateForm()
            } label: {
                HStack(spacing: 12) {
                    Spacer()

                    Text(isSignUp ? "Create Account" : "Login")
                        .font(.system(size: 15, weight: .semibold))

                    Image(systemName: "arrow.right")
                        .font(.system(size: 13, weight: .semibold))

                    Spacer()
                }
                .foregroundStyle(Color.black)
                .frame(height: 54)
                .background(
                    LinearGradient(
                        colors: [
                            Color(red: 0.86, green: 0.66, blue: 0.43),
                            gold
                        ],
                        startPoint: .leading,
                        endPoint: .trailing
                    )
                )
                .clipShape(RoundedRectangle(cornerRadius: 13))
            }
            .buttonStyle(.plain)

            HStack(spacing: 12) {
                Rectangle()
                    .fill(Color.white.opacity(0.12))
                    .frame(height: 1)

                Text("OR")
                    .font(.system(size: 10))
                    .foregroundStyle(.white.opacity(0.5))

                Rectangle()
                    .fill(Color.white.opacity(0.12))
                    .frame(height: 1)
            }

            Button {
                presentAlert(
                    title: "Google Sign-In",
                    message: "Google authentication has not been " +
                    "configured yet. No account has been signed in."
                )
            } label: {
                HStack(spacing: 12) {
                    Text("G")
                        .font(.system(size: 19, weight: .bold))
                        .foregroundStyle(.white)

                    Text("Continue with Google")
                        .font(.system(size: 14))
                        .foregroundStyle(.white.opacity(0.85))
                }
                .frame(maxWidth: .infinity)
                .frame(height: 52)
                .background(Color.clear)
                .overlay {
                    RoundedRectangle(cornerRadius: 13)
                        .stroke(
                            Color.white.opacity(0.22),
                            lineWidth: 1
                        )
                }
            }
            .buttonStyle(.plain)
        }
    }

    // MARK: - Reusable Components

    private func modeButton(
        title: String,
        selected: Bool,
        action: @escaping () -> Void
    ) -> some View {
        Button(action: action) {
            VStack(spacing: 9) {
                Text(title)
                    .font(.system(size: 14, weight: selected ? .semibold : .regular))
                    .foregroundStyle(
                        selected ? gold : Color.white.opacity(0.5)
                    )

                Rectangle()
                    .fill(selected ? gold : Color.clear)
                    .frame(height: 2)
            }
            .fixedSize(horizontal: true, vertical: false)
        }
        .buttonStyle(.plain)
    }

    private func inputField(
        icon: String,
        placeholder: String,
        text: Binding<String>,
        isSecure: Bool
    ) -> some View {
        HStack(spacing: 12) {
            Image(systemName: icon)
                .foregroundStyle(gold.opacity(0.9))
                .frame(width: 20)

            TextField(placeholder, text: text)
                .textFieldStyle(.plain)
        }
        .padding(.horizontal, 16)
        .frame(height: 54)
        .background(Color.white.opacity(0.025))
        .clipShape(RoundedRectangle(cornerRadius: 13))
        .overlay {
            RoundedRectangle(cornerRadius: 13)
                .stroke(Color.white.opacity(0.12), lineWidth: 1)
        }
    }

    private var footer: some View {
        VStack(spacing: 8) {
            Text("REAL PEOPLE  /  REAL DONATIONS  /  REAL IMPACT")
                .font(.system(size: 9, weight: .medium))
                .tracking(1.1)
                .foregroundStyle(gold.opacity(0.8))
                .multilineTextAlignment(.center)

            Text("Every drop can make a difference.")
                .font(.system(size: 12))
                .foregroundStyle(.white.opacity(0.45))
        }
        .frame(maxWidth: .infinity)
    }

    // MARK: - Form Validation

    private func validateForm() {
        let trimmedEmail = email.trimmingCharacters(
            in: .whitespacesAndNewlines
        )

        guard !trimmedEmail.isEmpty, !password.isEmpty else {
            presentAlert(
                title: "Missing Information",
                message: "Please enter your email address and password."
            )
            return
        }

        guard trimmedEmail.contains("@"),
              trimmedEmail.contains(".") else {
            presentAlert(
                title: "Invalid Email",
                message: "Please enter a valid email address."
            )
            return
        }

        if isSignUp && fullName.trimmingCharacters(
            in: .whitespacesAndNewlines
        ).isEmpty {
            presentAlert(
                title: "Missing Name",
                message: "Please enter your full name."
            )
            return
        }

        if password.count < 8 {
            presentAlert(
                title: "Password Too Short",
                message: "Please use at least 8 characters."
            )
            return
        }

        presentAlert(
            title: isSignUp ? "Setup Required" : "Authentication Required",
            message: "The form is working, but real account creation " +
            "and login require a secure authentication service. " +
            "No account has been created and you have not been signed in."
        )
    }

    private func presentAlert(title: String, message: String) {
        alertTitle = title
        alertMessage = message
        showAlert = true
    }
}

// MARK: - Blood Drop and Bridge Illustration

struct BloodBridgeHero: View {
    let gold: Color

    var body: some View {
        GeometryReader { geometry in
            let width = geometry.size.width
            let height = geometry.size.height

            ZStack {
                // Atmospheric background
                Ellipse()
                    .fill(Color.red.opacity(0.09))
                    .frame(width: width * 0.75, height: height * 0.65)
                    .blur(radius: 45)
                    .offset(x: width * 0.1, y: -height * 0.05)

                // Distant landscape
                Path { path in
                    path.move(to: CGPoint(x: 0, y: height * 0.69))
                    path.addLine(to: CGPoint(x: width * 0.18, y: height * 0.53))
                    path.addLine(to: CGPoint(x: width * 0.32, y: height * 0.65))
                    path.addLine(to: CGPoint(x: width * 0.50, y: height * 0.48))
                    path.addLine(to: CGPoint(x: width * 0.70, y: height * 0.63))
                    path.addLine(to: CGPoint(x: width, y: height * 0.50))
                    path.addLine(to: CGPoint(x: width, y: height))
                    path.addLine(to: CGPoint(x: 0, y: height))
                    path.closeSubpath()
                }
                .fill(Color(red: 0.07, green: 0.055, blue: 0.06))

                // Bridge deck
                Path { path in
                    path.move(to: CGPoint(x: 0, y: height * 0.76))
                    path.addQuadCurve(
                        to: CGPoint(x: width, y: height * 0.76),
                        control: CGPoint(x: width * 0.5, y: height * 0.53)
                    )
                }
                .stroke(gold.opacity(0.95), lineWidth: 2)
                .shadow(color: gold.opacity(0.7), radius: 8)

                // Bridge arch
                Path { path in
                    path.move(to: CGPoint(x: width * 0.12, y: height * 0.77))
                    path.addQuadCurve(
                        to: CGPoint(x: width * 0.88, y: height * 0.77),
                        control: CGPoint(x: width * 0.5, y: height * 1.14)
                    )
                }
                .stroke(
                    LinearGradient(
                        colors: [gold.opacity(0.3), gold, gold.opacity(0.3)],
                        startPoint: .leading,
                        endPoint: .trailing
                    ),
                    lineWidth: 2.5
                )
                .shadow(color: gold.opacity(0.45), radius: 5)

                // Water reflections
                ForEach(0..<5, id: \.self) { index in
                    Capsule()
                        .fill(
                            index == 2
                            ? Color.red.opacity(0.65)
                            : gold.opacity(0.24)
                        )
                        .frame(
                            width: width * (0.15 + CGFloat(index % 3) * 0.08),
                            height: 1
                        )
                        .offset(
                            x: CGFloat(index - 2) * 17,
                            y: height * 0.84 + CGFloat(index) * 8
                        )
                }

                // Glowing blood drop
                BloodDropShape()
                    .fill(
                        LinearGradient(
                            colors: [
                                Color(red: 0.38, green: 0.015, blue: 0.025),
                                Color(red: 0.9, green: 0.035, blue: 0.045),
                                Color(red: 0.24, green: 0.005, blue: 0.015)
                            ],
                            startPoint: .topLeading,
                            endPoint: .bottomTrailing
                        )
                    )
                    .frame(width: width * 0.34, height: height * 0.65)
                    .overlay {
                        BloodDropShape()
                            .stroke(
                                LinearGradient(
                                    colors: [
                                        Color.red,
                                        Color(red: 1, green: 0.45, blue: 0.35),
                                        Color.red.opacity(0.6)
                                    ],
                                    startPoint: .top,
                                    endPoint: .bottom
                                ),
                                lineWidth: 2
                            )
                            .frame(
                                width: width * 0.34,
                                height: height * 0.65
                            )
                    }
                    .shadow(color: .red.opacity(0.65), radius: 18)
                    .offset(y: -height * 0.12)

                // People inside the drop
                VStack(spacing: 0) {
                    Image(systemName: "person.fill")
                        .font(.system(size: 35))
                    HStack(spacing: 2) {
                        Image(systemName: "person.fill")
                        Image(systemName: "person.fill")
                        Image(systemName: "person.fill")
                    }
                    .font(.system(size: 12))
                }
                .foregroundStyle(Color.red.opacity(0.8))
                .shadow(color: .red, radius: 8)
                .offset(y: -height * 0.13)

                // Highlight
                Capsule()
                    .fill(Color.white.opacity(0.7))
                    .frame(width: 3, height: height * 0.18)
                    .blur(radius: 1)
                    .rotationEffect(.degrees(22))
                    .offset(x: -width * 0.095, y: -height * 0.28)
            }
            .frame(width: width, height: height)
            .clipped()
        }
        .accessibilityElement(children: .ignore)
        .accessibilityLabel(
            "A glowing red blood drop above a golden bridge at night"
        )
    }
}

struct BloodDropShape: Shape {
    func path(in rect: CGRect) -> Path {
        var path = Path()

        path.move(to: CGPoint(x: rect.midX, y: rect.minY))

        path.addCurve(
            to: CGPoint(x: rect.midX, y: rect.maxY),
            control1: CGPoint(x: rect.maxX * 1.08, y: rect.height * 0.40),
            control2: CGPoint(x: rect.maxX * 0.86, y: rect.height * 0.83)
        )

        path.addCurve(
            to: CGPoint(x: rect.midX, y: rect.minY),
            control1: CGPoint(x: rect.minX + rect.width * 0.14, y: rect.height * 0.83),
            control2: CGPoint(x: rect.minX - rect.width * 0.08, y: rect.height * 0.40)
        )

        path.closeSubpath()
        return path
    }
}

#Preview {
    ContentView()
}