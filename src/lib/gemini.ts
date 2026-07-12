import { GoogleGenerativeAI } from "@google/generative-ai";

// Initialize the Gemini API client
const genAI = new GoogleGenerativeAI(process.env.GEMINI_API_KEY || '');

// Get the recommended model for our use case
export const geminiModel = genAI.getGenerativeModel({ model: "gemini-pro" });
