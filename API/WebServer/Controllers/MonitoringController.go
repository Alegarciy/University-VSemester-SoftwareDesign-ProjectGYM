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
	dbErr := Database.CheckHealth()
	
	status := "healthy"
	statusCode := 200
	
	if dbErr != nil {
		status = "unhealthy"
		statusCode = 503 // Service Unavailable
	}
	
	return c.Status(statusCode).JSON(fiber.Map{
		"status": status,
		"service": "database",
		"error": dbErr,
	})
} 