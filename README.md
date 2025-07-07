# TravelGetaway

A minimalist, type-safe React app for planning trips.  
Export/import plans as JSON, email a copy, and enjoy zero backend dependencies.  
Deployed for fast static hosting on GitHub Pages.

---

## Features

- Plan multi-day trips with activities per day
- Export/import trip plans as JSON
- Email trip plans (opens your mail client)
- State persists in localStorage
- Responsive, fast, and type-safe

## Tech Stack

- [React](https://react.dev/) (via Vite)
- [TypeScript](https://www.typescriptlang.org/) (strict)
- [Material UI (MUI)](https://mui.com/) (component library)
- [React Router DOM](https://reactrouter.com/) (routing)
- [localStorage](https://developer.mozilla.org/docs/Web/API/Window/localStorage) (state persistence)
- [Vite](https://vitejs.dev/) (fast dev/build tooling)
- [GitHub Pages](https://pages.github.com/) (static hosting)

---

## Getting Started

### Prerequisites

- Node.js v18+ (recommended v20+)
- npm

### Installation

```sh
git clone https://github.com/YOUR_USERNAME/travelgetaway.git
cd travelgetaway
npm install
```

### Development

```sh
npm run dev
```
Visit [http://localhost:5173](http://localhost:5173) in your browser.

### Build

```sh
npm run build
```

### Deploy to GitHub Pages

```sh
npm run deploy
```

See `vite.config.ts` and `package.json` for deployment config.

---

## Architecture

See [ARCHITECTURE.md](./ARCHITECTURE.md) for details on project structure, advanced React patterns, and design decisions.

---

## Notes

This project was bootstrapped with [Vite](https://vitejs.dev/).  
See the generated files like `vite.config.ts`, `vite-env.d.ts`, and the `src/assets/` and `public/vite.svg` for Vite defaults.

---

_This project is a demonstration of modern React, TypeScript, and frontend architecture best practices._