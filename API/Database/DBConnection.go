package Database

import (
	"database/sql"
	_ "github.com/mattn/go-sqlite3"
	"log"
	"os"
	"path/filepath"
)

var db *sql.DB

func connect() {
	// Ensure data directory exists
	dataDir := "./data"
	if err := os.MkdirAll(dataDir, 0755); err != nil {
		log.Fatal("Error creating data directory:", err)
	}

	dbPath := filepath.Join(dataDir, "plusgym.db")
	
	var err error
	db, err = sql.Open("sqlite3", dbPath)
	if err != nil {
		log.Fatal("Error opening database:", err)
	}

	// Test the connection
	err = db.Ping()
	if err != nil {
		log.Fatal("Error connecting to database:", err)
	}

	// Initialize database schema
	initializeDatabase()
}

func initializeDatabase() {
	// Read and execute schema creation scripts
	schemaSQL := `
	-- Add your schema creation SQL here
	-- Convert your MSSQL schema to SQLite syntax
	CREATE TABLE IF NOT EXISTS Cliente (
		Id INTEGER PRIMARY KEY AUTOINCREMENT,
		Nombre TEXT NOT NULL,
		Correo TEXT UNIQUE NOT NULL,
		Celular TEXT,
		Cedula TEXT UNIQUE NOT NULL,
		Saldo REAL DEFAULT 0,
		Active INTEGER DEFAULT 1
	);
	-- Add other table creation statements
	`

	_, err := db.Exec(schemaSQL)
	if err != nil {
		log.Fatal("Error initializing database schema:", err)
	}
}

func ReadTransaction(pQuery string) (*sql.Rows, error) {
	connect()
	defer db.Close()

	// Execute query
	rows, err := db.Query(pQuery)
	if err != nil {
		return nil, err
	}

	return rows, nil
}

func VoidTransaction(pQuery string) (int64, error) {
	connect()
	defer db.Close()

	// Execute query
	result, err := db.Exec(pQuery)
	if err != nil {
		return -1, err
	}

	return result.LastInsertId()
}
