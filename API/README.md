# API Testing Routes Documentation

This document provides curl command examples to test the various endpoints of the API.

---

## Login Endpoint

- `Endpoint`: /api/user
- `Method`: POST
- `Description`: Authenticates a user and returns a JSON object containing user details and a JWT token.

### Login Requests

This endpoint allows the user to generate a JWT token and be able to authenticate himself with it.

```bash
curl -X POST http://localhost:5000/user/login \
     -H "Content-Type: application/json" \
     -d '{
           "username": "Cliente1",
           "password": "1234"
         }'
```

> Note: Replace http://localhost:5000 with your actual server address and update "yourpassword" with the correct password.

*Expected Response*

```bash
{
  "identifier": 1,
  "username": "Cliente1",
  "type": 2,
  "token": "<token information>"
}
```

---

Feel free to modify and expand this document to include all available routes and their corresponding curl examples.
This README file should help both developers and testers to quickly verify API functionality using curl commands.
