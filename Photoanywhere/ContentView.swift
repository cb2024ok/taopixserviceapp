//
//  ContentView.swift
//  SecondApp
//
//  Created by baby Enjhon on 2020/06/18.
//  Copyright © 2020 baby Enjhon. All rights reserved.
//

import SwiftUI
import Reachability

let lightGreyColor = Color(red: 239.0/255.0, green: 243.0/255.0, blue: 244.0/255.0, opacity: 1.0)

// MARK: -- Welcome View --
struct WelcomeText: View {
    var body: some View {
        Text("Welcome")
        .font(.largeTitle)
        .fontWeight(.semibold)
        .padding(.bottom, 20)
    }
}

// MARK: UserImage View --
struct UserImage: View {
    var body: some View {
        Image("peace")
                   .resizable()
                    .aspectRatio(contentMode: .fill)
                   .frame(width: 150, height: 150)
                   //.clipped()
                   //.cornerRadius(150)
                    .padding(.bottom, 75)
    }
}

// MARK: LoginButton Content
struct LoginButtonContent: View {
    var body: some View {
        Text("Login")
                       .font(.headline)
                       .foregroundColor(.white)
                   .padding()
                   .frame(width: 220, height: 60)
                       .background(Color.green)
                       .cornerRadius(15.0)
    }
}

// MARK: -- UsernameTextField --
struct UsernameTextField: View {
    @Binding var username: String
    var body: some View {
        return TextField("이름", text: $username)
        .padding()
        .background(lightGreyColor)
            .cornerRadius(5.0)
            .padding(.bottom, 20)
    }
}


// MARK: -- PasswordSecureField --
struct PasswordSecureField: View {
    @Binding var password: String
    var body: some View {
        return SecureField("Password", text: $password)
        .padding()
        .background(lightGreyColor)
            .cornerRadius(5.0)
            .padding(.bottom, 20)
    }
}

// MARK: -- 사용자 신규등록 버튼뷰 --
struct SignupUserButton: View {
     @State var isOpen = false
       
         var body: some View {
          
              
               Button(action: {
                   print("Floating Button!~~")
                   self.isOpen.toggle()
               }) {
                   NavigationLink(destination: EmptyView()) {
                       Text("SignUP")
                        .padding()
                        .background(
                        RoundedRectangle(cornerRadius: 10)
                            .stroke(lineWidth: 2)
                     )
                   }
               }.sheet(isPresented: self.$isOpen) {
                   RegAccount()
           }
        }
}

// MARK: -- LoginView --
struct LoginView: View {
      @State var username: String = ""
      @State var password: String = ""
      @State private var showAlert = false
    
      @ObservedObject var LoginCheck = LoginAPI()
      
      //@ObservedObject var keyboardResponder = KeyboardResponder()
    
      // Environment Object define
      @EnvironmentObject var settings: UserSettings
    
      @State var isError: Bool = false
      @State var errorReason: String
    
     // 네트워크 연결속성을 정의
     @State var NotConnected: Bool = false // 기본은 연결되지 않은 상태
    @ObservedObject var netconnVM = ConnectionManager.sharedInstance
      
      var body: some View {
        
        // MARK: -- Login
          ZStack {
            
              VStack {
                  WelcomeText()
                  // UserImage()
                  UsernameTextField(username: $username)
                  PasswordSecureField(password: $password)
                  // 인증 실패시 Sign
                  Button(action: {
                    
                        if self.username == "" {
                            self.isError = true
                            self.errorReason = "사용자 ID를 입력해 주세요!!"
                        }
                        else if self.password == "" {
                            self.isError = true
                            self.errorReason = "사용자 Password를 입력해 주세요!!"
                        } else {
                            self.login(userid: self.username, userpass: self.password)
                        }
                
                    
                  }) {
                      LoginButtonContent()
                  }
                  .alert(isPresented: $isError, content: {
                                   Alert(title: Text("Error"), message: Text(self.errorReason), dismissButton: .default(Text("OK")))
                  })
                  SignupUserButton()
                .padding()
                  // 회원가입을 위한 기능을 추가
                   .onReceive(self.LoginCheck.LoginPublisher) { login in
                    
                        if login.Code == 200 {
                            self.settings.Usertoken = login.Token //token
                            self.settings.loggedIn = true
                            self.settings.UserID = self.username
                            self.showAlert = true
                            self.isError = false
                            print("Expired Date: \(login.Expire)")
                            
                            // 로그인에 성공하면 영구히 세션 및 사용자 ID정보를 저장
                            // 한번 로그인에 성공하면 저장된 세션을 재사용한다.
                            UserDefaults.standard.set(login.Token, forKey: "token")
                            UserDefaults.standard.set(self.username, forKey: "userid")
                            UserDefaults.standard.set(login.Expire, forKey: "expired")
                    
                            
                        } else {
                            self.isError = true
                            self.errorReason = "로그인 인증에 실패 하였습니다."
                      }
                }
                // case Network Issue
                .onReceive(self.netconnVM.NetConnPublisher, perform: { connstatus in
                    print("Network Status: \(connstatus)")
                    if !connstatus {
                       self.NotConnected = true
                    }
                })
                .alert(isPresented: self.$NotConnected, content: {
                    Alert(title: Text("네트워크 연결 비정상"), message: Text("네트워크 연결에 문제가 있습니다\n네트워크 확인후 사용해 주세요"), dismissButton: .default(Text("OK")))
                })
                
              }
            .padding()
            }
            
      .background(Image("peace")
      .resizable()
      .aspectRatio(contentMode: .fill)
      .clipped())
      .edgesIgnoringSafeArea(.all)
       //   .offset(y: -keyboardResponder.currentHeight * 0.9)
      }
    
    // MARK: -- Notification 이벤트 --
    private func reachabilityChanged(notification: NSNotification) {
           guard let reachability = notification.object as? Reachability else {
               return
           }
           
        if reachability.connection != .unavailable {
               if reachability.connection == .wifi {
                   print("WIFI 네트워크를 사용중입니다.")
               }
               else
               {
                   print("LTE or 5G 네트워크를 사용중입니다.")
               }
           } else {
               print("네트워크가 연결되지 않았습니다.")
           }
       }
    
   
    
    // MARK: -- Login Do it --
    func login(userid: String, userpass: String) {
        
        self.LoginCheck.requestLogin(myloginid: userid, myloginppassword: userpass)
        
    }
}



struct ContentView: View {
    
    var body: some View {
        
        LoginView(errorReason: "")
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
