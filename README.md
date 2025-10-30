# Reimburse Venturo

A Flutter reimbursement management application built with Clean Architecture and GetX state management.

## Features

- **Reimbursement List**: View all available reimbursement categories
- **Reimbursement Form**: Complete form for submitting reimbursement requests
  - Date picker with calendar view
  - Claim type dropdown (8 types)
  - Detail text area
  - File upload (images, PDF, Excel, Word)
  - Currency input with Rupiah formatting
  - Multiple attachment support
- **File Management**: Upload and preview multiple files per submission
- **Approval Line**: Display approval hierarchy with status tracking
- **Form Validation**: Comprehensive validation before submission

## Tech Stack

- **Flutter**: 3.9.0+
- **Dart**: 3.0.0+
- **State Management**: GetX 4.6.6
- **UI Components**:
  - google_fonts: ^6.2.1
  - table_calendar: ^3.1.2
  - dotted_border: ^2.1.0
- **File Handling**:
  - image_picker: ^1.1.2
  - file_picker: ^8.1.2
- **Utilities**:
  - intl: ^0.19.0 (for currency and date formatting)

## Architecture

This project follows **Clean Architecture** principles with three main layers:

### 1. Data Layer (`lib/app/data/`)
- **Models**: Data models with serialization logic
- **Repositories**: Implementation of data sources (API, local storage)

### 2. Domain Layer (`lib/app/domain/`)
- **Entities**: Business objects (pure Dart classes)
- **Use Cases**: Business logic and rules

### 3. Presentation Layer (`lib/app/presentation/`)
- **Pages**: Screen UI components
- **Controllers**: GetX controllers for state management
- **Widgets**: Reusable UI components

### Core (`lib/core/`)
- **Constants**: App-wide constants (colors, claim types)
- **Theme**: Theme configuration and text styles
- **Utils**: Utility functions (currency formatter)

## Design Specifications

The app follows a professional business application design:

- **Primary Blue**: #0C4886 (Dark Blue), #157FEC (Light Blue)
- **Success Green**: #73D490
- **Background**: #FFFFFF with subtle shadows
- **Typography**: Inter font family
  - Title: 19sp, Semi-Bold
  - Section Headers: 14sp, Semi-Bold
  - Body Text: 13sp, Regular
  - Hints: 11sp, Regular

## Getting Started

### Prerequisites

- Flutter SDK (3.9.0 or higher)
- Dart SDK (3.0.0 or higher)
- Android Studio / VS Code with Flutter plugin

### Installation

1. Clone the repository:
```bash
git clone <repository-url>
cd reimburse_venturo
```

2. Install dependencies:
```bash
flutter pub get
```

3. Run the app:
```bash
flutter run
```

## Project Structure

```
lib/
├── app/
│   ├── data/
│   │   └── models/           # Data models with dummy data
│   ├── domain/
│   │   └── entities/         # Business entities
│   ├── presentation/
│   │   ├── controllers/      # GetX controllers
│   │   ├── pages/            # Screen pages
│   │   └── widgets/          # Reusable widgets
│   └── routes/               # App routing configuration
├── core/
│   ├── constants/            # App constants
│   ├── theme/                # Theme and styles
│   └── utils/                # Utility functions
└── main.dart                 # App entry point
```

## Screens

### 1. Reimbursement List Page
- Displays 8 reimbursement categories
- Gradient app bar with primary blue colors
- Clickable cards with navigation arrows
- Empty state handling

### 2. Reimbursement Form Page
- **Section 1: Data Pengajuan**
  - Date picker field with calendar bottom sheet
  - Claim type dropdown with 8 options
  - Detail text area (multiline)
- **Section 2: Upload Bukti**
  - Dotted border upload area
  - Support for multiple file types (image, PDF, Excel, Word)
  - File size validation (5MB max)
  - Currency input with auto-formatting (Rupiah)
  - File preview with type-specific icons
  - Display uploaded items with nominal
- **Section 3: Approval Line**
  - Hierarchical approval display
  - Approver cards with avatar, name, job title
  - Status badges (Waiting, Approved, Rejected)
- **Submit Button**
  - Gradient background
  - Disabled state when form incomplete
  - Loading state during submission

## Key Features Implementation

### Currency Formatting
The app includes a custom `CurrencyFormatter` utility that:
- Formats integers to Rupiah string with dot separators (20000 → 20.000)
- Parses formatted strings back to integers
- Includes `CurrencyInputFormatter` for real-time input formatting

### File Upload
- Supports multiple file selection (images and documents)
- File type detection and appropriate icon display
- Size validation with user-friendly error messages
- Preview for images, icon representation for documents

### Form Validation
Comprehensive validation before submission:
- Date must be selected
- Claim type must be chosen
- Detail must be filled
- At least one attachment required

### State Management
Uses GetX for reactive state management:
- Reactive variables with `.obs`
- Automatic UI updates with `Obx()`
- Controller lifecycle management
- Dependency injection with GetX bindings

## Development Approach

This project was developed with 30 natural, incremental commits across 11 phases:
- **Phase 1**: Project setup and configuration
- **Phase 2**: Reusable component library
- **Phase 3**: List screen implementation
- **Phase 4**: Form structure and basic fields
- **Phase 5**: Detail section
- **Phase 6**: File upload functionality
- **Phase 7**: Currency formatting
- **Phase 8**: Approval line
- **Phase 9**: Form controller and validation
- **Phase 10**: Submit functionality and polish
- **Phase 11**: Documentation

## Testing

To run tests:
```bash
flutter test
```

## Build

To build the app for release:
```bash
# Android
flutter build apk --release

# iOS
flutter build ios --release
```

## License

This project is part of a technical assessment.
