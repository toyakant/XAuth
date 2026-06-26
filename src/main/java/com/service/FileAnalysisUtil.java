package com.service;

import java.awt.image.BufferedImage;
import java.io.File;
import java.io.IOException;

import javax.imageio.ImageIO;

import org.apache.pdfbox.pdmodel.PDDocument;
import org.apache.pdfbox.text.PDFTextStripper;

public class FileAnalysisUtil {
	
	// Extract longest word from text or PDF
    public static String getLongestWord(File file) throws IOException {
        String name = file.getName().toLowerCase();
        String content = "";

        if (name.endsWith(".txt")) {
            content = new String(java.nio.file.Files.readAllBytes(file.toPath()));
        } else if (name.endsWith(".pdf")) {
            try (PDDocument doc = PDDocument.load(file)) {
                PDFTextStripper stripper = new PDFTextStripper();
                content = stripper.getText(doc);
            }
        } else {
            return "";
        }

        String longest = "";
        for (String word : content.split("\\s+")) {
            if (word.length() > longest.length()) longest = word;
        }
        return longest;
    }

    // Extract pixel info from image
    public static String getImagePixelInfo(File file) throws IOException {
        BufferedImage img = ImageIO.read(file);
        if (img == null) return "";

        StringBuilder sb = new StringBuilder();
        for (int y = 0; y < img.getHeight(); y++) {
            for (int x = 0; x < img.getWidth(); x++) {
                int rgb = img.getRGB(x, y);
                sb.append(rgb).append(","); // store raw pixel value
            }
        }
        return sb.toString();
    }

}
