package main

import (
	"bufio"
	"os"
	"strings"
)

func loadEnvFile(filename string) {
	file, err := os.Open(filename)
	if err != nil {
		return // Ignore if file doesn't exist
	}
	defer file.Close()
	scanner := bufio.NewScanner(file)
	for scanner.Scan() {
		line := scanner.Text()
		if strings.HasPrefix(line, "#") || len(strings.TrimSpace(line)) == 0 {
			continue
		}
		parts := strings.SplitN(line, "=", 2)
		if len(parts) == 2 {
			os.Setenv(strings.TrimSpace(parts[0]), strings.TrimSpace(parts[1]))
		}
	}
}
