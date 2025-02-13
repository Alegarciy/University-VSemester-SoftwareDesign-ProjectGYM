package Common

const (

	/*
		DB Requests constants
	*/

	ErrorExecutingTransaction = "error executing transaction"

	UnknownErrorName    = "UnidentifiedError"
	UnknownErrorCode    = -50404
	UnknownErrorMessage = "unknown error occurred"

	MinimalSuccessfulReturnCode = 1

	// Database errors
	ErrDatabaseConnection = "database connection error"
	ErrUserNotFound      = "user not found"
	ErrQueryExecution    = "error executing query"
)
