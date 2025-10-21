package utility

import (
	"fmt"
	_ "image/png"
	"io"
	"log/slog"
	"mime/multipart"
	"os"

	"github.com/sunshineplan/imgconv"
	_ "golang.org/x/image/webp"
)

func SaveProfilePic(img multipart.FileHeader) error {
	file, err := img.Open()
	if err != nil {
		slog.Error("Failed to open image", "error", err)
		return err
	}
	oldWriter, err := os.OpenFile(fmt.Sprintf("images/users/original/%s.png", img.Filename), os.O_CREATE+os.O_RDWR, 0755)
	if err != nil {
		slog.Error("Failed to open original image writer", "error", err)
		return err
	}
	data, err := io.ReadAll(file)
	if err != nil {
		slog.Error("Failed to read original image data", "error", err)
		return err
	}
	_, err = oldWriter.Write(data)
	if err != nil {
		slog.Error("Failed to write original image data", "error", err)
		return err
	}
	oldWriter.Close()
	file.Close()
	file, err = img.Open()
	if err != nil {
		slog.Error("Failed to open image second time", "error", err)
		return err
	}
	defer file.Close()
	pngImg, err := imgconv.Decode(file)
	if err != nil {
		slog.Error("Failed to read image", "error", err)
		return err
	}

	resizedImg := imgconv.Resize(pngImg, &imgconv.ResizeOption{Width: 200})
	newWriter, err := os.OpenFile(fmt.Sprintf("images/users/web/%s.webp", img.Filename), os.O_CREATE+os.O_RDWR, 0755)
	if err != nil {
		slog.Error("Failed to open new image writer", "error", err)
		return err
	}
	defer newWriter.Close()
	err = imgconv.Write(newWriter, resizedImg, &imgconv.FormatOption{Format: imgconv.WEBP})
	if err != nil {
		slog.Error("Failed to save image", "error", err)
		return err
	}
	return nil
}

func DeleteProfilePic(fn string) error {
	if err := os.Remove(fmt.Sprintf("images/users/web/%s.webp", fn)); err != nil {
		return err
	}
	if err := os.Remove(fmt.Sprintf("images/users/original/%s.png", fn)); err != nil {
		return err
	}
	return nil
}

func GetProfilePicFile(fp string) ([]byte, error) {
	data, err := os.ReadFile(fp)
	if err != nil {
		slog.Error("Failed to read profile pic file", "error", err)
		return nil, err
	}
	return data, nil
}
