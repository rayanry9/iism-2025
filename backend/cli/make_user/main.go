package main

import (
	"bytes"
	"context"
	"encoding/csv"
	"fmt"
	"html/template"
	"os"

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

	for _, user := range allData {
		var isStaff bool
		if user[7] == "staff" {
			isStaff = true
		} else {
			isStaff = false
		}
		encodedPassword := utility.GenerateEncodedHashFromPassword(user[5])

		if _, err := config.DB.Exec(context.Background(), `insert into users (first_name, last_name, email, assigned_id, password, institute_id, role, staff)`, user[1], user[2], user[3], user[4], encodedPassword, user[6], 3, isStaff); err != nil {
			panic(err)
		}

		m := gomail.NewMessage()
		m.SetHeader("From", "interiit.oc@iith.ac.in")
		m.SetHeader("To", user[3])
		// m.SetHeader("Cc", "interiit@iith.ac.in", "interiit.convenor@iith.ac.in")
		m.SetHeader("Cc", "interiit.convenor@iith.ac.in")
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
		emailData.Name = user[1] + " " + user[2]
		emailData.Password = user[5]
		emailData.UserId = user[8]

		var finalEmail bytes.Buffer
		if err := eml.Execute(&finalEmail, emailData); err != nil {
			panic(err)
		}

		m.SetBody("text/html", finalEmail.String())

		dialer := gomail.NewDialer("smtp.gmail.com", 587, "interiit.oc@iith.ac.in", os.Getenv("SMTP_PASSWORD"))
		if err := dialer.DialAndSend(m); err != nil {
			fmt.Println(emailData)
			panic(err)
		}

	}

}
