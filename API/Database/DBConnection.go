package Database

import (
	"context"
	"database/sql"
	"fmt"
	"log"

	mssql "github.com/denisenkom/go-mssqldb"
)

var db *sql.DB

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
	fmt.Printf("Connected!\n")
}

func VoidTransaction(pQuery string) (bool, error) {

	connect()
	defer db.Close()



	_, err = db.ExecContext(ctx, pQuery)

	if err != nil {
		return false, err
	}

	return true, nil
}

func ReadTransaction(pQuery string) (*sql.Rows, error) {

	connect()
	defer db.Close()

	ctx := context.Background()
	// Check if database is alive.
	err := db.PingContext(ctx)
	if err != nil {
		return nil, 0, err
	}
	var returnStatus mssql.ReturnStatus
	// Execute query
	rows, err := db.QueryContext(ctx, pQuery, &returnStatus)
	if err != nil {
		return nil, returnStatus, err
	}
	fmt.Println(returnStatus == 0)
	return rows, returnStatus, nil
}

func TestTran(pQuery string) (bool, error) {

	connect()
	defer db.Close()

	var rs mssql.ReturnStatus

	ctx := context.Background()
	// Check if database is alive.
	err := db.PingContext(ctx)
	if err != nil {
		return false, err
	}

	// Execute query
	result, err := db.ExecContext(ctx, pQuery, &rs)
	if err != nil {
		return false, err
	}
	println(result.LastInsertId())
	println(rs)

	return true, nil
}
