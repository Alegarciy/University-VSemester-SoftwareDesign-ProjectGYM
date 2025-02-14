package WebServer

import (
	"API/WebServer/Controllers"
	"github.com/gofiber/fiber/v2"
)

func Setup(app *fiber.App) {
	// Monitoring endpoints
	monitoring := app.Group("/monitoring")
	monitoring.Get("/health/api", Controllers.APIHealthCheck)
	monitoring.Get("/health/database", Controllers.DatabaseHealthCheck)

	client := app.Group("/client")
	client.Post("/clients", Controllers.GetClients)
	client.Post("/clientInfo", Controllers.GetClientInfo)
	client.Post("/createClient", Controllers.CreateClient)
	client.Post("/updateClientDetails", Controllers.UpdateClientDetail)
	client.Post("/deleteClient", Controllers.DeleteClient)
	client.Post("/insertCredit", Controllers.InsertCreditMovement)

	// ? Aqui esta bien o mejor hacer otra seccion?
	client.Post("/sessionParticipants", Controllers.GetSessionParticipants)
	client.Get("/notifyPrizes", Controllers.NotifyPrizes)
	client.Post("/monthlyPrizes", Controllers.GetMonthlyPrizes)
	client.Post("/awardPrizes", Controllers.AwardPrizes)
	//client.Post("/monthlyStars", Controllers.GetClientMonthlyStars)
	client.Post("/getNotifications", Controllers.GetNotifications)

	//TODO: discuss in which group this request has to be categorized
	client.Get("/paymentMethods", Controllers.GetPaymentMethods)

	user := app.Group("/user")
	user.Post("/login", Controllers.Login) // Updated!!
	user.Post("/deactivateAccount", Controllers.DeactivateAccount)
	user.Post("/registerClientUser", Controllers.RegisterClientUser)
	user.Post("/updateUserDetails", Controllers.UpdateUserDetails)

	services := app.Group("/services")
	services.Get("/services", Controllers.GetServices)
	services.Post("/insertService", Controllers.InsertService)
	services.Post("/delete", Controllers.DeleteService)
	services.Post("/setMaxSpaces", Controllers.SetServiceMaxSpace)

	// Todo bien eduardo asi esta perfecto 💯
	services.Post("/favoriteServices", Controllers.GetFavoriteServices)
	services.Post("/addFavoriteService", Controllers.AddFavoriteService)
	services.Post("/removeFavoriteService", Controllers.RemoveFavoriteService)

	sessions := app.Group("/sessions")
	sessions.Get("/activeSchedule", Controllers.GetActiveSchedule)
	sessions.Post("/bookSession", Controllers.BookSession)
	sessions.Post("/cancelBooking", Controllers.CancelBooking)
	sessions.Post("/cancelSession", Controllers.CancelSession) // No implementar
	sessions.Post("/reservedSessions", Controllers.GetReservedSessions)
	sessions.Post("/changeSessionInstructor", Controllers.ChangeSessionInstructor)
	sessions.Post("/getFilteredSchedule", Controllers.GetFilteredSchedule)
	sessions.Post("/setAttendance", Controllers.SetSessionAttendance)
	sessions.Get("/attendancePending", Controllers.GetAttendancePendingSession)

	instructor := app.Group("/instructor")
	instructor.Post("/instructors", Controllers.GetInstructors)
	instructor.Post("/remove", Controllers.DeleteInstructor)
	instructor.Post("/insert", Controllers.InsertInstructor)
	instructor.Post("/instructorInfo", Controllers.GetInstructorInfo)
	instructor.Post("/addService", Controllers.AddServiceToInstructor)

	preliminarySchedule := app.Group("/preliminarySchedule")
	preliminarySchedule.Post("/preliminarySchedule", Controllers.GetPreliminarySchedule)
	preliminarySchedule.Post("/insertPreliminarySession", Controllers.InsertPreliminarySession)
	preliminarySchedule.Post("/deletePreliminarySession", Controllers.DeletePreliminarySession)
	preliminarySchedule.Post("/confirmPreliminarySchedule", Controllers.ConfirmPreliminarySchedule)

	room := app.Group("/rooms")
	room.Post("/setMaxSpaces", Controllers.SetRoomMaxSpace)
	room.Post("/setWorkingHours", Controllers.SetRoomWorkingHours)

}
