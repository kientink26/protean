package main

import (
	"github.com/julienschmidt/httprouter"
	"net/http"
)

func (app *application) routes() http.Handler {
	router := httprouter.New()
	router.NotFound = http.HandlerFunc(app.notFoundResponse)
	router.MethodNotAllowed = http.HandlerFunc(app.methodNotAllowedResponse)

	router.HandlerFunc(http.MethodPost, "/users", app.registerUserHandler)
	router.HandlerFunc(http.MethodPost, "/tokens/authentication", app.createAuthenticationTokenHandler)
	router.HandlerFunc(http.MethodGet, "/users/me", app.requireAuthenticatedUser(app.getUserHandler))
	router.HandlerFunc(http.MethodPatch, "/users/me", app.requireAuthenticatedUser(app.updateUserHandler))
	router.HandlerFunc(http.MethodPost, "/logout", app.requireAuthenticatedUser(app.logoutHandler))

	return app.recoverPanic(app.authenticate(router))
}
