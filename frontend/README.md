# Frontend - Qwik + Qwik City

Modern, fast web interface for the shrtnr URL shortener.

## Technology Stack

- **Framework**: Qwik with Qwik City
- **Styling**: Tailwind CSS (recommended)
- **State Management**: Qwik stores
- **Build Tool**: Vite
- **TypeScript**: Full type safety

## Features

### Core Functionality

- **URL Shortening**: Simple form to create short URLs
- **URL Management**: List and manage user's URLs
- **Analytics Dashboard**: Click statistics and metrics
- **User Authentication**: Login/register flow

### User Interface

- **Responsive Design**: Mobile-first approach
- **Dark/Light Mode**: Theme switching
- **Real-time Updates**: Live analytics updates
- **Copy to Clipboard**: Easy URL sharing

## Pages Structure

```bash
src/
├── routes/
│   ├── index.tsx           # Homepage with shortening form
│   ├── dashboard/          # User dashboard
│   ├── analytics/          # Analytics pages
│   ├── auth/              # Login/register
│   └── [shortCode]/       # Dynamic redirect handling
├── components/
│   ├── forms/             # Form components
│   ├── analytics/         # Chart components
│   └── ui/                # Reusable UI components
└── services/              # API integration
```

## Development

```bash
npm install
npm run dev
```
