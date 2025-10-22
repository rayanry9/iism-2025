package main

import (
	"bytes"
	"context"
	"encoding/csv"
	"fmt"
	"html/template"
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

	reader := csv.NewReader(file)
	allData, err := reader.ReadAll()
	if err != nil {
		panic(err)
	}
	config.InitDB()

	for _, user := range allData {
		var isStaff bool
		for idx := range 6 {
			user[idx] = strings.Trim(user[idx], " ")
		}
		if user[6] == "staff" {
			isStaff = true
		} else {
			isStaff = false
		}
		encodedPassword := utility.GenerateEncodedHashFromPassword(user[4])

		if _, err := config.DB.Exec(context.Background(), `insert into users (first_name, last_name, email, assigned_id, password, institute_id, role, staff) values ($1, $2, $3, $4, $5, $6, $7, $8)`, user[0], user[1], user[2], user[3], encodedPassword, user[5], 3, isStaff); err != nil {
			fmt.Printf("Failed to add to db with error: %v\nUser Data: %v\n", err, user)
			continue
		}

		m := gomail.NewMessage()
		m.SetHeader("From", "interiit.oc@iith.ac.in")
		m.SetHeader("To", user[2])
		// m.SetHeader("Cc", "interiit@iith.ac.in", "interiit.convenor@iith.ac.in")
		// m.SetHeader("Cc", "interiit.convenor@iith.ac.in")
		var year string
		if isStaff {
			year = "38th Inter IIT Staff Sports Meet"
		} else {
			year = "58th Inter IIT Sports Meet"
		}
		m.SetHeader("Subject", fmt.Sprintf("Login Details for %s 2025 Player Registration Website", year))
		eml, err := template.New("reg").Parse(string(registrationHtml))
		if err != nil {
			panic(err)
		}

		var emailData EmailData
		emailData.Name = user[0] + " " + user[1]
		emailData.Password = user[4]
		emailData.UserId = user[3]

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

	}

}
