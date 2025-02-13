DROP TABLE IF EXISTS errors;

CREATE TABLE errors (
    id SERIAL PRIMARY KEY,
    error_name VARCHAR(50) UNIQUE NOT NULL,
    code INTEGER UNIQUE NOT NULL,
    message VARCHAR(100) NOT NULL
);

-- Insert error records
INSERT INTO errors (error_name, code, message) VALUES
    ('SPError', -50001, 'Error excecuting the stored procedure. Internal Error.'),
    ('SessionOutOfSpacesError', -50002, 'The session is out of booking spaces.'),
    ('AlreadyBookedError', -50003, 'The session is already booked by the user.'),
    ('NotBookedError', -50004, 'The session is not booked by the user.'),
    ('TimeUnavailableError', -50005, 'The time selected for the session is unavailable.'),
    ('PreliminaryNotFoundError', -50006, 'The preliminary session data does not correspond to an existing preliminary session.'),
    ('NoSessionsFoundError', -50007, 'No sessions were found with the given data.'),
    ('InstructorNotFound', -50008, 'Instructor information does not correspond to an existing instructor'),
    ('UsernameTakenError', -50009, 'The username entered already exist.'),
    ('UserNotFound', -50010, 'The username entered does not exist.'),
    ('UserAlreadyCreated', -50011, 'The user is already created for the client specified.'),
    ('ClientNotFound', -50012, 'The membership number specified does not exist.'),
    ('EmailUnavailable', -50013, 'The email entered is already taken.'),
    ('ServiceAlreadyExists', -50014, 'The Service name entered already exists'),
    ('InstructorAlreadyExists', -50015, 'The Instructor Identification entered already exists'),
    ('InstructorTypeNotDefined', -50016, 'The Instructor type entered is not defined'),
    ('CannotCancelSession', -50017, 'Cannot cancel session less than 8h before the start time.'),
    ('NoBookingsFound', -50018, 'No bookings found with the specified data.'),
    ('ServiceNotFound', -50019, 'No service found with the specified data.'),
    ('RoomNotFound', -50020, 'No room found with the specified data.'),
    ('ServiceAlreadyOfferedByInstructor', -50021, 'The given service is already offered by the given instructor'),
    ('DebtorClient', -50022, 'The client is in debtor condition.'),
    ('ServiceAlreadyFavorite', -50023, 'The selected service is already marked as favorite'),
    ('ServiceNotFavorite', -50024, 'The selected service is not marked as favorite');
