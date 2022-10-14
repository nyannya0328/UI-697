//
//  MainView.swift
//  UI-697
//
//  Created by nyannyan0328 on 2022/10/14.
//

import SwiftUI

struct MainView: View {
    @State var currentTab : Tab = .home
    @Namespace var animation
    
    @State var showTabBar : Bool = true
    var body: some View {
        ZStack(alignment: .bottom) {
            
            TabView(selection: $currentTab) {
                Home()
               .tag(Tab.home)
               .setBarBG(color: Color("BG"))
               
           
               
                Text("B")
                    .tag(Tab.scan)
                    .setBarBG(color: Color("BG"))
                
                Text("C")
                    .tag(Tab.folder)
                    .setBarBG(color: Color("BG"))
                
                Text("D")
                    .tag(Tab.cart)
                    .setBarBG(color: Color("BG"))
                
            }
            
            TabBar()
                .offset(y:showTabBar ? 0 : 120)
                .animation((.interactiveSpring(response: 0.5,dampingFraction: 0.8,blendDuration: 0.7)), value: showTabBar)
            
            
            
        }
        .ignoresSafeArea(.keyboard,edges: .bottom)
        .onReceive(NotificationCenter.default.publisher(for: Notification.Name("SHOWTABBAR"))) { _ in
            
            showTabBar = true
            
        }
        .onReceive(NotificationCenter.default.publisher(for: Notification.Name("HIDETABBAR"))) { _ in
            
            showTabBar = false
            
        }
    }
    @ViewBuilder
    func TabBar ()->some View{
        HStack(spacing: 15) {
            
            ForEach(Tab.allCases ,id:\.self){tab in
                
                Image(tab.rawValue)
                    .resizable()
                    .renderingMode(.template)
                    .aspectRatio(contentMode: .fill)
                    .frame(width: 25,height: 25)
                  
                    .foregroundColor(currentTab == tab ? .white : .gray.opacity(0.3))
                    .offset(y:currentTab == tab ? -25 : 0)
                    .background{
                     
                        if currentTab == tab{
                            
                            Circle()
                                .fill(.black)
                                .scaleEffect(2.3)
                                .matchedGeometryEffect(id: "TAB", in: animation)
                                .offset(y:currentTab == tab ? -25 : 0)
                        }
                    }
                    .frame(maxWidth: .infinity,alignment: .center)
                    .padding(15)
                    .onTapGesture {
                        
                        currentTab = tab
                    }
                    
            }
        }
        .padding(.horizontal)
        .animation((.interactiveSpring(response: 0.5,dampingFraction: 0.8,blendDuration: 0.7)), value: currentTab)
        .background{
         
            CustomCorner(corner: [.topLeft,.topRight], radius: 20)
                .fill(Color("Tab"))
                .ignoresSafeArea()
        }
        
    }
    
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

extension View{
    
    func setTabBar(){
        
        NotificationCenter.default.post(name: NSNotification.Name("SHOWTABBAR"), object: nil)
        
        
    }
    
    func hideTabBar(){
        
        NotificationCenter.default.post(name: NSNotification.Name("HIDETABBAR"), object: nil)
    }
  
    @ViewBuilder
    func setBarBG(color : Color)->some View{
        
        self
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background{
             
                color.ignoresSafeArea()
            }
        
    }
}
