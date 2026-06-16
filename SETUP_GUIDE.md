# Laravel + React Fullstack Project Setup Guide

## Prerequisites
- PHP 8.2+ installed with Composer
- Node.js 18+ installed with npm
- SQLite support (included with PHP)

## Project Structure
- **laravel-api-app**: Backend API (Laravel 11)
- **laravel-api-react-app**: Frontend (React 18 + Vite)

---

## Quick Start

### 1. Backend Setup (Laravel)

#### Step 1.1: Install PHP Dependencies
```bash
cd laravel-api-app
composer install
```

#### Step 1.2: Setup Environment
```bash
# Copy environment file
copy .env.example .env

# Generate application key
php artisan key:generate

# Create SQLite database
if not exist "database\database.sqlite" (type nul > "database\database.sqlite")

# Run migrations
php artisan migrate
```

#### Step 1.3: Optional - Seed Database with Sample Data
```bash
php artisan db:seed
```

#### Step 1.4: Start Laravel Development Server
```bash
php artisan serve
```
The API will be available at: **http://localhost:8000**

---

### 2. Frontend Setup (React)

#### Step 2.1: Install Node Dependencies
```bash
cd laravel-api-react-app
npm install
```

#### Step 2.2: Start Development Server
```bash
npm run dev
```
The frontend will be available at: **http://localhost:5173** (or the port shown in terminal)

---

## API Endpoints

The Laravel backend provides these main endpoints:

### Authentication (Sanctum)
- `POST /api/auth/register` - Register new user
- `POST /api/auth/login` - Login user
- `POST /api/auth/logout` - Logout user

### Posts (Protected Routes)
- `GET /api/posts` - List all posts
- `GET /api/posts/{id}` - Get specific post
- `POST /api/posts` - Create post (authenticated)
- `PUT /api/posts/{id}` - Update post (authenticated)
- `DELETE /api/posts/{id}` - Delete post (authenticated)

---

## Environment Configuration

The Laravel `.env` file is pre-configured with:
- **Database**: SQLite (database/database.sqlite)
- **App Debug**: true (development mode)
- **Session Driver**: database
- **Authentication**: Laravel Sanctum

---

## Troubleshooting

### Composer Install Issues
If `composer install` hangs:
1. Cancel the command (Ctrl+C)
2. Try: `composer install --no-dev` (skip dev dependencies)
3. Or: `composer install --prefer-dist` (use pre-built packages)

### Node Installation Issues
If `npm install` is slow:
1. Clear npm cache: `npm cache clean --force`
2. Try: `npm install --legacy-peer-deps`

### Migration Issues
```bash
# Refresh database (delete all tables and re-run migrations)
php artisan migrate:refresh

# Refresh with seed data
php artisan migrate:refresh --seed
```

### Port Already in Use
- Laravel default: `php artisan serve --port=8001`
- React/Vite: `npm run dev -- --port=5174`

---

## Testing

### Backend Tests
```bash
php artisan test
```

### Frontend Linting
```bash
npm run lint
```

---

## Production Build

### Frontend Build
```bash
cd laravel-api-react-app
npm run build
```
Output files go to `dist/` folder

### Laravel Optimization
```bash
php artisan optimize
php artisan config:cache
php artisan route:cache
```

---

## Key Files to Understand

**Backend:**
- `routes/api.php` - API route definitions
- `app/Http/Controllers/` - API controllers
- `database/migrations/` - Database schemas
- `app/Models/` - Eloquent models

**Frontend:**
- `src/main.jsx` - Entry point
- `src/App.jsx` - Root component
- `src/Pages/` - Page components
- `src/Context/AppContext.jsx` - Global state management

---

## Next Steps

1. ✅ Follow the setup steps above
2. Run both servers (Laravel & React)
3. Open http://localhost:5173 in your browser
4. Test registration/login functionality
5. Create and manage posts

Good luck with your assignment!
