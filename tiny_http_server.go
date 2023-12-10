package main

import (
    "flag"
    "fmt"
    "log"
    "net/http"
    "os"
)

func logMiddleware(next http.Handler) http.Handler {
    return http.HandlerFunc(func(w http.ResponseWriter, r *http.Request) {
        log.Printf("%s %s %s", r.RemoteAddr, r.Method, r.RequestURI)
        next.ServeHTTP(w, r)
    })
}

func main() {
    port := flag.Int("port", 8080, "Port to run the server on")
    dir := flag.String("dir", ".", "Directory to expose")

    flag.Parse()

    _, err := os.Stat(*dir)
    if os.IsNotExist(err) {
        log.Printf("Directory '%s' not found.\n", *dir)
        return
    }

    fileServer := http.FileServer(http.Dir(*dir))

    http.Handle("/", logMiddleware(fileServer))
    log.Printf("The HTTP server is running at 'http://localhost:%d' in the '%s' directory.\n", *port, *dir)
    err = http.ListenAndServe(fmt.Sprintf(":%d", *port), nil)
    if err != nil {
        log.Printf("Error starting server: %s", err)
    }
}
