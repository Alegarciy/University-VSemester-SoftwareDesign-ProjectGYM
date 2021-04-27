package WebServer

import (
	"API/Database/Requests"
	_ "API/Database/Requests"
	"API/Models"
	_ "API/Models"
	"fmt"
	"github.com/dgrijalva/jwt-go"
	_ "github.com/dgrijalva/jwt-go"
	"github.com/gofiber/fiber/v2"
)

func Start(c *fiber.Ctx) error {
	return c.SendString("Hello, World!")
}

func Login(context *fiber.Ctx) error {
	// mapping data parameters from body
	var data map[string]string
	if err := context.BodyParser(&data); err != nil {
		return err
	}
	username := data["username"]
	password := data["password"]


	// db request
	 user, success := Requests.GetUserByUsername(username)

	// user existence validation
	if !success {
		return giveJSONResponse(context, Models.Error{Message: InvalidLoginError}, fiber.StatusNotFound)

	}

	//  password validation
	if  user.Password != password {
		return giveJSONResponse(context, Models.Error{Message: InvalidLoginError}, fiber.StatusUnauthorized)
	}

	// token creation
	signedToken, err := getUserSignedToken(user.Username, user.Type)
	if err != nil{
		return giveJSONResponse(context, Models.Error{Message: CouldNotLoginError}, fiber.StatusInternalServerError)
	}

	// returns user info
	user.Token = signedToken
	return giveJSONResponse(context, user, fiber.StatusOK)
}

func getUserInfo (context *fiber.Ctx) error {

	isValid, token := AnalyzeToken(context)

	if !isValid {
		return giveJSONResponse(context, Models.Error{Message: InvalidTokenError}, fiber.StatusUnauthorized)
	}

	user := getUsernameFromToken(token)
	userType := getUserTypeFromToken(token)

	fmt.Println(user)

	dummyUser := Models.ClientUser{
		ID:       10,
		Username: user,
		Type:     userType,
		Name:     "Elfu Lano",
		Email:    "e@e.com",
		Phone:    "70560910",
		Balance:  12345.0,
	}

	return giveJSONResponse(context, dummyUser, fiber.StatusOK)
}

func AnalyzeToken (context *fiber.Ctx) (bool, *jwt.Token) {
	
	jwtFromHeader := string(context.Request().Header.Peek("Authorization"))
	isValid, token := validateUserToken(jwtFromHeader)
	fmt.Println("isValid: ")
	fmt.Println(isValid)

	return isValid, token
}

func giveJSONResponse(context *fiber.Ctx, pJSON interface{}, pStatus int) error {
	context.Status(pStatus)
	return context.JSON(pJSON)
}

