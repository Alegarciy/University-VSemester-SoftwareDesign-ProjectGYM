-- Create a new stored procedure called 'SP_BookSession' in schema 'dbo'
-- Drop the stored procedure if it already exists
IF EXISTS (
SELECT *
    FROM INFORMATION_SCHEMA.ROUTINES
WHERE SPECIFIC_SCHEMA = N'dbo'
    AND SPECIFIC_NAME = N'SP_BookSession'
    AND ROUTINE_TYPE = N'PROCEDURE'
)
DROP PROCEDURE dbo.SP_BookSession
GO
-- Create the stored procedure in the specified schema
CREATE PROCEDURE dbo.SP_BookSession
    @pUsername VARCHAR(50),
    @pSessionID INT
AS
BEGIN
    BEGIN TRY

        DECLARE @BookedSpaces       INT
        DECLARE @TotalSpaces        INT
        DECLARE @AvailableSpaces    INT
        DECLARE @ClientID           INT
        DECLARE @ReturnCode         INT

        -- Gets the total available spaces for a certain session.
        SET @TotalSpaces = 
            (
                SELECT 
                    [session].Cupo 
                FROM 
                    dbo.Sesion AS [session]
                WHERE 
                    [session].Id = @pSessionID                
            )

        SET @ClientID = 
            (
                SELECT 
                    client.ClientId
                FROM
                    dbo.CompleteClients AS client
                WHERE
                    client.Username = @pUsername               
            )

        -- Checks if client already booked that session.
        IF @ClientID IN ( SELECT booking.ClienteId FROM dbo.Reserva AS booking WHERE booking.SesionId = @pSessionID )
            SET @ReturnCode = -2 -- Returns client 
        ELSE
            BEGIN 
                SET TRANSACTION ISOLATION LEVEL REPEATABLE READ
                BEGIN TRANSACTION

                    -- Gets count of already booked spaces for that session
                    SET @BookedSpaces = 
                        (
                            SELECT 
                                COUNT(*)
                            FROM 
                                dbo.Reserva AS booking
                            WHERE 
                                booking.SesionId = @pSessionID
                        )
                    
                    -- Calculates the available spaces based on the previuos sets
                    SET @AvailableSpaces = @TotalSpaces - @BookedSpaces

                    IF @AvailableSpaces > 0
                        BEGIN
                            SET @ReturnCode = 1
                            INSERT INTO 
                                dbo.Reserva (FechaReserva, Activa, ClienteId, SesionId)
                            VALUES
                                (GETDATE(), 1, @ClientID, @pSessionID)
                        END
                    ELSE SET @ReturnCode = -1                
                COMMIT
            END
        RETURN @ReturnCode;
    END TRY
    BEGIN CATCH
        IF @@TRANCOUNT > 0
            ROLLBACK
        RETURN @@Error * -1
    END CATCH
END
GO