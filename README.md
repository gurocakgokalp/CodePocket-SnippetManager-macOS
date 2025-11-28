<img src="https://github.com/user-attachments/assets/c2e0f378-e558-411e-8259-b6483e677170" width="120" alt="CodePocket Icon">

# CodePocket 👨‍💻 

![Language](https://img.shields.io/badge/Language-Swift_6.2-orange)
![Framework](https://img.shields.io/badge/Framework-SwiftUI-blue)
![Database](https://img.shields.io/badge/Database-SwiftData-green)
![Platform](https://img.shields.io/badge/Platform-macOS_14+-black)

> Bu proje, macOS geliştirme ekosistemini ve SwiftData mimarisini öğrenmek amacıyla geliştirdiğim bir projedir.

---

## 🎯 Projenin Amacı
Temel hedefim: Yazılım öğrenirken sıkça unuttuğum kod parçacıklarını (Snippet) hızlıca erişebileceğim, Menu Bar destekli bir araç yapmaktı.

## 📸 Önizleme

| Ana Editör (Code Editor) | Menu Bar (Hızlı Erişim) |
|:-----------------------:|:-----------------------:|
| <img src="https://github.com/user-attachments/assets/465bb194-e570-4e93-be04-2a8aae46e128" width="400"> | <img src="https://github.com/user-attachments/assets/60c1d39f-7d94-428a-ac1a-dcbe26fca692" width="300"> |



---

## 🚀 Neler Öğrendim? (Key Takeaways)

Bu projeyi geliştirirken şu teknik konularda derinleştim:

### 1. macOS Native UI Mimarisi
* iOS'ten farklı olarak **`NavigationSplitView`** (Sidebar + Detail) yapısını kurdum.
* **`Window`** vs **`WindowGroup`** farkını ve **Single Instance** (Tek Pencere) yönetimini öğrendim.
* Uygulamanın dock yerine sadece Menu Bar'da çalışması veya her ikisinde çalışması senaryolarını denedim.

### 2. SwiftData & Modern Database
* CoreData yerine Apple'ın yeni **`@Model`** ve **`@Query`** yapılarını kullandım.
* **Shared Model Container:** Veritabanını hem Ana Pencere hem de Menu Bar arasında senkronize etmek için ortak bir `ModelContainer` yapısı kurdum. Bu sayede ana ekranda eklenen veri, menüde anında beliriyor.

### 3. Paket Yönetimi & 3. Parti Kütüphaneler
* `TextEditor` yetersiz kaldığı için **ZeeZide/CodeEditor** kütüphanesini SPM (Swift Package Manager) ile projeye dahil ettim.
* Dinamik dil algılama ve Syntax Highlighting (Renklendirme) özelliklerini entegre ettim.

---

## 📥 Kurulum

1.  Repoyu klonlayın:
    ```bash
    git clone [https://github.com/gurocakgokalp/CodePocket-SwiftData-macOS.git](https://github.com/gurocakgokalp/CodePocket-SwiftData-macOS.git)
    ```
2.  `CodePocket.xcodeproj` dosyasını Xcode ile açın.
3.  `Cmd + R` ile çalıştırın.

---

## 🔮 Gelecek Planları

- [ ] Snippet'ları iCloud ile cihazlar arası senkronize etmek (CloudKit).
- [ ] Kodları kategorilere/klasörlere ayırma özelliği.
- [ ] Gist (GitHub) entegrasyonu.
