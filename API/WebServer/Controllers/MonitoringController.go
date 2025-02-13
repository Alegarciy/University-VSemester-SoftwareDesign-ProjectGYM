package Controllers

import (
	"API/Database"
	"github.com/gofiber/fiber/v2"
)

// APIHealthCheck handles the API health check endpoint request
func APIHealthCheck(c *fiber.Ctx) error {
	return c.Status(200).JSON(fiber.Map{
		"status": "healthy",
		"service": "api",
	})
}

// DatabaseHealthCheck handles the database health check endpoint request
func DatabaseHealthCheck(c *fiber.Ctx) error {
	db := Database.GetConnection()
	
	// Simple ping to check if database is alive
	err := db.Ping()
	
	status := "healthy"
	statusCode := 200
	
	if err != nil {
		status = "unhealthy"
		statusCode = 503 // Service Unavailable
	}
	
	return c.Status(statusCode).JSON(fiber.Map{
		"status": status,
		"service": "database",
		"error": err,
	})
} 