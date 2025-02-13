-- Basic schema for SQLite
PRAGMA foreign_keys = ON;

CREATE TABLE IF NOT EXISTS Cliente (
    Id INTEGER PRIMARY KEY AUTOINCREMENT,
    Nombre TEXT NOT NULL,
    Correo TEXT UNIQUE NOT NULL,
    Celular TEXT,
    Cedula TEXT UNIQUE NOT NULL,
    Saldo REAL DEFAULT 0,
    Active INTEGER DEFAULT 1
);

-- Add more table creation statements converted from your SQL Server scripts 