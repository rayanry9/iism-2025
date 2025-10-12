package utility

import "strings"

func CoalesceString(str *string) string {
	if str == nil {
		return ""
	} else {
		return strings.Trim(*str, " ")
	}
}

func ToPascalCase(str string) string {
	if len(str) == 0 {
		return ""

	} else if len(str) == 1 {
		return strings.ToUpper(str[0:1])
	} else {
		return strings.ToUpper(str[0:1]) + str[1:]
	}
}
