# TravelGetaway – Architecture & Implementation Guide

This document details the internal architecture, design decisions, and advanced React patterns used in TravelGetaway.

---

## Project Structure

```
travelgetaway/
├── public/
│   └── favicon.svg
├── src/
│   ├── components/
│   │   ├── TripForm.tsx
│   │   ├── TripPreview.tsx
│   │   └── FileImportExport.tsx
│   ├── pages/
│   │   ├── Home.tsx
│   │   └── NotFound.tsx
│   ├── types/
│   │   └── trip.ts
│   ├── utils/
│   │   ├── storage.ts
│   │   └── export.ts
│   ├── context/
│   │   └── TripContext.tsx
│   ├── App.tsx
│   ├── main.tsx
│   └── styles.css
├── index.html
├── tsconfig.json
├── vite.config.ts
├── package.json
├── README.md
└── ARCHITECTURE.md
```

---

## Type Definitions

```ts
// src/types/trip.ts
export interface ActivityDay {
  date: string; // ISO string, e.g., "2025-07-01"
  activities: string[];
}

export interface Trip {
  title: string;
  days: ActivityDay[];
}
```

---

## Key Components

- **TripForm.tsx**  
  Controlled form for editing trip title and daily activities.

- **TripPreview.tsx**  
  Read-only display of the trip plan. Uses `React.memo` and `useMemo` for performance.

- **FileImportExport.tsx**  
  Import/export trip data as JSON. Uses an uncontrolled file input (ref).

- **AutoSave.tsx**  
  Example of `useEffect` with cleanup (timer for auto-save).

- **TripContext.tsx**  
  Provides trip state globally via React Context.

---

## Advanced React Concepts Demonstrated

- **Controlled vs Uncontrolled Components:**  
  `TripForm` uses controlled inputs (managed by React state).  
  `FileImportExport` demonstrates an uncontrolled file input using a ref.

- **useState Batching & Functional Updates:**  
  Functional updates to state in `Home.tsx` avoid stale closures, especially for nested data.  
  Multiple state updates are batched in event handlers.

- **Prop Drilling vs React Context:**  
  Trip data and update handlers are passed via props (prop drilling) by default.  
  A `TripContext` is provided as an alternative for global state sharing, consumed via `useContext`.

- **useEffect + Cleanup:**  
  `useEffect` is used for side effects (e.g., localStorage sync).  
  Example: a timer component demonstrates cleanup on unmount.

- **Performance Optimizations:**  
  `TripPreview` is wrapped in `React.memo` to prevent unnecessary re-renders.  
  `useMemo` and `useCallback` are used to memoize expensive calculations and callbacks.

---

## Example: useEffect Cleanup

```ts
// src/components/AutoSave.tsx
import { useEffect } from "react";

export function AutoSave({ onSave }: { onSave: () => void }) {
  useEffect(() => {
    const interval = setInterval(onSave, 10000); // auto-save every 10s
    return () => clearInterval(interval); // cleanup on unmount
  }, [onSave]);
  return null;
}
```

---

## Example: Performance Optimization

```ts
// src/components/TripPreview.tsx
import React, { useMemo } from "react";
import type { Trip } from "../types/trip";

const TripPreview = React.memo(({ trip }: { trip: Trip }) => {
  const summary = useMemo(() => {
    // expensive calculation here
    return trip.days.length;
  }, [trip.days]);
  return <div>Trip has {summary} days.</div>;
});
```

---

## Utilities

- **storage.ts**  
  Save/load trip data to/from localStorage.

- **export.ts**  
  Download trip as JSON or trigger email with trip data.

---

## Design Goals

- Type-safe from top to bottom
- Explicit component props/interfaces
- Pure functions in `utils/`
- Easy to extend (drag-and-drop, PWA, etc.)
- No backend dependencies

---

## Extensibility & Future Ideas

- Drag-and-drop support
- PDF export (e.g., html2pdf)
- PWA/offline support
- Firebase sync (optional)
- Collaboration mode (shared links)

---

_This document describes the internal architecture and React patterns used in TravelGetaway. For setup and usage, see [README.md](./README.md)._