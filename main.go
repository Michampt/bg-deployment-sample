package main

import (
	"net/http"
	"os"

	"github.com/gorilla/mux"
)

func handleRequests() {
	router := mux.NewRouter().StrictSlash(true)
	router.HandleFunc("/version", version).Methods("GET")

	server := &http.Server{
		Addr:    ":80",
		Handler: router,
	}

	server.ListenAndServe()
}

func main() {
	handleRequests()
}

func version(w http.ResponseWriter, r *http.Request) {
	response := os.Getenv("VERSION")
	w.Write([]byte(response))
}
