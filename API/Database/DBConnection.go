package Database

import (
	"context"
	"database/sql"
	"fmt"
	"log"
	"os"
	"sync"

	mssql "github.com/denisenkom/go-mssqldb"
	_ "github.com/lib/pq"
)

var (
	db   *sql.DB
	once sync.Once
)

var server = "carrera.database.windows.net"
var port = 1433
var user = "trabajadorResponsable"
var password = "1231!#ASDF!a"
var database = "PlusGymProject"

func connect() {
	// Build connection string
	connString := fmt.Sprintf("server=%s;user id=%s;password=%s;port=%d;database=%s;",
		server, user, password, port, database)

	var err error

	// Create connection pool
	db, err = sql.Open("sqlserver", connString)

	if err != nil {
		log.Fatal("Error creating connection pool: ", err.Error())
	}
	ctx := context.Background()
	err = db.PingContext(ctx)
	if err != nil {
		log.Fatal(err.Error())
	}
}

func ReadTransaction(pQuery string) (*sql.Rows, error) {
	connect()
	defer db.Close()

	ctx := context.Background()
	// Check if database is alive.
	err := db.PingContext(ctx)
	if err != nil {
		return nil, err
	}

	// Execute query
	rows, err := db.QueryContext(ctx, pQuery)
	if err != nil {
		return nil, err
	}

	return rows, nil
}

func VoidTransaction(pQuery string) (mssql.ReturnStatus, error) {
	connect()
	defer db.Close()

	ctx := context.Background()

	var returnStatus mssql.ReturnStatus

	// Check if database is alive.
	err := db.PingContext(ctx)

	if err != nil {
		returnStatus = -1
		println(err.Error())
		return returnStatus, err
	}

	// Execute query
	_, err = db.ExecContext(ctx, pQuery, &returnStatus)

	if err != nil {
		returnStatus = -1
		println(err.Error())
		return returnStatus, err
	}

	return returnStatus, nil
}

// GetConnection returns a singleton instance of the database connection
func GetConnection() *sql.DB {
	once.Do(func() {
		var err error
		
		// Get connection details from environment variables - match docker-compose.yml names
		host := os.Getenv("DB_HOST")
		port := os.Getenv("DB_PORT")
		user := os.Getenv("DB_USER")
		password := os.Getenv("DB_PASSWORD")
		dbname := os.Getenv("DB_NAME")
		
		// Create connection string
		connStr := fmt.Sprintf("host=%s port=%s user=%s password=%s dbname=%s sslmode=disable",
			host, port, user, password, dbname)
		
		log.Printf("Attempting to connect to database with: host=%s port=%s dbname=%s user=%s", 
			host, port, dbname, user) // Add logging to help debug
		
		// Open database connection
		db, err = sql.Open("postgres", connStr)
		if err != nil {
			log.Printf("Error opening database connection: %v", err)
			panic(err)
		}
		
		// Set connection pool settings
		db.SetMaxOpenConns(25)
		db.SetMaxIdleConns(25)
	})
	
	return db
}

// CheckHealth pings the database to check if it's alive
func CheckHealth() error {
	return GetConnection().Ping()
}

// QueryFunction executes a PostgreSQL function and returns the result
func QueryFunction(query string, args ...interface{}) (*sql.Rows, error) {
	db := GetConnection()
	if db == nil {
		return nil, fmt.Errorf("database connection is nil")
	}
	
	return db.Query(query, args...)
}

// QueryFunctionRow executes a PostgreSQL function and returns a single row
func QueryFunctionRow(query string, args ...interface{}) *sql.Row {
	db := GetConnection()
	if db == nil {
		return nil
	}
	
	return db.QueryRow(query, args...)
}
