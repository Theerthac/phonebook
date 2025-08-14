# 📒 Phone Book App

A simple, fast, and responsive **Phone Book** application built with **Flutter**, **Supabase**, and **Clean Architecture**.  
It uses **Cubit** for state management, a **Shimmer loading effect** for smooth UX, and is designed for **scalability** and **maintainability**.

---

## ✨ Features

- 📋 **View Contacts** – See all saved contacts with name & phone number  
- ➕ **Add Contact** – Save new contacts with a quick form  
- ✏️ **Edit Contact** – Update details anytime  
- ❌ **Delete Contact** – Remove contacts in one tap  
- 🔍 **Search Contacts** – Real-time search by name or number  
- ⭐ **Favorite Contacts** – Mark/unmark important contacts  
- 🆕 **Recently Added** – Sort or view the most recent entries  
- ⚡ **Fast & Smooth** – Optimized with Supabase real-time updates  

**Optional Extras:**
- 🔐 Email login with Supabase Auth  
- 🌙 Dark mode toggle  
- 👤 Contact avatars or initials  
- ✨ Shimmer effect for loading states  

---

## 🛠 Tech Stack

- **Flutter** (latest stable)
- **Supabase** (Database + Backend + Real-time)
- **Cubit** (Bloc) for state management
- **Clean Architecture** for clear separation of concerns
- **Responsive UI** for multiple screen sizes
- **Shimmer Effect** for better UX during loading

---

## 🛠 Setup Instructions

### **Requirements**
- [Flutter SDK](https://flutter.dev/docs/get-started/install) (latest stable)
- [Supabase](https://supabase.com/) account & project

**Supabase Table Structure** (`contacts` table):

| Field         | Type      | Description                      |
|---------------|-----------|----------------------------------|
| `id`          | UUID      | Primary key (auto-generated)     |
| `name`        | Text      | Contact’s full name              |
| `phone`       | Text      | Phone number                     |
| `is_favorite` | Boolean   | Whether the contact is favorite  |
| `created_at`  | Timestamp | Auto-generated timestamp         |

---

### **Configuration**
Add your Supabase credentials in `lib/core/constants.dart`:

```dart
const String supabaseUrl = 'YOUR_SUPABASE_URL';
const String supabaseAnonKey = 'YOUR_SUPABASE_ANON_KEY';


💡 Approach

State Management – Used Cubit for lightweight and predictable state handling

Architecture – Followed Clean Architecture to separate UI, business logic, and data layers

Backend – Supabase for database storage & real-time updates

UI Enhancements:

Shimmer effect for loading states

Responsive design for various screen sizes

Smooth animations for a polished UX

This approach ensures the app is scalable, testable, and easy to maintain, while providing a fast and clean user experience.


📸 Screenshots
assets/homepage.jpg
assets/signup.jpg
assets/login .jpg
assets/darktheme.jpg