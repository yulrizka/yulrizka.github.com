---
layout: post
title: "Convert Intellij Live Template to vscode Snippet"
date: 2020-05-21T19:31:50+02:00
language: en
comments: true
tags: 
  - intellij
  - vscode
  - template
description: converting intellij live template to visual studio (vscode) snippet
keywords: intellij vscode template snippet
draft: false
---

If you are in the need of converting your custom intellij live tempate, 
you can use this method to transform it.

## Locate the template file
The first thing you need to is is to locate the template file. You can find it inside
the intellij settings directory which is vary per operating system. See this [documentation](https://intellij-support.jetbrains.com/hc/en-us/articles/206544519-Directories-used-by-the-IDE-to-store-settings-caches-plugins-and-logs) 
to locate it. 

For example for my golang templte in linux, I find it under

```
/home/username/.config/JetBrains/IntelliJIdea2020.1/jba_config/templates/Golang.xml
```

## Convert it into vscode snippet
You can use tihs gocode

```go
package main

import (
	"encoding/json"
	"encoding/xml"
	"fmt"
	"io/ioutil"
	"log"
	"os"
	"regexp"
	"strings"
)

type TemplateSet struct {
	XMLName  xml.Name       `xml:"templateSet"`
	Text     string         `xml:",chardata"`
	Group    string         `xml:"group,attr"`
	Template []ideaTemplate `xml:"template"`
}

type ideaTemplate struct {
	Text             string `xml:",chardata"`
	Name             string `xml:"name,attr"`
	Value            string `xml:"value,attr"`
	Description      string `xml:"description,attr"`
	ToReformat       string `xml:"toReformat,attr"`
	ToShortenFQNames string `xml:"toShortenFQNames,attr"`
	Variable         []struct {
		Text         string `xml:",chardata"`
		Name         string `xml:"name,attr"`
		Expression   string `xml:"expression,attr"`
		DefaultValue string `xml:"defaultValue,attr"`
		AlwaysStopAt string `xml:"alwaysStopAt,attr"`
	} `xml:"variable"`
	Context struct {
		Text   string `xml:",chardata"`
		Option struct {
			Text  string `xml:",chardata"`
			Name  string `xml:"name,attr"`
			Value string `xml:"value,attr"`
		} `xml:"option"`
	} `xml:"context"`
}

// "Print to console": {
// 	"prefix": "log",
// 	"body": [
// 		"console.log('$1');",
// 		"$2"
// 	],
// 	"description": "Log output to console"
// }

type snippet struct {
	Prefix      string   `json:"prefix,omitempty"`
	Body        []string `json:"body,omitempty"`
	Description string   `json:"description,omitempty"`
}

func main() {
	f, err := os.Open("Golang.xml")
	if err != nil {
		log.Fatal(err)
	}

	defer f.Close()

	raw, err := ioutil.ReadAll(f)
	if err != nil {
		log.Fatal(err)
	}

	var ts TemplateSet
	xml.Unmarshal(raw, &ts)

	snippets := map[string]snippet{}
	for i, t := range ts.Template {
		s := snippet{
			Prefix:      t.Name,
			Body:        getBody(t),
			Description: t.Description,
		}
		if _, ok := snippets[t.Description]; ok {
			log.Fatalf("duplicate key %d:%s %s", i, t.Description, t.Name)
		}
		snippets[t.Description] = s
	}

	raw, err = json.MarshalIndent(snippets, "", "\t")
	if err != nil {
		log.Fatal(err)
	}
	fmt.Printf("%s", raw)
}

var (
	rx = regexp.MustCompile(`\$\w+\$`)
)

func getBody(t ideaTemplate) []string {
	s := t.Value

	params := map[string]string{}
	match := rx.FindAllString(s, -1)
	varIdx := 1

MATCH:
	for _, v := range match {
		if _, ok := params[v]; ok {
			// already process the parameter
			continue
		}
		varname := strings.ReplaceAll(v, "$", "")

		for _, ideaVar := range t.Variable {
			if ideaVar.Name == varname {
				defaultValue := ideaVar.DefaultValue
				if defaultValue != "" {
					// process default
					replacement := fmt.Sprintf("${%d:another}", varIdx)
					varIdx++
					params[v] = replacement
					continue MATCH
				}

				// no variable found
				replacement := fmt.Sprintf("$%d", varIdx)
				varIdx++
				params[v] = replacement
			}
		}

	}

	// replace all parameters
	for varname, p := range params {
		s = strings.ReplaceAll(s, varname, p)
	}
	s = strings.ReplaceAll(s, "$END$", "")

	return strings.Split(s, "\n")
}

```

Copy the output of the file. On vscode, `Ctrl+p` to bring the command and search for `Configure User Snippet`. Chose the language and then paste it.