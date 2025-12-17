package main

import (
	"bytes"
	"context"
	"fmt"
	"html/template"
	"os"
	"strings"

	_ "embed"

	"github.com/joho/godotenv"
	"github.com/rayanry9/iism-2025/backend/internal/config"
	"gopkg.in/gomail.v2"
)

//go:embed mail.html
var mailHtml []byte

type EmailData struct {
	Name     string
	Password string
}

func main() {

	err := godotenv.Load()
	if err != nil {
		panic(err)
	}

	config.InitDB()

	data, err := os.ReadFile("pass_email.txt")
	if err != nil {
		panic(err)
	}

	count := 0
	var emails []*gomail.Message
	for str := range strings.SplitSeq(string(data), "\n") {
		var emailData EmailData
		var id string
		fmt.Sscanf(str, "Id: %s  Pwd: %s", &id, &emailData.Password)

		var email string

		err := config.DB.QueryRow(context.Background(), `select 
			trim (trim ( 
				trim(first_name) ||' ' || trim(coalesce(middle_name, ''))
			) || ' ' ||
			trim(coalesce(last_name, ''))),email from users where assigned_id ilike $1`, id).Scan(&emailData.Name, &email)
		if err != nil {
			fmt.Printf("Error at Id: %s and error being %v\n", str, err)
			continue
		}

		eml, err := template.New("pwd").Parse(string(mailHtml))
		if err != nil {
			panic(err)
		}

		m := gomail.NewMessage()
		m.SetHeader("From", "interiit.oc@iith.ac.in")
		m.SetHeader("To", email)
		// m.SetHeader("Cc", "ma24btech11018@iith.ac.in")
		// m.SetHeader("Cc", "interiit.convenor@iith.ac.in")
		m.SetHeader("Subject", "Login Details for IISM25 Mobile App")

		var finalEmail bytes.Buffer
		if err := eml.Execute(&finalEmail, emailData); err != nil {
			panic(err)
		}

		m.SetBody("text/html", finalEmail.String())

		if count < 20 {
			emails = append(emails, m)
			fmt.Printf("\nAppended to emails user Data: email: %v id: %v  emailid:%v\n password: %v", email, id, m, emailData.Password)
			count++
		} else {
			dialer := gomail.NewDialer("smtp.gmail.com", 587, "interiit.oc@iith.ac.in", os.Getenv("SMTP_PASSWORD"))
			if err := dialer.DialAndSend(emails...); err != nil {
				fmt.Printf("\nFailed to send emails with error: %v\nUser Data: %v\n", err, emails)
				continue
			} else {
				fmt.Printf("Sucessfully sent emails to %s with password : %s\n", email, emailData.Password)
			}
			emails = []*gomail.Message{}
			count = 0
		}

	}

}
