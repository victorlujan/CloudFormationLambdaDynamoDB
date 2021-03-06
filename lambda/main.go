package main

import (
	"encoding/json"
	"lambda-dynamodb-users/dynamodb"
	"lambda-dynamodb-users/types"
	"net/http"

	"github.com/aws/aws-lambda-go/events"
	"github.com/aws/aws-lambda-go/lambda"
)

func main() {
	lambda.Start(Handler)

}

func Handler(req events.APIGatewayProxyRequest) (events.APIGatewayProxyResponse, error) {
	if req.HTTPMethod == "POST" {
		var user types.User
		err := json.Unmarshal([]byte(req.Body), &user)
		if err != nil {
			return response("Error de Unmarshal", http.StatusBadRequest), err
		}
		err = dynamodb.SaveUser(user)
		if err != nil {
			return response("Error to save the user", http.StatusOK), nil
		}
		return response("User saved", http.StatusOK), nil
	}

	if req.HTTPMethod == "GET" {
		var user types.User
		err := json.Unmarshal([]byte(req.Body), &user)
		if err != nil {
			return response("Error de Unmarshal", http.StatusBadRequest), err
		}
		email := user.Email
		user, err = dynamodb.QueryUser(email)
		if err != nil {
			return response("User not found", http.StatusOK), nil
		}
		userresponse, _ := json.Marshal(user)
		return responseUser(userresponse, http.StatusOK), nil
	}
	if req.HTTPMethod == "DELETE" {
		var user types.User
		err := json.Unmarshal([]byte(req.Body), &user)
		if err != nil {
			return response("Error de Unmarshal", http.StatusBadRequest), err
		}
		id := user.ID
		err = dynamodb.DeleteUser(id)
		if err != nil {
			return response("Error deleting user", http.StatusOK), nil
		}
		return response("User deleted", http.StatusOK), nil
	}
	return response("Method not allowed", http.StatusMethodNotAllowed), nil
}
func responseUser(body []byte, statusCode int) events.APIGatewayProxyResponse {
	return events.APIGatewayProxyResponse{
		Body:       string(body),
		StatusCode: statusCode,
		Headers: map[string]string{
			"Access-Control-Allow-Origin": "*",
		},
	}
}

func response(body string, statusCode int) events.APIGatewayProxyResponse {
	return events.APIGatewayProxyResponse{
		StatusCode: statusCode,
		Body:       string(body),
		Headers: map[string]string{
			"Acces-Control-Allow-Origin": "*",
		},
	}

}
