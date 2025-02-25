import SwiftUI

struct MainTabView: View {
    var body: some View {
        TabView {
            HomeView()
                .tabItem {
                    Image(systemName: "house")
                    Text("Home")
                }
            
            LibraryView()
                .tabItem {
                    Image(systemName: "book.fill")
                    Text("Library")
                }
            
            MarketplaceView()
                .tabItem {
                    Image(systemName: "cart")
                    Text("Marketplace")
                }
            
            ProfileView()
                .tabItem {
                    Image(systemName: "person.circle")
                    Text("Profile")
                }
        }
    }
}

struct MainTabView_Previews: PreviewProvider {
    static var previews: some View {
        MainTabView()
            .environmentObject(LibraryModel())
            .environmentObject(StoryManager())
    }
}
