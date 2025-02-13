package Requests

import (
	"API/Database"
	"API/Database/Common"
	"API/Models"
	"database/sql"
	"fmt"
)

func GetLogin(pUsername string) (Models.Login, bool) {
	db := Database.GetConnection()
	
	// Query the function
	row := db.QueryRow("SELECT * FROM FN_GetUserByUsername($1)", pUsername)
	
	var user Models.Login
	err := row.Scan(
		&user.Identifier,  // This is already correctly an int
		&user.Username,
		&user.Password,
		&user.Type,
	)
	
	if err != nil {
		if err == sql.ErrNoRows {
			return Models.Login{}, false
		}
		fmt.Printf("Error scanning user: %v\n", err)
		return Models.Login{}, false
	}
	
	return user, true
}

func DeactivateAccount(pUsername string, pUserTypeID int) Common.VoidOperationResult {
	query := fmt.Sprintf(`EXEC SP_DeactivateAccount '%s', %d;`, pUsername, pUserTypeID)
	return VoidRequest(query)
}

func UpdateUserDetails(pOldUsername string, pNewUsername string, pUserTypeID int) Common.VoidOperationResult {
	query := fmt.Sprintf(`EXEC SP_UpdateUserDetails '%s', '%s', %d;`, pOldUsername, pNewUsername, pUserTypeID)
	return VoidRequest(query)
}

func RegisterClientUser(pUsername string, pPassword string, pMembershipNumber int) Common.VoidOperationResult {
	query := fmt.Sprintf(`EXEC SP_RegisterClientUser '%s', '%s', %d;`, pUsername, pPassword, pMembershipNumber)
	return VoidRequest(query)
}
