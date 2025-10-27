package main

import (
	"bytes"
	"context"
	"crypto/rand"
	"fmt"
	"html/template"
	"io"
	"os"
	"strings"

	_ "embed"

	"github.com/joho/godotenv"
	"github.com/rayanry9/iism-2025/backend/internal/config"
	"github.com/rayanry9/iism-2025/backend/internal/utility"
	"gopkg.in/gomail.v2"
)

//go:embed registration.html
var registrationHtml []byte

type EmailData struct {
	Name     string
	UserId   string
	Password string
}

func main() {

	err := godotenv.Load()
	if err != nil {
		panic(err)
	}

	file, err := os.Open("data.csv")
	if err != nil {
		panic(err)
	}
	defer file.Close()
	readData, err := io.ReadAll(file)
	if err != nil {
		panic(err)
	}
	config.InitDB()
	var allData [][]string

	for line := range strings.SplitSeq(string(readData), "\n") {
		allData = append(allData, strings.Split(line, ","))
	}

	for _, user := range allData {
		if len(user) == 0 {
			continue
		}
		var isStaff bool
		for idx := range len(user) {
			user[idx] = strings.Trim(user[idx], " ")
		}
		if strings.Contains(user[1], "Student") {
			isStaff = false
		} else {
			isStaff = true
		}
		password := strings.ToLower(rand.Text())[:6]
		encodedPassword := utility.GenerateEncodedHashFromPassword(password)

		if _, err := config.DB.Exec(context.Background(), `insert into users (first_name, last_name, assigned_id, password, institute_id, role, staff) values ($1, $2, $3, $4, $5, $6, $7)`, user[0], user[1], user[2], encodedPassword, user[3], 3, isStaff); err != nil {
			fmt.Printf("Failed to add to db with error: %v\nUser Data: %v\n", err, user)
			continue
		}

		eml, err := template.New("reg").Parse(string(registrationHtml))
		if err != nil {
			panic(err)
		}

		m := gomail.NewMessage()
		m.SetHeader("From", "interiit.oc@iith.ac.in")
		m.SetHeader("To", user[4:]...)
		// m.SetHeader("Cc", "interiit@iith.ac.in", "interiit.convenor@iith.ac.in")
		m.SetHeader("Cc", "interiit.convenor@iith.ac.in")
		var year string
		if isStaff {
			year = "38th Inter IIT Staff Sports Meet"
		} else {
			year = "58th Inter IIT Sports Meet"
		}
		m.SetHeader("Subject", fmt.Sprintf("Login Details for %s 2025 Player Registration Website", year))

		var emailData EmailData
		emailData.Name = user[0] + " " + user[1]
		emailData.Password = password
		emailData.UserId = user[2]

		var finalEmail bytes.Buffer
		if err := eml.Execute(&finalEmail, emailData); err != nil {
			panic(err)
		}

		m.SetBody("text/html", finalEmail.String())

		dialer := gomail.NewDialer("smtp.gmail.com", 587, "interiit.oc@iith.ac.in", os.Getenv("SMTP_PASSWORD"))
		if err := dialer.DialAndSend(m); err != nil {
			fmt.Printf("\nFailed to send email with error: %v\nUser Data: %v\n", err, user)
			continue
		}
		fmt.Printf("Sucessfully sent email to %s with password : %s", user, password)
	}
}
