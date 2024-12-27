import SwiftUI

struct RegistrationPage: View {
    @Binding var showLoginPage: Bool
    @State private var username: String = ""
    @State private var password: String = ""
    @State private var confirmPassword: String = ""
    @State private var showAlert: Bool = false
    @State private var alertMessage: String = ""

    var body: some View {
        NavigationView {
            ZStack(alignment: .center) {
                // 背景图片
                Image("logininterfacebackground")
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .edgesIgnoringSafeArea(.all)

                // 透明模糊的长方形框包裹注册表单
                RoundedRectangle(cornerRadius: 15.0)
                    .frame(width: UIScreen.main.bounds.width * 0.8, height: UIScreen.main.bounds.height * 0.48)
                    .foregroundColor(.orange1.opacity(0.5))
                    .blur(radius: 1)
                    .overlay(
                        VStack(spacing: 20) {
                            TextField("Username", text: $username)
                                .textFieldStyle(RoundedBorderTextFieldStyle())
                                .padding()
                            
                            SecureField("Password", text: $password)
                                .textFieldStyle(RoundedBorderTextFieldStyle())
                                .padding()
                            
                            SecureField("Confirm Password", text: $confirmPassword)
                                .textFieldStyle(RoundedBorderTextFieldStyle())
                                .padding()
                            
                            Button(action: {
                                self.registerUser(username: username, password: password)
                            }) {
                                Text("Register")
                                    .foregroundColor(.white)
                                    .font(.headline)
                                    .padding()
                            }
                            .frame(minWidth: 0, maxWidth: .infinity)
                            .background(Color.green)
                            .cornerRadius(10)
                            .padding([.horizontal, .top], 20)
                        }
                        .padding()
                    )
                    .padding([.leading, .trailing], 16)
                    .padding([.top, .bottom], 8)
            }
            .navigationBarHidden(true)
            .alert(isPresented: $showAlert) {
                Alert(title: Text(alertMessage), dismissButton: .default(Text("确定"), action: {
                    if alertMessage == "注册成功！" {
                        self.showLoginPage = true
                    }
                }))
            }
        }
    }

    func registerUser(username: String, password: String) {
        if password == confirmPassword, !username.isEmpty, !password.isEmpty {
            UserDefaults.standard.set(username, forKey: "username")
            UserDefaults.standard.set(password, forKey: "password")
            showAlert = true
            alertMessage = "注册成功！"
        } else {
            showAlert = true
            if password != confirmPassword {
                alertMessage = "密码和确认密码不一致。"
            } else {
                alertMessage = "注册失败。请确保用户名和密码不为空。"
            }
        }
    }
}

// 预览结构体
struct RegistrationPage_Previews: PreviewProvider {
    static var previews: some View {
        RegistrationPage(showLoginPage: .constant(false))
    }
}
