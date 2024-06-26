package main

import (
	"log"
	"net/http"
	"os"

	"github.com/apex/gateway"
	"github.com/gin-gonic/gin"
)

func helloHandler(c *gin.Context) {
	name := c.Param("name")
	log.Println("=======================================")
	log.Println("name: " + name)
	log.Println("=======================================")
	c.String(http.StatusOK, "Hello %s, welcome to Gin API", name)
}

func welcomeHandler(c *gin.Context) {
	c.String(http.StatusOK, "Hello World from Golang")
}

func rootHandler(c *gin.Context) {
	c.JSON(http.StatusOK, gin.H{
		"text": "Welcome to gin lambda server.",
	})
}

func routerEngine() *gin.Engine {
	// set server mode
	gin.SetMode(gin.DebugMode)

	r := gin.New()

	// Global middleware
	r.Use(gin.Logger())
	r.Use(gin.Recovery())

	r.GET("/welcome", welcomeHandler)
	r.GET("/user/:name", helloHandler)
	r.GET("/", rootHandler)

	return r
}

func main() {
	port := os.Getenv("PORT")
	mode := os.Getenv("MODE")
	if port == "" {
		port = "8080"
	}
	addr := ":" + port
	log.Println("=======================================")
	log.Println("Running gin-lambda server in " + addr)
	log.Println("=======================================")
	if mode == "production" {
		log.Fatal(gateway.ListenAndServe(addr, routerEngine()))
	} else {
		log.Fatal(http.ListenAndServe(addr, routerEngine()))
	}
}
